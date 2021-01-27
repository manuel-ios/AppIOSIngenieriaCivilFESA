//
//  Menu.swift
//  appIngenieria
//
//  Created by CEDAM20 on 10/22/19.
//  Copyright © 2019 CEDAM20. All rights reserved.
//

import UIKit
import SafariServices
import Firebase


struct New{
    
    var title: String
    var image: String
    var link: String
    
}

class Menu: UIViewController {
    
    @IBOutlet weak var nombreUsuario: UILabel!
    @IBOutlet weak var numCuenta: UILabel!
    var constraintsToApply = [NSLayoutConstraint]()
    var news = [New]()
    var isExpanded = false
    var exitFromView = false //Variable para dejar abierto el menu
    
    @IBOutlet weak var viewNews: UIView!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var viewToBlockNews: UIView!
    @IBOutlet weak var btnCerrarSesion: UIButton!
    var ref: DatabaseReference!
    var handle : DatabaseHandle?
    let usuario = [Usuarios]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
      /*if let user = Auth.auth().currentUser{
            let name = user.displayName
            let email = user.email
            //let numeroCuenta = user.numeroCuenta
            self.nombreUsuario.text = name
            print(name)
            self.numCuenta.text = email
        }*/
       /*ref = Database.database().reference().child("Usuarios")
        
        let key  = ref.childByAutoId().key
        
        let user =  ["Id": key,
                     "displayName": nombreUsuario.text! as  String,
                     "numeroCuenta": numCuenta.text! as String]
        ref.child(key!).setValue(user)
        print(user)
        
       */
    
             
        
       let user = Auth.auth().currentUser
        if let user = user {
          let uid = user.uid
          let email = user.email
            let name = user.displayName
            let displayName =  user.displayName
            let numTelefono = user.phoneNumber
         // let numeroCuenta = user.numeroCuenta
            print("Hola")
            print(user.uid)
            print(user.displayName)
            nombreUsuario.text = email
            numCuenta.text = uid
            print(email)
            print(numTelefono)
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
          // ...
        }
       
        
     
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        viewToBlockNews.isHidden = true
        btnCerrarSesion.layer.cornerRadius = 5.0
        
        //Carga los constraints
        loadingConstraints()
        NSLayoutConstraint.activate(constraintsToApply)
        
