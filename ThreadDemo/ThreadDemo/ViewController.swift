//
//  ViewController.swift
//  ThreadDemo
//
//  Created by Bear on 2017/8/8.
//  Copyright © 2017年 Bear. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = UITextView.init()
        textView.text = "hello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello world"
        textView.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(textView)
        textView.isUserInteractionEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
//MARK: - gesture 不会导致runloop切换mode。
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(handleLablePanGesture(gesture:)))
        textView.addGestureRecognizer(panGesture)
        
        
        runloopDemo()
        
        
        
        // 创建观察者
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0) { (boserver, activity) in
            print("监听到RunLoop发生改变---\(activity)")
        }
        
        // 添加观察者到当前RunLoop中
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, CFRunLoopMode.defaultMode);

    }
    
    
    func handleLablePanGesture(gesture:UIPanGestureRecognizer) {
        let point = gesture.translation(in: gesture.view)
        gesture.view?.transform = (gesture.view?.transform.translatedBy(x: point.x, y: point.y))!
        gesture.setTranslation(CGPoint.zero, in: gesture.view)
    }
    
    
    //MARK: - RunLoop
    func runloopDemo() {
        var counter = 1
        let timer = Timer.init(timeInterval: 2, repeats: true) { (timer) in
            
            print("timer trigger---\(Date.init())---\(counter)")
            counter += 1
            if counter == 100{
                timer.invalidate()
            }
        }
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    
    
    
    //MARK: - Thread
    func threadDemo() {
        let customThread = Thread.init { 
            print("thread---手动启动---\(Date.init())---\(Thread.current)")
        }
        customThread.start()
        
        
        Thread.detachNewThread {
            print("thread---自动启动---\(Date.init())---\(Thread.current)")
        }
        
        
    }
    
    
    //MARK: - Operation
    func operationDemo() {
        
        let queue = OperationQueue.init()
        print("start-------")

        let operation1 = BlockOperation.init { 
            print("operation---1---\(Date.init())---\(Thread.current)")
        }
        let operation2 = BlockOperation.init {
            print("operation---2---\(Date.init())---\(Thread.current)")
            sleep(3)
        }
        let operation3 = BlockOperation.init {
            print("operation---3---\(Date.init())---\(Thread.current)")
        }
        
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)
        
        
        operation2.addObserver(self, forKeyPath: "isFinished", options: .new, context: nil)
        
        
        queue.addOperation(operation1)
        queue.addOperation(operation2)
        queue.addOperation(operation3)
        print("end-------")
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "isFinished"
        {
            print("\(String(describing: change?[NSKeyValueChangeKey.newKey]))")
        }
    }
    
    
    
    
//************************************************************************
// MARK: -  GCD
//*************************************************************************
    
    func dispatchSource() {
        var count = 0
        let queue = DispatchQueue.init(label: "com.bear.thread", attributes: .concurrent)
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.setEventHandler(handler: DispatchWorkItem{
            print("hello world")
            count += 1
            if count >= 5 {
                timer.cancel()
            }
        })
//        timer.scheduleOneshot(deadline: .now())
        timer.scheduleRepeating(deadline: .now() + 3, interval: .seconds(1))
        timer.resume()
    }
    
    
    
    func workItem(){
        let queue = DispatchQueue.init(label: "com.bear.thread", attributes: .concurrent)
        let dispatchWorkItem : DispatchWorkItem = DispatchWorkItem.init { 
            print("hello")
        }
        dispatchWorkItem.perform()
        dispatchWorkItem.notify(queue: queue) { 
            print("world")
        }
        
    }
    
    
    func dispatchAfter() {
        
        let queue = DispatchQueue.init(label: "com.bear.thread", attributes: .concurrent)
        queue.asyncAfter(deadline: DispatchTime.now() + 3) {
            print("hello")
        }
    }
    
    func group() {
        let queue = DispatchQueue.init(label: "com.bear.thread", attributes: .concurrent)
        let group = DispatchGroup.init()
        let sem = DispatchSemaphore.init(value: 0)
        
        queue.async(group: group) { 
            sem.signal()
            print("group 1")
        }
        queue.async(group: group) {
            sem.signal()
            print("group 2")
        }
        queue.async(group: group) {
            sem.signal()
            print("group 3")
        }
        queue.async(group: group) {
            sem.signal()
            print("group 4")
        }
        
        
//        group.notify(queue: queue) { 
//            sem.wait()
//            sem.wait()
//            sem.wait()
//            sem.wait()
//            
//            print("end")
//        }
        var a = 5
        let workItem : DispatchWorkItem = DispatchWorkItem {
            sem.wait()
            sem.wait()
            sem.wait()
            sem.wait()
            
            a += 2
            print("\(a)")
        }
        group.notify(queue: queue, work: workItem)
        
    }
    
    

    func barrier() {

        let queue = DispatchQueue.init(label: "com.bear.thread", attributes: .concurrent)
        queue.async {
            print("1----\(Thread.current)")
        }
        queue.async {
            print("2----\(Thread.current)")
        }
        queue.async {
            print("3----\(Thread.current)")
        }
        queue.async {
            print("1----\(Thread.current)")
        }
        queue.async {
            print("2----\(Thread.current)")
        }
        queue.async {
            print("3----\(Thread.current)")
        }
        
        queue.async(flags: .barrier) { 
            print("----barrier----")
        }
        
        queue.async {
            print("4----\(Thread.current)")
        }
        queue.async {
            print("5----\(Thread.current)")
        }
        queue.async {
            print("4----\(Thread.current)")
        }
        queue.async {
            print("5----\(Thread.current)")
        }

        queue.async(flags: .barrier) {
            print("----barrier----")
        }

        queue.async {
            print("6----\(Thread.current)")
        }
        queue.async {
            print("7----\(Thread.current)")
        }
        queue.async {
            print("6----\(Thread.current)")
        }
        queue.async {
            print("7----\(Thread.current)")
        }
        

    
    }
    
    


}

