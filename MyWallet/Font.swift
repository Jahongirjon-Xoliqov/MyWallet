//
//  Font.swift
//  CrimsonTaxi
//
//  Created by Dzakhon on 20/10/23.
//

import UIKit

/*
 https://gist.github.com/tadija/cb4ec0cbf0a89886d488d1d8b595d0e9
 *** Arial ***
 Arial-BoldItalicMT
 Arial-BoldMT
 Arial-ItalicMT
 ArialMT
 */

enum Font: String {
    case MONTSERRAT_EXTRABOLD = "AvenirNextCondensed-Heavy"
    case MONTSERRAT_BOLD      = "HelveticaNeue-Bold"
    case MONTSERRAT_SEMIBOLD  = "AvenirNextCondensed-DemiBold"
    case MONTSERRAT_REGULAR   = "HelveticaNeue"
    case MONTSERRAT_MEDIUM    = "HelveticaNeue-Medium"
    case MONTSERRAT_LIGHT     = "HelveticaNeue-Light"
    case MONTSERRAT_THIN      = "HelveticaNeue-UltraLight"
    
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