        //Carga la información en el arreglo
      // fetchUser()
        loadingNews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if exitFromView{
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                self.viewNews.frame.origin.x = self.viewNews.frame.width - 120
                
            }, completion: nil)
            
            viewToBlockNews.isHidden = false
            
        }
    }
    
   func fetchUser(){
        
    }
    
    // Funciones del menu de noticias
    @IBAction func btnLaboratorioTapped(_ sender: Any) {
        showSafariVC(for: "http://132.248.180.207/sail/Alumno/Login.aspx")
        exitFromView = true
    }
    
    @IBAction func btnMenuTapped(_ sender: Any) {
        
        isExpanded = !isExpanded
        menuShow()
    }
    
    // Funciones del menu de usuario
    @IBAction func btnHorarioTapped(_ sender: Any) {
        showSafariVC(for: "http://www.escolares.acatlan.unam.mx")
        exitFromView = true
    }
    @IBAction func btnCalificacionesTapped(_ sender: Any) {
        showSafariVC(for: "https://www.dgae-siae.unam.mx/www_gate.php")
        exitFromView = true
    }

    @IBAction func btnBecaTapped(_ sender: UIButton) {
        showSafariVC(for: "https://www.becarios.unam.mx/Portal2018/?page_id=111")
        exitFromView = true
    }
    @IBAction func btnPuenteTapped(_ sender: Any) {
       showSafariVC(for: "http://www.ingenieria.acatlan.unam.mx/media/vinculos/2019/08/XI%20CONCURSO%20PUENTES%20DE%20MADERA.pdf")
        exitFromView = true
    }
    @IBAction func btnFacebookTapped(_ sender: Any) {
        showSafariVC(for: "https://www.facebook.com/ing.civil.acatlan")
        exitFromView = true
    }
    
    @IBAction func btnTwitterTapped(_ sender: Any) {
        showSafariVC(for: "https://twitter.com/IAcatlan")
        exitFromView = true
    }
    @IBAction func btnInstagramTapped(_ sender: Any) {
        showSafariVC(for: "https://www.instagram.com/i.c.acatlan")
        exitFromView = true
    }
    @IBAction func btnMessengerTapped(_ sender: Any) {
        showSafariVC(for: "https://www.facebook.com/ing.civil.acatlan/inbox")
        exitFromView = true
    }
    @IBAction func btnMisionyVisionFesA(_ sender: Any) {
        showSafariVC(for: "https://www.acatlan.unam.mx/index.php?id=12")
        exitFromView = true
    }
    
    //Cambia el color de los iconos (hora, bateria, ...) del iphone a blanco
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func loadingConstraints(){
        // Deshabilita los constraints que traiga
        viewNews.translatesAutoresizingMaskIntoConstraints = false
        
        viewNews.frame.origin.x = 0
        viewNews.frame.origin.y = 0
        
        //Define el ancho y alto a traves del tamaño de la pantalla
        let widthConstraint = viewNews.widthAnchor.constraint(equalToConstant: self.view.frame.size.width)
        let heigthConstraint = viewNews.heightAnchor.constraint(equalToConstant: self.view.frame.size.height)
        
        constraintsToApply.append(widthConstraint)
        constraintsToApply.append(heigthConstraint)
        
        //Constrains de segunda vista
        viewToBlockNews.frame.origin.x = self.view.frame.width - 120
        viewToBlockNews.frame.origin.y = 90.0
        
        let widthConstraintSecond = viewToBlockNews.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 120)
        let heigthConstraintSecond = viewToBlockNews.heightAnchor.constraint(equalToConstant: self.view.frame.size.height - 120)
        
        constraintsToApply.append(widthConstraintSecond)
        constraintsToApply.append(heigthConstraintSecond)
        
    }
    
    func loadingNews(){
        
        news.append(New.init(title: "La ejecución de proyectos sin planeación propicia corrupción", image: "noticia1", link: "http://noticolegio.com/2019/10/08/la-ejecucion-de-proyectos-sin-planeacion-propicia-corrupcion/"))
        news.append(New.init(title: "Estancada la energía nuclear en México, a pesar se reconocida importancia", image: "noticia2", link: "http://noticolegio.com/2019/10/18/estancada-la-energia-nuclear-en-mexico-a-pesar-su-reconocida-importancia/"))
        news.append(New.init(title: "Más de 130 nuevos socios se integran a las filas de nuestro Colegio", image: "noticia3", link: "http://noticolegio.com/2019/09/20/mas-de-130-nuevos-socios-se-integran-a-las-filas-de-nuestro-colegio/"))
        news.append(New.init(title: "Reconstrucción de la vivienda unifamiliar concluirá a mediados de 2020: Cravioto", image: "noticia4", link: "http://noticolegio.com/2019/09/17/reconstruccion-de-la-vivienda-unifamiliar-concluira-a-mediados-de-2018-cravioto/"))
        news.append(New.init(title: "CICM recibió invitación para integrarse al Consejo para el Fomento a la Inversión", image: "noticia5", link: "http://noticolegio.com/2019/09/18/cicm-recibio-invitacion-para-integrarse-al-consejo-para-el-fomento-a-la-inversion/"))
        news.append(New.init(title: "Plantas modulares podrían alentar nuevo despegue de la geotermia en México", image: "noticia6", link: "http://noticolegio.com/2019/11/04/plantas-modulares-podrian-alentar-nuevo-despegue-de-la-geotermia-en-mexico/"))
        news.append(New.init(title: "El sureste mira con aliento la construcción del Tren Maya y Dos Bocas", image: "noticia7", link: "http://noticolegio.com/2019/10/31/el-sureste-mira-con-aliento-la-construccion-del-tren-maya-y-dos-bocas/"))
    }
    
    func showSafariVC(for url: String){
        
        guard let url = URL(string: url) else{
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func menuShow(){
        if isExpanded{
            //Muestra el menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                self.viewNews.frame.origin.x = self.viewNews.frame.width - 120
                
            }, completion: nil)
            
            viewToBlockNews.isHidden = false
            
        } else{
            //Oculta el menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                self.viewNews.frame.origin.x = 0
                
            }, completion: nil)
            
            viewToBlockNews.isHidden = true
            
        }
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError {
            self.present(service.createAlertController(title: "Error", message: signOutError.localizedDescription), animated: true, completion: nil)
    }
    }
    
    @IBAction func acerca(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Acerca")
         self.present(vc!, animated: false, completion: nil)
    }
    
}

extension Menu: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        cell.ImageNew?.image = UIImage(named: news[indexPath.row].image)
        cell.btnTitleNew?.setTitle(news[indexPath.row].title, for: .normal)
        
        cell.setNew(new: news[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
}

extension Menu: CustomCellDelegate{
    
    func didTapTitleNew(url: String) {
        showSafariVC(for: url)
        
        exitFromView = false
    }
    
    func didTapShareNew(url: String) {
        //Crea un activityViewController para compartir el link.
        let linkToShare = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(linkToShare, animated: true, completion: nil)
        
        exitFromView = false
    }
    
    
    
}

