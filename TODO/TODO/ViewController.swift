//
//  ViewController.swift
//  TODO
//
//  Created by 熊伟 on 2017/6/25.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

//**********************************************************************************************
//MARK: - util
//这种写法~！23333
//**********************************************************************************************

func dateFromString(_ date: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: date)
}

func stringFromDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}


class ViewController: UIViewController {

    let cellId = "CellId"
    var todos: [ToDoItem] = []
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TODO"
        view.backgroundColor = UIColor.white
        setupNav()
        setupDataSource()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    func setupTableView() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-64))
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
    }
    
    
    func setupDataSource() {
        todos = [ToDoItem(id: "1", image: "1-selected", title: "Go to Disney", date: dateFromString("2014-10-20")!),
                 ToDoItem(id: "2", image: "2-selected", title: "Cicso Shopping", date: dateFromString("2014-10-28")!),
                 ToDoItem(id: "3", image: "3-selected", title: "Phone to Jobs", date: dateFromString("2014-10-30")!),
                 ToDoItem(id: "4", image: "4-selected", title: "Plan to Europe", date: dateFromString("2014-10-31")!)]
    }

    func setupNav() {
        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem.init(title: "Add", style: .plain, target: self, action: #selector(self.onAddButtonClicked))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func onAddButtonClicked() {
        
        let detailViewController = DetailViewController.init()
        detailViewController.preVC = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func setCellWithTodoItem(_ cell: UITableViewCell, todo: ToDoItem) {
        
        cell.imageView?.image = UIImage(named: todo.image)
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = stringFromDate(todo.date)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController.init(item: todos[indexPath.row])
        detailViewController.preVC = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellId)
        guard todos.count>indexPath.row else {
            return cell
        }
        cell.selectionStyle = .none
        setCellWithTodoItem(cell, todo: todos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
    // Delete the cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            todos.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    //这两个函数用于移动cell
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
    }

}

