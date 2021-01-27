//
//  Alert.swift
//  appIngenieria
//
//  Created by CEDAM20 on 10/31/19.
//  Copyright © 2019 CEDAM20. All rights reserved.
//

import Foundation
import UIKit

struct Alert{
    
    private static func showAlert(en vc: UIViewController, with title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    static func showHelpAlert(on vc: UIViewController){
        showAlert(en: vc, with: "Sección de Ayuda", message: "Consejos para inicio de sesión")
    }
    
    static func showRegistrationComplete(on vc: UIViewController){
        showAlert(en: vc, with: "Registro Completado", message: "Te registraste exitosamente en la aplicación")
    }
}
