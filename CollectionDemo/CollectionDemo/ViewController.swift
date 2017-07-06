//
//  ViewController.swift
//  CollectionDemo
//
//  Created by Bear on 2017/7/6.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var tableView : UITableView = {
        let view : UITableView = UITableView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = UIColor.white
        view.delegate = self
        view.dataSource = self;
        view.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return view
    }()
    
    let dataSource = ["Simple Demo","Self define layout demo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection Demo"
        view.addSubview(tableView)
        
        self.view.backgroundColor = UIColor.white;
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0)
        {
            let vc = SimpleDemoViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        else{
            
        }
    }
    
}
