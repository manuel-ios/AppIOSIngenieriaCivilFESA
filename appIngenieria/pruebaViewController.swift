//
//  pruebaViewController.swift
//  appIngenieria
//
//  Created by Manuel Osorio Catalan on 29/12/20.
//  Copyright © 2020 CEDAM20. All rights reserved.
//

import UIKit



class pruebaViewController: UIViewController {
    let TransparentView = UIView() //creamos una vista que vamos a opacar
    let miTableView = UITableView() //creamos el table view
    var selectedButton = UIButton()
    var dataSource = [String]()
    @IBOutlet weak var pruenabuton: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        miTableView.delegate = self
        miTableView.dataSource = self
        miTableView.register(CellClass.self , forCellReuseIdentifier: "miCelda")

        // Do any additional setup after loading the view.
    }
    
    
    func addTransparentView(frames: CGRect){
        
                 //creamos una ventana
        let window = UIApplication.shared.keyWindow
        
        //.frame defune el tamano y la posicion de la vusta del mismo tamano de window
        TransparentView.frame = window?.frame ?? self.view.frame
        
        //agregamos TransparentView como una subvista de mi vista principal
         
         self.view.addSubview(TransparentView)
        
        //hacemos la tabla
        
        miTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        
        self.view.addSubview(miTableView)
        miTableView.layer.cornerRadius = 5
     
                //le damos el color a la subvista y una transparencia de 0.9
        self.TransparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9) //0.9
        miTableView.reloadData()
        
        //que al segundo click del boton se quite la subvista opaca
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
       
         TransparentView.addGestureRecognizer(tapGesture)
        
       //la transparencia no es opaca = 0
        TransparentView.alpha = 0
        //vuelve a 0.5 la transparencia y hace la animacion
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations:
        {
            self.TransparentView.alpha = 0.4
            
            self.miTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5 , width: frames.width, height: CGFloat(self.dataSource.count * 50) )
            

        }, completion: nil)
        
        
        
    }
    //funcion que quita la transparencia
    @objc func removeTransparentView()
    {
        let frames = selectedButton.frame
       UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations:
    {
        self.TransparentView.alpha = 0
        
         self.miTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.miTableView.alpha = 1
        
       }, completion: nil)
        
    }

    @IBAction func pruurur(_ sender: Any) {
        
            dataSource = ["Matutino", "Vespertino", "Mixto"]
            selectedButton = pruenabuton
            addTransparentView(frames: pruenabuton.frame)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension pruebaViewController: UITableViewDelegate, UITableViewDataSource{
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dataSource.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "miCelda", for: indexPath)
         cell.textLabel?.text = dataSource[indexPath.row]
         return cell
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 40//antes 50
     }
     //aqui se le cambia el nombre al boton
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
         removeTransparentView()
     }
}
