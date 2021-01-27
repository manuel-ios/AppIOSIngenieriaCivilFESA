//
//  registroNuevoViewController.swift
//  appIngenieria
//
//  Created by Manuel Osorio Catalan on 30/12/20.
//  Copyright © 2020 CEDAM20. All rights reserved.

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

class CellClass: UITableViewCell{

}
class registroNuevoViewController: UIViewController, UITextFieldDelegate{
    //MARK: Outlet
    @IBOutlet weak var SemestreBotton: UIButton!
    @IBOutlet weak var grupoButton: UIButton!
    @IBOutlet weak var turnoButton: UIButton!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var numTelefono: UITextField!
    @IBOutlet weak var numcuentaTextfield: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    @IBOutlet weak var repContrasenaTextField: UITextField!
    @IBOutlet weak var contrasenaTextField: UITextField!
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var fechaNacimientoTextField: UITextField!
    let datePicker = UIDatePicker()
    let transparenciaView = UIView()
    let TableView = UITableView()
    var selectorButton = UIButton()
    var dataSource = [String]()
    
    var opcionGrupo : String!
    var opcionTurno : String!
    var opcionSemestre : String!
    
  
    var ref: DatabaseReference!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - UITextField
        nombreTextField.delegate = self
        apellidoTextField.delegate = self
        numTelefono.delegate = self
        numcuentaTextfield.delegate = self
        fechaNacimientoTextField.delegate = self
        
        
        numTelefono.tag = 1
        numcuentaTextfield.tag = 2
        fechaNacimientoTextField.tag = 3
        nombreTextField.tag = 4
        apellidoTextField.tag = 5
        
        ref = Database.database().reference().child("Usuarios")
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(CellClass.self , forCellReuseIdentifier: "Cell")
      
        
        
        fechaNacimientoTextField.resignFirstResponder()
        self.fechaNacimientoTextField.delegate = self
        crearDatePicker()
        
    }
   
    // MARK: -Formato Fecha
    func crearDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBotton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressend))
        toolbar.setItems([doneBotton], animated: true)
        fechaNacimientoTextField.inputAccessoryView = toolbar
        fechaNacimientoTextField.inputView = datePicker
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -16, to: Date())
        datePicker.datePickerMode = .date
        
    }
    @objc func donePressend()  {
        let formato = DateFormatter()
        formato.dateFormat = "MM/dd/yyyy"
        fechaNacimientoTextField.text = formato.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    //Mark: -MenuDeslisable
    
    
    func AgregarTransparencia(frames: CGRect){
        
                 //creamos una ventana
        let window = UIApplication.shared.keyWindow
        
        //.frame defune el tamano y la posicion de la vusta del mismo tamano de window
       transparenciaView.frame = window?.frame ?? self.view.frame
        
        //agregamos TransparentView como una subvista de mi vista principal
         
         self.view.addSubview(transparenciaView)
        
        //hacemos la tabla
        
        TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y - frames.height, width: frames.width, height: 0)
        
        self.view.addSubview(TableView)
        TableView.layer.cornerRadius = 5
     
                //le damos el color a la subvista y una transparencia de 0.9
        self.transparenciaView.backgroundColor = UIColor.black.withAlphaComponent(0.9) //0.9
        TableView.reloadData()
        
        //que al segundo click del boton se quite la subvista opaca
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(eliminarTransparencia))
       
        transparenciaView.addGestureRecognizer(tapGesture)
        
       //la transparencia no es opaca = 0
        transparenciaView.alpha = 0
        //vuelve a 0.5 la transparencia y hace la animacion
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations:
        {
            self.transparenciaView.alpha = 0.4
            
            self.TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5 , width: frames.width, height: CGFloat(self.dataSource.count - 200) )
            

        }, completion: nil)
        
        
        
    }
    //funcion que quita la transparencia
    @objc func eliminarTransparencia()
    {
        let frames = selectorButton.frame
       UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations:
    {
        self.transparenciaView.alpha = 0
        
         self.TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.TableView.alpha = 1
        
       }, completion: nil)
        
    }

