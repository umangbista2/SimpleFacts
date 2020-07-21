//
//  FactsViewController.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import UIKit

protocol FactsView: class {    
    func update()
    func showAlert(title: String, message: String, buttonText: String)
}

class FactsViewController: UIViewController {

    private let viewModel: FactsViewModel!

    private let tableView = UITableView()

    private var refreshControl = UIRefreshControl()

    init(viewModel: FactsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        viewModel.fetchContent()
    }

}

// MARK: - View Protocol

extension FactsViewController: FactsView {
    
    func update() {
        refreshControl.endRefreshing()

        title = viewModel.title

        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String, buttonText: String) {
        alert(type: .alert, title: title, message: message, buttonText: buttonText)
    }
    
}

// MARK: - Events

extension FactsViewController {
    @objc
    private func refresh(_ sender: Any) {
        viewModel.fetchContent()
    }
}

// MARK: - Helpers

extension FactsViewController {
    
    private func setupViews() {
        title = "Facts"
        
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.anchor(top: view.layoutMarginsGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.register(FactTableViewCell.self, forCellReuseIdentifier: FactTableViewCell.reuseIdentifier)
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
}

// MARK: - Table View

extension FactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FactTableViewCell.reuseIdentifier, for: indexPath) as! FactTableViewCell
        cell.fact = viewModel.factForRow(atIndexPath: indexPath)
        return cell
    }
    
}
