//
//  ViewController.swift
//  RickAndMorthy
//
//  Created by Jesus Daniel Mayo on 26/01/24.
//

import UIKit

class ViewController: UIViewController {
    var pageNumber: Int = 1
    
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
        restClient.show("/api/character",page: "1") { response in
            self.characters = response.results
        }
        
        
    }
    @IBAction func backButton(_ sender: Any) {
        pageNumber -= 1
        pageNumber = pageNumber == 0 ? 0 : 1

        let pageName = String(pageNumber)
        restClient.show("/api/character", page: pageName) { response in
            self.characters = response.results
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        pageNumber += 1
        let pageName = String(pageNumber)
        restClient.show("/api/character", page: pageName) { response in
            self.characters = response.results
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