// MARK: -Button Deslizables
 

    @IBAction func seleccionTurno(_ sender: Any) {
        dataSource = ["Matutino", "Vespertino", "Mixto"]
        selectorButton = turnoButton
        AgregarTransparencia(frames: turnoButton.frame)
    }
    
    @IBAction func seleccionGrupo(_ sender: Any) {
        dataSource = ["1101","1102","1103","1151","1152"]
        selectorButton = grupoButton
        AgregarTransparencia(frames: grupoButton.frame)
        
    }
    
    @IBAction func seleccionSemestre(_ sender: Any) {
        dataSource = ["1 semestre"]
        selectorButton = SemestreBotton
        AgregarTransparencia(frames: SemestreBotton.frame)
        
    }
    
    //MARK: -Button Registro
    
    
    @IBAction func Registro(_ sender: Any) {
        
        if contrasenaTextField.text ==  repContrasenaTextField.text && nombreTextField.text != "" && apellidoTextField.text != "" && numcuentaTextfield.text != "" && numTelefono.text != ""  {
            print("La contrasena son iguales")
            let email = correoTextField.text
            let password = contrasenaTextField.text
            if let email = email, let password = password, let nombre = nombreTextField.text, let apellido = apellidoTextField.text, let correo = correoTextField.text, let contrasena = contrasenaTextField.text, let numCuenta = numcuentaTextfield.text, let numTelefono = numTelefono.text, let fechaNacimiento = fechaNacimientoTextField.text{
                
                Auth.auth().createUser(withEmail: email, password: password)
                {
                    
                    (result,error) in
                    //Error
                    if let error = error{
                        print("Se ha pronunciado un error al crear un usuario")
                        print(error.localizedDescription)
                    }
                    //Verifificacion de email
                    else
                    if let result = result
                    {
                        let user = result.user
                        if user.isEmailVerified
                        {
                            print("El usuario ya ha sido registrado anteriormete ")
                            let alert = UIAlertController(title: "Warning", message: "El usuario ya se ha registrado  anteriormete", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                            self.performSegue(withIdentifier: "Home", sender: nil)
                        }
                        else {
                            print("El correo no se ha verificado")
                            user.sendEmailVerification
                            {
                               (error) in
                                if let error = error
                                {
                                    print("se han obtenido errores en la verificacion del correo")
                                    print(error.localizedDescription)
                                    let alert = UIAlertController(title: "Verifica tu correo electrónico", message: "El correo electrónico ingresado no ha sido verificado por el sistema.", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                                    alert.addAction(okAction)
                                    self.present(alert, animated: true, completion: nil)
                                }
                                else{
                                    
                                    print("Se registro el correo")
                                    print(result.user.email)
                                    let alert = UIAlertController(title: "Verifica tu cuenta", message: "Por favor verifica en tu correo electrónico para iniciar sesión", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                                    alert.addAction(okAction)
                                    self.present(alert, animated: true, completion: nil)
                                }//Erro
                            }//Verificacion
                        }
                    }
                    
                }
                
            }
           
           if let nombre = nombreTextField.text, let apellido = apellidoTextField.text, let correo = correoTextField.text, let contrasena = contrasenaTextField.text, let numCuenta = numcuentaTextfield.text, let numTelefono = numTelefono.text, let fechaNacimiento = fechaNacimientoTextField.text{
                print(nombre)
                print(apellido)
                print(correo)
                print(contrasena)
                print(numTelefono)
                print(numCuenta)
                print(fechaNacimiento)
                print(opcionSemestre)
                print(opcionGrupo)
                print(opcionTurno)
                
                let key = ref.childByAutoId().key
                let usuario = [
                    "Apellido": apellido,
                    "Correo" : correo,
                    "Grupo": opcionGrupo,
                    "displayName": nombre,
                    "Semestre" : opcionSemestre,
                    "Turno" : opcionTurno,
                    "fechaNacimiento" : fechaNacimiento,
                    "phoneNumber": numCuenta,
                    "numeroTelefono": numTelefono
                ]
                ref.child(key!).setValue(usuario)
                //ref.child(key!).setValue(usuario)
            }else{
                print("Se obtuvo problemas en la BDD")
            }
        
        }
        else{
            
            print("La contrasena son diferentes")
            
            let alert = UIAlertController(title: "Verificación de infromación", message:"Verifica que los información se ha correcta", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }

    
    }
  
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //MARK: - Verificacion del numero de Telefono
        
        //MARK: - Verificacion del numero de Cuenta
        /*guard let cuentatextFieldText = numcuentaTextfield.text,
            let cuentarangoDelTextoAReemplazar = Range(range, in: cuentatextFieldText) else {
                return false
        }
        let cuentasubcadenaParaReemplazar = textFieldText[cuentarangoDelTextoAReemplazar]
        let cuentacount = textFieldText.count - cuentasubcadenaParaReemplazar.count + string.count
        if numcuentaTextfield.placeholder == "No. cuenta(9 dígitos)"{
            return cuentacount <= 9
            
        }else{
            return cuentacount <= 9
        }*/

       
        var numeroFiltrado = ""
        
        switch textField.tag {
        case 1:
            let num = CharacterSet(charactersIn: "1234567890").inverted
            let separador = string.components(separatedBy: num)
            numeroFiltrado = separador.joined(separator: "")
            guard let textFieldText = numTelefono.text,
                let rangoDelTextoAReemplazar = Range(range, in: textFieldText) else {
                    return false
            }
            let subcadenaParaReemplazar = textFieldText[rangoDelTextoAReemplazar]
            let count = textFieldText.count - subcadenaParaReemplazar.count + string.count
            if numTelefono.placeholder == "No. Telefono(10 dígitos)"{
                return count <= 10
                
            }else{
                return count <= 10
            }
            
        case 2:
            let num = CharacterSet(charactersIn: "1234567890").inverted
            let separador = string.components(separatedBy: num)
            numeroFiltrado = separador.joined(separator: "")
            guard let textFieldText = numcuentaTextfield.text,
                let rangoDelTextoAReemplazar = Range(range, in: textFieldText) else {
                    return false
            }
            let subcadenaParaReemplazar = textFieldText[rangoDelTextoAReemplazar]
            let count = textFieldText.count - subcadenaParaReemplazar.count + string.count
            if numcuentaTextfield.placeholder == "No. cuenta(9 dígitos)"{
                return count <= 9
                
            }else{
                return count <= 9
            }
        
        case 3:
            let num = CharacterSet(charactersIn: "").inverted
            let separador = string.components(separatedBy: num)
            numeroFiltrado = separador.joined(separator: "")
        case 4:
            let letra = CharacterSet(charactersIn: "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZáéíóú ").inverted
            let separador = string.components(separatedBy: letra)
            numeroFiltrado = separador.joined(separator: " ")
        case 5:
            let letra = CharacterSet(charactersIn: "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZáéíóú ").inverted
            let separador = string.components(separatedBy: letra)
            numeroFiltrado = separador.joined(
                separator: "")
        default:
            print("nada mas Swift ")
        }
         
        return  string == numeroFiltrado
        
    }

    

}

//MARK: -Extension UITableView
extension registroNuevoViewController: UITableViewDelegate, UITableViewDataSource{
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dataSource.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         cell.textLabel?.text = dataSource[indexPath.row]
         return cell
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 50
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectorButton.setTitle(dataSource[indexPath.row], for: .normal)
        eliminarTransparencia()
        switch selectorButton {
        case turnoButton:
            if dataSource[indexPath.row] == "Matutino"{
                opcionTurno = "Matutino"
            }
            else if dataSource[indexPath.row] == "Vespertino"{
                opcionTurno = "Vespertino"
            }
            else{
                opcionTurno = "NA"
            }
        case grupoButton:
            if dataSource[indexPath.row] == "1101"{
                opcionGrupo = "1101"
            }
            else if dataSource[indexPath.row] == "1102"{
                opcionGrupo = "1102"
            }
            else if dataSource[indexPath.row] == "1103"{
                opcionGrupo = "1103"
            }
            else if dataSource[indexPath.row] == "1151"{
                opcionGrupo = "1151"
            }
            else if dataSource[indexPath.row] == "1151"{
                opcionGrupo = "1151"
            }
            else{
                opcionGrupo = "NA"
            }
        case SemestreBotton:
             if dataSource[indexPath.row] == "1 semestre"{
                opcionSemestre = "1 semestre"
            }
            else{
                opcionSemestre = "NA"
                
             }
        default:
            print("Seleccion no valida")
        }
     }
}


