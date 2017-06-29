//
//  ViewController.swift
//  UIAnimateDemo
//
//  Created by Bear on 2017/6/29.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let cellId = "CELLID"
    // MARK: - Variables
    fileprivate let items = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position",
                             "Color and Frame Change", "View Fade In", "Pop"]
    
    lazy var tableView : UITableView = {
        let view : UITableView = UITableView.init(frame: self.view.bounds)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.white
        view.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIAnimationDemo"
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        animateTable()
    }
    
    func animateTable()
    {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        
        // move all cells to the bottom of the screen
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        // move all cells from bottom to the right place
        var index = 0
        for cell in cells
        {
            UIView.animate(withDuration: 1.5,
                           delay: 0.05 * Double(index),
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: [],
                           animations:
                {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            },
                           completion: nil)
            index += 1
        }
    }


}


extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController(animate: items[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

