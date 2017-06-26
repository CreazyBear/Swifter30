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
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellID)
        let artist = artlistDataSource[indexPath.row]
        cell.imageView?.image = artist.image
        cell.imageView?.frame = CGRect.init(x: 0, y: 0, width: 50, height: 80)
        cell.textLabel?.text = artist.name
        cell.detailTextLabel?.text = artist.bio
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let artist = artlistDataSource[indexPath.row]
        let height = CGFloat(artist.image.cgImage!.height)
        return height
    }
}

