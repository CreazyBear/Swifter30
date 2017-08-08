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
        
        
        
        dispatchSource()
//        group()
//        workItem()
    }
    
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

