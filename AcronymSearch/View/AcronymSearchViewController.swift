//
//  ViewController.swift
//  AcronymSearch
//
//  Created by Rajesh Sammita on 05/06/22.
//

import UIKit

class AcronymSearchViewController: UIViewController {
    
   private let searchController = UISearchController(searchResultsController: nil)
   private let viewModel = AcronymListViewModel()
   @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() {
        self.title = "AcronymSearch"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Acronym"
        searchController.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func searchForMeaning() {
        guard let searchText = searchController.searchBar.searchTextField.text, !searchText.isEmpty else { return }
        viewModel.fetchLongFormList(searchText: searchText) { onComplete in
            
        }
        viewModel.acronymListModel.bind { [weak self] newsModel in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func clearSearchText() {
        viewModel.acronymListModel.value = nil
    }
    
    private func showNoResult() {
        tableView.setEmptyView(title: "No Result", message: "Long form will be shown here")
    }
    
    private func hideNoResult() {
        tableView.restore()
    }
}

extension AcronymSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let modelValue = viewModel.acronymListModel.value else {
            showNoResult()
            return 0
        }
        if modelValue.longFormList?.isEmpty ?? true {
            showNoResult()
        } else {
            hideNoResult()
        }
        return modelValue.longFormList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "acronymlistcell"),
              let dataObject = viewModel.acronymListModel.value?.longFormList?[indexPath.row] else {
                  return UITableViewCell()
              }
        cell.textLabel?.text = dataObject.longForm
        return cell
    }
}

extension AcronymSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchForMeaning()
    }
}

extension AcronymSearchViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        clearSearchText()
    }
}
