//
//  AppDelegate.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow()
        
        /// Initialize and Inject Fact View Model Type to the Facts View Controller
        let factsViewModel = FactsViewModelImplementation(factsApiClient: FactsAPIClient())
        let viewController = FactsViewController(viewModel: factsViewModel)
        viewController.view.backgroundColor = .white
        
        /// Set Application's Root View Controller
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        
        window?.makeKeyAndVisible()

        return true
    }

}

