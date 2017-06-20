//
//  ViewController.swift
//  UIElements
//
//  Created by Bear on 2017/6/20.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellIdentify = "cellIdentify"
    let elements:[String] = {
        let eles = ["Label","Text","Gesture"]
        return eles
    }()
    
    let tableView :UITableView = {
        let tableView:UITableView = UITableView.init()
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "UIElements"
        self.setupTableView()
        
    }
    
    fileprivate func setupTableView(){
        self.tableView.frame = self.view.bounds
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentify)
        self.view.addSubview(self.tableView)
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentify)
        cell?.textLabel?.text = self.elements[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc:UIViewController?;
        if(elements[indexPath.row] == "Label")
        {
            vc = UILabelViewController()
            
        }
        else if(elements[indexPath.row] == "Text")
        {
            vc = UITextViewController()
        }
        else if(elements[indexPath.row] == "Gesture")
        {
            vc = GetureViewController()
        }
        guard vc != nil else {
            return;
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
