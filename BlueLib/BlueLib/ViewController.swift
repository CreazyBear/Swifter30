//
//  ViewController.swift
//  BlueLib
//
//  Created by 熊伟 on 2017/7/1.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private Variables
    fileprivate var allAlbums = [Album]()
    fileprivate var currentAlbumData : (titles:[String], values:[String])?
    fileprivate var currentAlbumIndex = 0
    // use a stack to push and pop operation for the undo option
    fileprivate var undoStack: [(Album, Int)] = []
    
    lazy var toolbar : UIToolbar = {
        let view : UIToolbar = UIToolbar.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height-40, width: UIScreen.main.bounds.width, height: 40))
        
        let undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action:#selector(ViewController.undoAction))
        undoButton.isEnabled = false;
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:nil, action:nil)
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target:self, action:#selector(ViewController.deleteAlbum))
        let toolbarButtonItems = [undoButton, space, trashButton]
        view.setItems(toolbarButtonItems, animated: true)
        
        return view
    }()
    
    lazy var scroller : HorizontalScroller = {
        let view : HorizontalScroller = HorizontalScroller.init(frame: CGRect.init(x: 0, y: 24, width: UIScreen.main.bounds.width, height: 120))
        view.delegate = self
        
        return view
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 144, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-120))
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(toolbar)
        view.addSubview(tableView)
        view.addSubview(scroller)
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.saveCurrentState), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        setupData()
        setupUI()
        setupComponents()
        showDataForAlbum(currentAlbumIndex)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    func setupData() {
        currentAlbumIndex = 0
        allAlbums = LibraryAPI.sharedInstance.getAlbums()
    }
    
    func setupComponents() {
        tableView.backgroundView = nil
        loadPreviousState()
        scroller.delegate = self
        reloadScroller()
    }
    
    // MARK: - Memento Pattern
    func saveCurrentState() {
        // When the user leaves the app and then comes back again, he wants it to be in the exact same state
        // he left it. In order to do this we need to save the currently displayed album.
        // Since it's only one piece of information we can use NSUserDefaults.
        UserDefaults.standard.set(currentAlbumIndex, forKey: "currentAlbumIndex")
        LibraryAPI.sharedInstance.saveAlbums()
    }
    
    
    func loadPreviousState() {
        currentAlbumIndex = UserDefaults.standard.integer(forKey: "currentAlbumIndex")
        showDataForAlbum(currentAlbumIndex)
    }
    
    // MARK: - Scroller Related
    func reloadScroller() {
        allAlbums = LibraryAPI.sharedInstance.getAlbums()
        if currentAlbumIndex < 0 {
            currentAlbumIndex = 0
        } else if currentAlbumIndex >= allAlbums.count {
            currentAlbumIndex = allAlbums.count - 1
        }
        scroller.reload()
        showDataForAlbum(currentAlbumIndex)
    }
    
    
    
    func showDataForAlbum(_ index: Int) {
        if index < allAlbums.count && index > -1 {
            let album = allAlbums[index]
            currentAlbumData = album.ae_tableRepresentation()
        } else {
            currentAlbumData = nil
        }
        
        tableView.reloadData()
    }
    
    
    func deleteAlbum() {
        // get album
        let deletedAlbum : Album = allAlbums[currentAlbumIndex]
        // add to stack
        let undoAction = (deletedAlbum, currentAlbumIndex)
        undoStack.insert(undoAction, at: 0)
        // use library API to delete the album
        LibraryAPI.sharedInstance.deleteAlbum(currentAlbumIndex)
        reloadScroller()
        // enable the undo button
        let barButtonItems = toolbar.items! as [UIBarButtonItem]
        let undoButton : UIBarButtonItem = barButtonItems[0]
        undoButton.isEnabled = true
        // disable trashbutton when no albums left
        if (allAlbums.count == 0) {
            let trashButton : UIBarButtonItem = barButtonItems[2]
            trashButton.isEnabled = false
        }
    }
    
    func undoAction() {
        let barButtonItems = toolbar.items! as [UIBarButtonItem]
        // pop to undo the last one
        if undoStack.count > 0 {
            let (deletedAlbum, index) = undoStack.remove(at: 0)
            addAlbumAtIndex(deletedAlbum, index: index)
        }
        // disable undo button when no albums left
        if undoStack.count == 0 {
            let undoButton : UIBarButtonItem = barButtonItems[0]
            undoButton.isEnabled = false
        }
        // enable the trashButton as there must be at least one album there
        let trashButton : UIBarButtonItem = barButtonItems[2]
        trashButton.isEnabled = true
    }
    
    func addAlbumAtIndex(_ album: Album,index: Int) {
        LibraryAPI.sharedInstance.addAlbum(album, index: index)
        currentAlbumIndex = index
        reloadScroller()
    }
    
}


// MARK: - HorizontalScroller
extension ViewController: HorizontalScrollerDelegate {
    func numberOfViewsForHorizontalScroller(_ scroller: HorizontalScroller) -> Int {
        return allAlbums.count
    }
    
    func horizontalScrollerViewAtIndex(_ scroller: HorizontalScroller, index: Int) -> UIView {
        let album = allAlbums[index]
        let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), albumCover: album.coverUrl)
        
        if currentAlbumIndex == index {
            albumView.highlightAlbum(true)
        } else {
            albumView.highlightAlbum(false)
        }
        
        return albumView
    }
    
    func horizontalScrollerClickedViewAtIndex(_ scroller: HorizontalScroller, index: Int) {
        let previousAlbumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
        previousAlbumView.highlightAlbum(false)
        
        currentAlbumIndex = index
        
        let albumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
        albumView.highlightAlbum(true)
        
        showDataForAlbum(currentAlbumIndex)
    }
    
    func initialViewIndex(_ scroller: HorizontalScroller) -> Int {
        return currentAlbumIndex
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let albumData = currentAlbumData {
            return albumData.titles.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cellid")
        
        if let albumData = currentAlbumData {
            cell.textLabel?.text = albumData.titles[(indexPath as NSIndexPath).row]
            cell.detailTextLabel?.text = albumData.values[(indexPath as NSIndexPath).row]
        }
        
        return cell
    }
}




