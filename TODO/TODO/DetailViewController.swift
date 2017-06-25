//
//  DetailViewController.swift
//  TODO
//
//  Created by 熊伟 on 2017/6/25.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    weak var preVC :ViewController?
    
    var todo: ToDoItem?
    var eventButtons:Array<UIButton> = Array()
    lazy var todoTitleLabel:UILabel = {
        let _label = UILabel.init(frame: CGRect.init(x: 34, y: 220, width: 81, height: 21))
        _label.text = "ToDoTitle:"
        _label.font = UIFont.systemFont(ofSize: 14)
        _label.textColor = UIColor.black
        
        return _label
    }()
    
    lazy var inputText:UITextView = {
        let _inputText = UITextView.init(frame: CGRect.init(x: 154, y: 216, width: 181, height: 30))
        _inputText.backgroundColor = UIColor.white
        _inputText.textColor = UIColor.black
        _inputText.layer.borderColor = UIColor.gray.cgColor
        _inputText.layer.borderWidth = 1
        _inputText.layer.cornerRadius = 5
        
        
        return _inputText
    }()
    
    
    lazy var timePicker:UIDatePicker = {
        let _timePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: 281, width: 375, height: 216))
        _timePicker.datePickerMode = .date
        _timePicker.addTarget(self, action: #selector(self.handleDatePickerValueChanged(sender:)), for: .valueChanged)
        return _timePicker
    }()
    
    
    lazy var doneButton :UIButton = {
        let _doneButton = UIButton.init(frame: CGRect.init(x: 159, y: 537, width: 50, height: 40))
        _doneButton.setTitle("Done", for: .normal)
        _doneButton.setTitleColor(UIColor.black, for: .normal)
        _doneButton.layer.borderColor = UIColor.gray.cgColor
        _doneButton.layer.borderWidth = 1
        _doneButton.layer.cornerRadius = 5
        _doneButton.addTarget(self, action: #selector(self.onDoneButtonClicked), for: .touchUpInside)
        return _doneButton
    }()

    
    //**********************************************************************************************
    //MARK: - life cycle
    //**********************************************************************************************
    init(item:ToDoItem) {
        todo = item
        super.init(nibName: nil, bundle: nil)
    }
    init() {

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupEventButtons()
        prepareDataView()
        view.addSubview(self.todoTitleLabel)
        view.addSubview(self.inputText)
        view.addSubview(self.timePicker)
        view.addSubview(self.doneButton)

    }
    
    func prepareDataView() {
        if let todo = todo {
            self.title = "Edit Todo"
            if todo.image == "1-selected"{
                eventButtons[0].isSelected = true
            }
            else if todo.image == "2-selected"{
                eventButtons[1].isSelected = true
            }
            else if todo.image == "3-selected"{
                eventButtons[2].isSelected = true
            }
            else if todo.image == "4-selected"{
                eventButtons[3].isSelected = true
            }
            inputText.text = todo.title
            timePicker.setDate(todo.date, animated: false)
            
        } else {
            title = "New Todo"
            eventButtons[0].isSelected = true
        }

    }
    
    func setupEventButtons() {
        for i in 0...3 {
            let button = UIButton.init(frame: CGRect.init(x: 34 + i*50 + i*34, y: 124, width: 50, height: 50))
            button.setImage(UIImage.init(named: String(describing: (i+1))), for: .normal)
            button.setImage(UIImage.init(named: String(describing: "\(i+1)-selected")), for: .selected)
            view.addSubview(button)
            button.addTarget(self, action: #selector(self.onEventButtonClicked(sender:)), for: .touchUpInside)
            eventButtons.append(button)
        }
    }
    
    @objc
    func onDoneButtonClicked() {
        var image = ""
        for i in 0..<eventButtons.count {
            if eventButtons[i].isSelected {
                image = "\(i+1)-selected"
                break
            }
        }

        if let todo = todo {
            todo.image = image
            if(inputText.text?.isEmpty)!
            {
                inputText.text = "Unknow Title"
            }
            todo.title = inputText.text!
            todo.date = timePicker.date
        } else {
            if(inputText.text?.isEmpty)!
            {
                inputText.text = "Unknow Title"
            }
            let uuid = UUID().uuidString
            todo = ToDoItem(id: uuid, image: image, title: inputText.text!, date: timePicker.date)
            preVC?.todos.append(todo!)
        }

        navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    func handleDatePickerValueChanged(sender:UIDatePicker) {
        print("\(sender.date)")
    }
    
    @objc
    func onEventButtonClicked(sender:UIButton) {
        sender.isSelected = true
        for item in eventButtons {
            if item != sender{
                item.isSelected = false
            }
        }
    }
    

}
