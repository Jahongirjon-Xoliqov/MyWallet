//
//  SimpleCollectionViewCell.swift
//  MyWallet
//
//  Created by Dzakhon on 01/05/24.
//

import UIKit

class SimpleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(text: String) {
        label.text = text
        label.backgroundColor = .blue.withAlphaComponent(0.5)
    }

}
