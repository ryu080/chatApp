//
//  CreateAccountViewController.swift
//  chatApp
//
//  Created by 辻野竜志 on 2023/09/11.
//

import UIKit

class CreateAccountView: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImage)))
        imageView.isUserInteractionEnabled = true
    }
    func delegate(){
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    @objc func onImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func onResister(_ sender: Any) {
        if nameField.text!.count < 3 || nameField.text!.count > 11 {
            showError(message: "名前は3字以上10字以内で設定してください。")
            return
        }
        AuthHelper().createAccount(email: emailField.text!, password: passwordField.text!, result: {
            success in
            if success {
                DatabaseHelper().resisterUserInfo(name: self.nameField.text!, image: self.imageView.image!)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showError(message: "有効なメールアドレス、6文字以上のパスワードを設定してください。")
            }
        })
    }
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func showError(message:String){
        let dialog = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(dialog, animated: true, completion: nil)
    }
}
