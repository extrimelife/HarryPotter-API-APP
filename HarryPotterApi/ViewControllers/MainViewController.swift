//
//  ViewController.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 24.09.2022.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private var harryPotter: [Character] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    //MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        harryPotter.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let harry = harryPotter[indexPath.row]
        cell.configure(with: harry)
        return cell
    }
    
    //MARK: - Private methods
    
    private func fetch() {
        NetworkManager.shared.fetchData(from: Link.harryPotterApi.rawValue) { harry in
            self.harryPotter = harry
            self.tableView.reloadData()
        }
    }
}

