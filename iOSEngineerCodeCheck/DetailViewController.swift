//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var languageLabel: UILabel!
    
    @IBOutlet private weak var starsCountLabel: UILabel!
    @IBOutlet private weak var watchersCountLabel: UILabel!
    @IBOutlet private weak var forksCountLabel: UILabel!
    @IBOutlet private weak var openIssuesCountLabel: UILabel!
    
    var vc1: SearchListViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = vc1.repo[vc1.idx]
        
        languageLabel.text = "Written in \(repo["language"] as? String ?? "")"
        starsCountLabel.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        watchersCountLabel.text = "\(repo["watchers_count"] as? Int ?? 0) watchers"
        forksCountLabel.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        openIssuesCountLabel.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        let repo = vc1.repo[vc1.idx]
        
        titleLabel.text = repo["full_name"] as? String
        
        if let owner = repo["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.iconImageView.image = img
                    }
                }.resume()
            }
        }
        
    }
    
}
