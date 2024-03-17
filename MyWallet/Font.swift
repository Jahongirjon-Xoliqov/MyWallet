//
//  Font.swift
//  CrimsonTaxi
//
//  Created by Dzakhon on 20/10/23.
//

import UIKit

enum Font: String {
    case MONTSERRAT_EXTRABOLD = "Montserrat-ExtraBold"
    case MONTSERRAT_BOLD      = "Montserrat-Bold"
    case MONTSERRAT_SEMIBOLD  = "Montserrat-SemiBold"
    case MONTSERRAT_REGULAR   = "Montserrat-Regular"
    case MONTSERRAT_MEDIUM    = "Montserrat-Medium"
    case MONTSERRAT_LIGHT     = "Montserrat-Light"
    case MONTSERRAT_THIN      = "Montserrat-Thin"
    
    static var regular: Font {
        .MONTSERRAT_REGULAR
    }
    
    static var light: Font {
        .MONTSERRAT_LIGHT
    }
    
    static var thin: Font {
        .MONTSERRAT_THIN
    }
    
    static var medium: Font {
        .MONTSERRAT_MEDIUM
    }
    
    static var semibold: Font {
        .MONTSERRAT_SEMIBOLD
    }
    
    static var bold: Font {
        .MONTSERRAT_BOLD
    }
    
    static var extrabold: Font {
        .MONTSERRAT_EXTRABOLD
    }
    
    func size(_ size: CGFloat) -> UIFont {
        UIFont(name: self.rawValue, size: size)
        ?? .systemFont(ofSize: size)
    }
    
}


