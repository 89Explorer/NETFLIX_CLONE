//
//  SearchViewController.swift
//  NETFLIX_CLONE
//
//  Created by 권정근 on 7/3/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: Variables
    private var titles: [Title] = []
    
    // MARK: UI Components
    // discoverTable은 새로 만든 getDiscoverMulti함수 제대로 동작하는지 확인하기 위함
//    private let discoverTable: UITableView = {
//        let table = UITableView()
//        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
//        return table
//    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or Tv or Person"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Searh"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        //view.addSubview(discoverTable)
        //discoverTableDelegate()
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label
        
        searchControllerDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        discoverTable.frame = view.bounds
    }
    
    // MARK: Functions
//    private func discoverTableDelegate() {
//        discoverTable.delegate = self
//        discoverTable.dataSource = self
//    }
    
    private func searchControllerDelegate() {
        searchController.searchResultsUpdater = self
    }
    
}

// MARK: Extensions
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: (title.original_name ?? title.original_title) ?? "UnKnown", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let keyWord = searchBar.text,
              !keyWord.trimmingCharacters(in: .whitespaces).isEmpty,
              keyWord.trimmingCharacters(in: .whitespaces).count >= 2,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        APICaller.shared.getDiscoverMulti(with: keyWord) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    DispatchQueue.main.async {
                        resultsController.titles = titles
                        resultsController.searchResultsCollectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
