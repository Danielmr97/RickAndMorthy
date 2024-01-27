//
//  ViewController.swift
//  RickAndMorthy
//
//  Created by Jesus Daniel Mayo on 26/01/24.
//

import UIKit

class ViewController: UIViewController {
    var pageNumber: Int = 1
    var isLoadDatta = false
    
    
    let restClient = RESTClient<PaginatedResponse<Character>>(client: Client("https://rickandmortyapi.com"))
    
    var characters: [Character]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        restClient.show("/api/character",page: "1") { response in
            self.characters = response.results
        }
        
        
    }
    
    func loadData(){
        guard !isLoadDatta else{return}
        
        isLoadDatta = true
        let pageName = String(pageNumber)
        restClient.show("/api/character", page: pageName) { response in
            self.characters?.append(contentsOf: response.results)
            self.tableView.reloadData()
            self.isLoadDatta = false
        }
    }
    
    
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = characters?[indexPath.row].name
        cell.detailTextLabel?.text = characters?[indexPath.row].species
        
        return cell
    }
}

extension ViewController : UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let chargeviews = indexPaths.contains {$0.row >= self.characters!.count - 5}
        if chargeviews{
            pageNumber += 1
            loadData()
        }
        
    }
}
