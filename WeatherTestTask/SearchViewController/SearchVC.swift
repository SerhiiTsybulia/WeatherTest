//
//  SearchVC.swift
//  WeatherTestTask
//
//  Created by Сергей on 23.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class SearchVC: UITableViewController {
    
    let cities = ["Stambul","Kharkiv","Kyiv"]
    
    private let serachController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmoty: Bool {
        guard let text = serachController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
// MARK: - Setup search controller
        serachController.searchResultsUpdater = self
        serachController.obscuresBackgroundDuringPresentation = false
        serachController.searchBar.placeholder = "Search"
        navigationItem.searchController = serachController
        definesPresentationContext = true
        
    }
    
}

extension SearchVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    private func filterContentForSearchText(_ searchText: String)
    
}
