//
//  ViewController.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 24.09.2022.
//

import UIKit

final class MainViewController: UITableViewController {
    
    //MARK: - Privet properties
    
    private var harryPotter: [Character] = []
    private var filteredCharacter: [Character] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        fetch()
        setupSearchBar()
    }
    
    
    //MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCharacter.count : harryPotter.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let character = isFiltering ? filteredCharacter[indexPath.row] : harryPotter[indexPath.row]
        cell.configure(with: character)
        cell.selectionStyle = .none
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoVc = segue.destination as? InfoViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let harryPotter = isFiltering ? filteredCharacter[indexPath.row] : harryPotter[indexPath.row]
        infoVc.character = harryPotter
    }
    
    //MARK: - Private methods
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = .white
        definesPresentationContext = true
        
    }
    
    private func fetch() {
        NetworkManager.shared.fetchData(from: Link.harryPotterApi.rawValue) { harry  in
            self.harryPotter = harry
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchText: searchController.searchBar.text ?? "")
    }
    
    func filterContent(searchText: String) {
        filteredCharacter = harryPotter.filter({ character in
            character.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
