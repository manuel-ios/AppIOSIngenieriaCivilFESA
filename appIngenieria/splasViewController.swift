//
//  splasViewController.swift
//  appIngenieria
//
//  Created by user177761 on 10/30/20.
//  Copyright © 2020 CEDAM20. All rights reserved.
//

import UIKit

class splasViewController: UIViewController {
    
    
    let  alertImage  = UIImageView(image: UIImage(named: "blueLogo"))
    let splasView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splasView.backgroundColor = UIColor(displayP3Red: 24/255, green: 53/255, blue: 79/255, alpha: 1.0)
        view.addSubview(splasView)
        splasView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        alertImage.contentMode = .scaleAspectFit
        splasView.addSubview(alertImage)
        alertImage.frame = CGRect(x: splasView.frame.maxX-50, y: splasView.frame.maxY-50, width: 100, height: 100)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
            self.scaleDownAnimation()
        }
    }
    
    func scaleDownAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.alertImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5  )
        }){(success) in
            self.scaleUpAnimate()
        }
    }
    func scaleUpAnimate(){
        UIView.animate(withDuration: 0.35, delay: 0.1, options: .curveEaseInOut, animations: {
            self.alertImage.transform = CGAffineTransform(scaleX: 5, y: 5)
        }) {(success) in
            self.removeSplasScreen()
        }
    }
    
    func removeSplasScreen(){
        splasView.removeFromSuperview()
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
