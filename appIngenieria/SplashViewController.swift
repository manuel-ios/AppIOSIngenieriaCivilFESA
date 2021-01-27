//
//  SplashViewController.swift
//  appIngenieria
//
//  Created by user177761 on 10/30/20.
//  Copyright © 2020 CEDAM20. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    private let imageview : UIImageView = {
        let imageView = UIImageView (frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "AppIcon")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageview)
        view.backgroundColor = .brown
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageview.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.animate()
        })
    }
    
    private func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 1.5
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height-size
            self.imageview.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.imageview.alpha = 0
        },completion:{ done in
        if done{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                let viewController = InicioSesion()
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)

            })
          }
        })
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
