//
//  ViewController.swift
//  UIKeyboardNotification_Kiet_13110085
//
//  Created by Kiet Nguyen on 5/5/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(dismiss)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyBoardWilShow(sender:)), name: NSNotification.Name.UIKeyboardDidShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func keyBoardWilShow(sender: NSNotification){
        // 1
        let userInfo = sender.userInfo!
        // 2
        let keyBoardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        let offset: CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        //3 
        if keyBoardSize.height == offset.height{
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                self.view.frame.origin.y -= keyBoardSize.height
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                self.view.frame.origin.y += keyBoardSize.height - offset.height
            })

        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo = sender.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        self.view.frame.origin.y += keyboardSize.height
    }

}

