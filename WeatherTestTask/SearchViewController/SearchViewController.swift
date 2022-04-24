//
//  SearchViewController.swift
//  WeatherTestTask
//
//  Created by Igor Skorina on 24.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchButtonClickHandler: (() -> Void)?

    private lazy var searchViewController: SearchViewController? = {
        searchViewController?.searchButtonClickHandler = { [weak self] in
            self?.searchClicked()
        }
        return searchViewController
    }()
    
    @IBOutlet weak var searchField: UITextField!
    
    
    @IBAction func backClicked() {
        print("Back button click")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func searchClicked() {
        print("Search button click")
        searchButtonClickHandler?()
    }
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tableView.backgroundColor = UIColor.white
        
    }
    
    
}
