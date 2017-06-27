//
//  ViewController.swift
//  SectionDemo
//
//  Created by 熊伟 on 2017/6/27.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var dataSource :NSArray = NSArray()

    let cellId = "edfa"
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mine"
        view.backgroundColor = UIColor.white
        view.addSubview(self.tableView)
        setupDataSource()
        
    }
    
    func setupDataSource() {
        guard let url = Bundle.main.url(forResource: "section", withExtension: "json") else {
            return
        }

        do {
            let data = try Data(contentsOf: url)
            guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray else {
                return
            }
            dataSource = rootObject
            
            
        } catch  {
            return
        }
        
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource[section] as? NSArray)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
        if indexPath.section == 0
        {
            cell.imageView?.image = UIImage.init(named: ((dataSource[0] as? NSArray)![0] as! NSDictionary).object(forKey: "image") as! String)
        }
        return cell
    }
}

