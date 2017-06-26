//
//  ViewController.swift
//  AppleNews
//
//  Created by 熊伟 on 2017/6/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    fileprivate let feedParser = FeedParser()
    
    var dataSource:[(title: String, description: String, pubDate: String)]?
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.cellId())
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(self.tableView)
        feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
            self?.dataSource = rssItems
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }

}


extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.cellId(), for: indexPath)
        
        guard dataSource != nil && (dataSource?.count)! > indexPath.row else {
            return cell
        }
        let model:(title: String, description: String, pubDate: String) = (dataSource?[indexPath.row])!
        (cell as! NewsTableViewCell).bindData(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard dataSource != nil && (dataSource?.count)! > indexPath.row else {
            return 0
        }
        let model:(title: String, description: String, pubDate: String) = (dataSource?[indexPath.row])!
        return NewsTableViewCell.heightForCell(model: model)
    }
    
}
