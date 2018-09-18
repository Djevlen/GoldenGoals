//
//  AddGoalMotivationViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 01/07/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class AddGoalMotivationViewController: UIViewController {
    
    var goal = Goal()
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var motivationImage: UIImageView!
    @IBOutlet weak var motivationalText: UITextView!
    @IBOutlet weak var goldenGoalSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motivationalText.delegate = self
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let motivation = motivationalText.text, motivationalText.text != "" else {
            return false
        }
        goal.motivationalText = motivation
        goal.golden = goldenGoalSwitch.isOn
        goal.hallOfFame = "None"
        if let data = motivationImage.image!.pngData(){
            goal.photo = data as Data?
        }else{
            print("ERROR SETTING IMAGE TO GOAL")
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToMotivationalTextView"){
            let motivationalTextVC = segue.destination as! AddGoalMotivationalTextViewController
            motivationalTextVC.stringInput = motivationalText.text
            motivationalTextVC.goalTitle = goal.title!
        }
    }
    
    @IBAction func unwindFromAddingMotivationalText(_ sender: UIStoryboardSegue){
        if (sender.source is AddGoalMotivationalTextViewController){
            if let senderVC = sender.source as? AddGoalMotivationalTextViewController{
                self.motivationalText.text = senderVC.motivationalTextView.text
            }
        }
    }
    
    //present the image picker for adding an image to the goal
    @IBAction func tappedImage(_ sender: Any){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension AddGoalMotivationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            motivationImage.image = pickedImage
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
extension AddGoalMotivationViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        performSegue(withIdentifier: "segueToMotivationalTextView", sender: textView)
        textView.text = ""
        print("textViewDidBeginEditing")
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
