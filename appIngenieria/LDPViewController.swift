//
//  LDPViewController.swift
//  appIngenieria
//
//  Created by Manuel Osorio Catalan on 03/01/21.
//  Copyright © 2021 CEDAM20. All rights reserved.
//

import UIKit
import SafariServices

class LDPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func LigaGaseta(_ sender: Any) {
        let paginaUNAM = SFSafariViewController(url: URL(string:"https://www.acatlan.unam.mx/normatividad/file/Lineamientos-de-datos-personales-gaceta-25-de-febrero-de-2019.pdf")!)
        
        
        paginaUNAM.delegate = self as? SFSafariViewControllerDelegate
        present(paginaUNAM,animated: true)
    }
    
    
}
