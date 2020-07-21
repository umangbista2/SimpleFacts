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
    func displayNoInternetStatus(_ display: Bool)
}

class FactsViewController: UIViewController {

    private let viewModel: FactsViewModel!

    private let internetStatusLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "The internet connection appears to be offline"
        lbl.backgroundColor = .white
        lbl.textColor = .lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()

    private let tableView = UITableView()

    private var refreshControl = UIRefreshControl()

    // MARK: View Controller Life Cycle
    
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
        viewModel.fetchContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear()
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
        alert(type: .alert, title: title, message: message, buttonText: buttonText) {
            self.refreshControl.endRefreshing()
        }
    }
    
    func displayNoInternetStatus(_ display: Bool) {
        title = nil
        internetStatusLabel.isHidden = !display
    }
}

// MARK: - Events

extension FactsViewController {
    @objc private func refresh(_ sender: Any) {
        viewModel.fetchContent()
    }
}

// MARK: - Helpers

extension FactsViewController {
    
    private func setupViews() {
        title = "Facts"
        
        setupTableView()
        setupInternetStatusView()
        setupRefreshControl()
        displayNoInternetStatus(false)
    }
    
    private func setupInternetStatusView() {
        view.insertSubview(internetStatusLabel, aboveSubview: tableView)
        
        internetStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        internetStatusLabel.anchor(top: view.layoutMarginsGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
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
        let rows = viewModel.numberOfRows(inSection: section)
        if rows == 0 {
            tableView.setMessage(viewModel.statusMessage)
        } else {
            tableView.removeMessage()
        }
        return rows

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FactTableViewCell.reuseIdentifier, for: indexPath) as! FactTableViewCell
        cell.fact = viewModel.factForRow(atIndexPath: indexPath)
        return cell
    }
    
}
