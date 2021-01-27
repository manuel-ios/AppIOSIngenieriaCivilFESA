//
//  AcercaViewController.swift
//  appIngenieria
//
//  Created by Manuel Osorio Catalan on 04/01/21.
//  Copyright © 2021 CEDAM20. All rights reserved.
//

import UIKit

class AcercaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var name: UINavigationItem!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func action(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
         self.present(vc!, animated: true, completion: nil)
    }
}
