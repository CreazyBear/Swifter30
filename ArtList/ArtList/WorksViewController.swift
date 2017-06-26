//
//  WorksViewController.swift
//  ArtList
//
//  Created by Bear on 2017/6/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class WorksViewController: UIViewController {

    var model:Artist?
    let cellID = "CELLID"
    
    lazy var table:UITableView = {
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        table.backgroundColor = UIColor.white
        table.delegate = self
        table.dataSource = self
        table.register(WorkDetailTableViewCell.self, forCellReuseIdentifier: self.cellID)
        return table
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(model:Artist) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = model?.name
        view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.table)
    }

}

extension WorksViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.works.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let work = model?.works[indexPath.row]
        if cell.isKind(of: WorkDetailTableViewCell.self)
        {
            (cell as! WorkDetailTableViewCell).bindData(model: work!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
