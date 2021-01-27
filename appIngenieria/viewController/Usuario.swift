//
//  Usuario.swift
//  appIngenieria
//
//  Created by Manuel Osorio Catalan on 02/01/21.
//  Copyright © 2021 CEDAM20. All rights reserved.
//

import Foundation
import UIKit
class Usuario{
    let uid : String
    let name:String
    let correo:String
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.name = dictionary["Nombre"] as? String ?? ""
        self.correo = dictionary["numeroCuenta"] as? String ?? ""
    }
}
