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

    private var repo: GitHubResponse?

    var task: URLSessionTask?
    var idx: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let detailVC = segue.destination as? DetailViewController, let repo = repo {
                detailVC.repo = repo
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let repo = repo {
            let repo = repo.items[indexPath.row]
            cell.textLabel?.text = repo.fullName
            cell.detailTextLabel?.text = repo.language
            cell.tag = indexPath.row
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }

    // MARK: - API
    private func getGitHubResponse(query: String) {
        GitHubAPI.shared.searchRepository(keyValue: ["q": query]) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let gitHubResponse):
                print("DEBUG: gitHubResponse:: \(gitHubResponse)")
                strongSelf.repo = gitHubResponse
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
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text, !word.isEmpty else {
            return
        }
        getGitHubResponse(query: word)
    }
}
