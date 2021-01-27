//
//  InicioSesion.swift
//  appIngenieria
//
//  Created by CEDAM20 on 10/22/19.
//  Copyright © 2019 CEDAM20. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class InicioSesion: UIViewController {
    
    // MARK: - Propiedades
    
    
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var btnReportError: UIButton!
    @IBOutlet weak var btnHelp: UIButton!
    @IBOutlet weak var btnInicioSesion: UIButton!
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passText: HideShowPasswordTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureElements()
       
    }
    
    //Cambia el color de los iconos (hora, bateria, ...) del iphone a blanco
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: - Funciones
    
    func configureElements(){
        btnReportError.layer.cornerRadius = 20.0
        btnHelp.layer.cornerRadius = 20.0
        btnInicioSesion.layer.cornerRadius = 5.0
        
        //Agrega la imagen de fondo.
        let wallpaper = UIImageView(frame: UIScreen.main.bounds)
        wallpaper.image = UIImage(named: "piedra")
        self.view.insertSubview(wallpaper, at: 0)
        
        //Redondea esquinas vista
        vista.layer.cornerRadius = 10.0
        //backgrouncolor textfield
       // passText.backgroundColor = .white
        emailText.backgroundColor = .white
    }

    @IBAction func btnHelpTapped(_ sender: Any) {
        Alert.showHelpAlert(on: self)
    }
    
    @IBAction func Acceso(_ sender: Any) {
        let email = emailText.text
        let password = passText.text
        
        
        
        if let email = email, let password = password {
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil{
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                
                }else {
                    let alert = UIAlertController(title: "Verificar tu cuenta", message:"Por favor verificar tu correo electronico/Contrasena", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    
                }
        }
            
    }
        emailText.text = ""
        passText.text = ""
    }
    
    
    //MARK: Button recuperar contrasena
    
    
    @IBAction func btnRecuperarContrasena(_ sender: Any) {
        print("estoy precionando el bto")
        let alertaRecuperarContrasena = UIAlertController(title: "¿Olvidaste tu contraseña?", message: nil, preferredStyle: .alert)
        alertaRecuperarContrasena.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alertaRecuperarContrasena.addTextField(configurationHandler: { textField in textField.placeholder = "Por favor ingrese su correo electrónico para verificar"})
        alertaRecuperarContrasena.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let correo =  alertaRecuperarContrasena.textFields?.first?.text{
                
            Auth.auth().sendPasswordReset(withEmail: correo)
            { error in
                if let error = error
                {
               let miAlerta = UIAlertController(title: "Error", message: "Escribe un correo valido por favor", preferredStyle: .alert)
               miAlerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               self.present(miAlerta, animated: true, completion: nil)
                    print(error.localizedDescription)
                }else{
                    let cambiarContrasena = UIAlertController(title: "Cambio de contraseña correcto", message: "Revisa tu correo por favor", preferredStyle: .alert)
                    cambiarContrasena.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(cambiarContrasena, animated: true, completion: nil)
                }

            }//del sendPassword
            }
            
            
        }))
        self.present(alertaRecuperarContrasena, animated: true, completion: nil)
        
    }
    
}
