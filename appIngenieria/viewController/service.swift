//
//  service.swift
//  Pods
//
//  Created by Manuel Osorio Catalan on 30/12/20.
//

import Foundation
import Firebase
class service {
    static func signUpUser(email: String, password: String, name: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let auth = Auth.auth()
        
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                onError(error!)
                return
            }
            
            uploadToDatabase(email: email, name: name, onSuccess: onSuccess)
        }
    }
    
    static func uploadToDatabase(email: String, name: String, onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        ref.child("users").child(uid!).setValue(["email" : email, "name" : name])
        onSuccess()
    }
    static func getUserInfo(onSuccess: @escaping () -> Void, onError:@escaping(_ error: Error?) -> Void){
        let ref = Database.database().reference()
        let defaults = UserDefaults.standard
        guard let uid = Auth.auth().currentUser?.uid  else {
            print("user no found")
            return
        }
        
        ref.child("Usuarios").child(uid).observe(.value, with: {(snapshot) in
            if  let direcion = snapshot.value as? [String: Any]{
                let email = direcion["email"] as! String
                let name = direcion["name"] as! String
                defaults.set(email, forKey: "userEmailKey")
                defaults.set(name, forKey: "userNameKey")
                onSuccess()
            }
        }){(error) in
            onError(error)
        }
        
    }
    static func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        
        return alert
    }
    
}
