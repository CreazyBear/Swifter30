//
//  ViewController.swift
//  PhoneHistory
//
//  Created by Bear on 2017/6/15.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    fileprivate var products: [Product]?
    fileprivate let identifer = "productCell"
    fileprivate var navigationTitle :String
    fileprivate lazy var tableView :UITableView = {
        let table = UITableView.init()
        table.backgroundColor = UIColor.white
        table.register(UITableViewCell.self, forCellReuseIdentifier: self.identifer)
        table.frame = self.view.bounds
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    init() {
        navigationTitle = "PhoneList"
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(title:String)
    {
        //未初始化时，属性是不被赋值的，因为其内存空间不存在
        //so,下面两行代码不能对调
        self.init()
        navigationTitle = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        navigationTitle = "PhoneList"
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.title = navigationTitle
        self.view.addSubview(self.tableView)
        
        products = [
            Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
            Product(name: "1921 Dial Phone", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
            Product(name: "1937 Desk Set", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
            Product(name: "1984 Moto Portable", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")
        ]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifer)!
        guard let products = products else { return cell }
        
        cell.textLabel?.text = products[(indexPath as NSIndexPath).row].name
        
        if let imageName = products[(indexPath as NSIndexPath).row].cellImageName {
            cell.imageView?.image = UIImage(named: imageName)
        }
        
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94.0
    }
}

