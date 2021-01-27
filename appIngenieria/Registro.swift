//
//  Registro.swift
//  appIngenieria
//
//  Created by CEDAM20 on 10/24/19.
//  Copyright © 2019 CEDAM20. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
class Registro: UIViewController {

    @IBOutlet weak var TextNombre: UITextField!
    @IBOutlet weak var btnRegistro: UIButton!
    @IBOutlet weak var Textpass: UITextField!
    @IBOutlet weak var TextNumcuenta: UITextField!
    @IBOutlet weak var TextEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnRegistro.layer.cornerRadius = 5.0
    }
    
    //Cambia el color de los iconos (hora, bateria, ...) del iphone a blanco
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    @IBAction func Registro(_ sender: Any) {
        
    }
    
    
}
