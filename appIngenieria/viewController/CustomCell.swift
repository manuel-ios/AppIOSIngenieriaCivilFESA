//
//  CustomCell.swift
//  appIngenieria
//
//  Created by CEDAM20 on 10/24/19.
//  Copyright © 2019 CEDAM20. All rights reserved.
//

import UIKit

protocol CustomCellDelegate{
    
    func didTapTitleNew(url: String)
    func didTapShareNew(url: String)
}

class CustomCell: UITableViewCell {

    @IBOutlet weak var ImageNew: UIImageView!
    @IBOutlet weak var btnTitleNew: UIButton!
    @IBOutlet weak var btnShareNew: UIButton!
    var newItem: New!
    var delegate: CustomCellDelegate?
    
    func setNew(new: New){
        newItem = new
    }
    
    @IBAction func btnTitleNewTapped(_ sender: Any) {
        delegate?.didTapTitleNew(url: newItem.link)
    }
    @IBAction func btnShareNewTapped(_ sender: Any) {
        delegate?.didTapShareNew(url: newItem.link)
    }
}
