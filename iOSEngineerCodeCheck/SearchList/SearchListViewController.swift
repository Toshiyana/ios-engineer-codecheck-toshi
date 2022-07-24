//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchListViewController: UITableViewController {
    @IBOutlet private weak var searchBar: UISearchBar!

    private var repoItems: [RepoItem]?
    private var repoItemsIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        searchBar.delegate = self
        searchBar.placeholder = "リポジトリ名で検索"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let detailVC = segue.destination as? DetailViewController, let repoItems = repoItems {
                detailVC.repoItem = repoItems[repoItemsIndex ?? 0]
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoItems?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let repoItems = repoItems {
            let repoItem = repoItems[indexPath.row]
            cell.textLabel?.text = repoItem.fullName
            cell.detailTextLabel?.text = repoItem.language
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repoItemsIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }

    // MARK: - API
    private func getGitHubResponse(query: String) {
        GitHubAPI.shared.searchRepository(keyValue: ["q": query]) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let gitHubResponse):
                print("DEBUG: gitHubResponse:: \(gitHubResponse)")
                strongSelf.repoItems = gitHubResponse.items
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            case .failure(let error):
                print("getGitHubResponse error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text, !word.isEmpty else {
            return
        }
        getGitHubResponse(query: word)
    }
}
