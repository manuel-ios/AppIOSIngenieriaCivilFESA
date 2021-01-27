//
//  service.swift
//  Pods
//
//  Created by Manuel Osorio Catalan on 30/12/20.
//

import Foundation
import Firebase
class service {
    
    static func getUserInfo(onSuccess: @escaping () -> Void, onError:@escaping(_ error: Error?) -> Void){
        let ref = Database.database().reference()
        let defaults = UserDefaults.standard
        guard let uid = Auth.auth().currentUser?.uid  else {
            print("user no found")
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
    
}
