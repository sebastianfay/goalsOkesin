//
//  AddGoalViewController.swift
//  Goals
//
//  Created by Sebastian Fay on 11/8/18.
//  Copyright © 2018 Sebastian Fay. All rights reserved.
//

import UIKit

class AddGoalViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var addGoal: UIButton!
    @IBOutlet weak var cancelAddGoal: UIButton!
    @IBOutlet weak var goBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        textView.becomeFirstResponder()
    }
    
    //MARK: Actions
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }

        let keybaordHeight = keyboardFrame.cgRectValue.height - 10

        goBottomConstraint.constant = keybaordHeight + goBottomConstraint.constant
        cancelBottomConstraint.constant = keybaordHeight + cancelBottomConstraint.constant
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func submitGoal(_ sender: UIButton) {
    }
    
    @IBAction func cancelSubmitGoal(_ sender: UIButton) {
        dismiss(animated: true)
        textView.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddGoalViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if addGoal.isHidden {
            textView.text.removeAll()
            self.addGoal.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
