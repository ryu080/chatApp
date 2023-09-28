//
//  ViewController.swift
//  chatApp
//
//  Created by 辻野竜志 on 2023/09/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uid = AuthHelper().uid()
        if uid == "" {
            performSegue(withIdentifier: "login", sender: nil)
        } else {
            print(uid)
            //チャットリストを表示する
        }
    }
    @IBAction func onLogOut(_ sender: Any) {
        AuthHelper().signout()
        performSegue(withIdentifier: "login", sender: nil)
    }
    
}

