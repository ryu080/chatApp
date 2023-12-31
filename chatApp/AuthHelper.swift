//
//  AuthHelper.swift
//  chatApp
//
//  Created by 辻野竜志 on 2023/09/11.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class AuthHelper {
    
    func createAccount(email:String,password:String,result:@escaping(Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                result(true)
            } else {
                print("create-account:\(error!)")
                result(false)
            }
        }
    }
    
    func login(email:String,password:String,result:@escaping(Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            authResult, error in
            if error == nil {
                result(true)
            } else {
                print("signin:\(error!)")
                result(false)
            }
        })
    }
    
    func uid() -> String {
        guard let user = Auth.auth().currentUser else { return "" }
        return user.uid
    }
    
    func signout(){
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out")
        }
    }
    
}
