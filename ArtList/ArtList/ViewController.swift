//
//  ViewController.swift
//  ArtList
//
//  Created by Bear on 2017/6/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let artlistDataSource = Artist.artistsFromBundle()
    let cellID = "CELLID"
    
    lazy var table:UITableView = {
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        table.backgroundColor = UIColor.white
        table.delegate = self
        table.dataSource = self
        table.register(ArtistTableViewCell.self, forCellReuseIdentifier: self.cellID)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ArtList"
        view.backgroundColor = UIColor.white
        view.addSubview(self.table)
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artlistDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.selectionStyle = .none
        let artist = artlistDataSource[indexPath.row]
        if cell.isKind(of: ArtistTableViewCell.self)
        {
            (cell as! ArtistTableViewCell).bindData(model: artist)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row<artlistDataSource.count else {
            return
        }
        let artist = artlistDataSource[indexPath.row]
        let workVC = WorksViewController.init(model: artist)
        navigationController?.pushViewController(workVC, animated: true)
    }
}

