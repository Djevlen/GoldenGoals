//
//  AddingGoalController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 08/03/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class AddingGoalController: UIViewController {
    
    
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var motivationLabel: UITextView!
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var schedulerButton: UIButton!
    
    let inputText = ["Add Goal Title","Add Tags","Add Motivational Text"]
    var inputs = [String]()
    var inputCounter = 0

    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func finishedButton(_ sender: Any) {
        print("pressed the button")
        guard let textInput = textField.text, textInput != "" else{
            textField.placeholder?.append("!!!!")
            print("in guard let")
            return
        }
        print("after guard let")
        inputs.append(textField.text!)
        if(inputCounter == 0){
            goalTitleLabel.text! = textField.text!
            goalTitleLabel.isHidden = false
        }else if inputCounter == 1{
            tagsLabel.text! = textField.text!
            tagsLabel.isHidden =  false
        }else if inputCounter == 2{
            motivationLabel.text! = textField.text!
            motivationLabel.isHidden = false
            navigationButton.isHidden = true
            schedulerButton.isHidden = false
        }
        inputCounter += 1
        textField.text = nil
        if inputCounter < 3{
            textField.placeholder = inputText[inputCounter]
        }
        print("counter is  \(inputCounter)")
        
        //TODO: add to core data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigationController()
        textField.placeholder = inputText[inputCounter]
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationController(){
//        navigationItem.title = "Add New Goal"
//        navigationItem.largeTitleDisplayMode = .never
        
        
        
    }
}

// TODO: create struct Goal to fill with info

