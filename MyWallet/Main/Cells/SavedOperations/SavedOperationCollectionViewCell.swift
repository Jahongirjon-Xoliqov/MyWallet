//
//  SavedOperationCollectionViewCell.swift
//  MyWallet
//
//  Created by Dzakhon on 01/05/24.
//

import UIKit

final class SavedOperationCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        addSUIView(SavedOperationWidgetView())
    }

}
