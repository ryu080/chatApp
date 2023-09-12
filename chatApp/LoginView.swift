//
//  LoginView.swift
//  chatApp
//
//  Created by 辻野竜志 on 2023/09/12.
//

import UIKit

class LoginView: UIViewController {

    @IBOutlet weak var emailFieild: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if AuthHelper().uid() != "" {
            dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        AuthHelper().login(email: emailFieild.text!, password: passwordField.text!, result: {
            sucess in
            if sucess {
                self.dismiss(animated: true, completion: nil)
                print("ログイン成功")
            } else {
                self.showError(message: "メールアドレス、またはパスワードが間違っています。")
            }
        })
    }
    
    func showError(message:String){
        let dialog = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(dialog, animated: true, completion: nil)
    }
    
}
