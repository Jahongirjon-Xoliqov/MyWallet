//
//  UIColor+Extension.swift
//  MyWallet
//
//  Created by Dzakhon on 22/04/24.
//

import UIKit

extension UIColor {

    /// Initializes a new UIColor instance from a hex string.
    ///
    /// - Parameter hex: The hex string representing the color.
    ///                 - Format: "#RRGGBB" (hexadecimal, 6 digits) or "#RRGGBBAA" (hexadecimal, 8 digits)
    ///                 - Prefix "#" is optional.
    /// - Returns: A UIColor instance representing the color specified in the hex string,
    ///            or nil if the format is invalid.
    convenience init?(hex: String) {
      var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      if hexString.hasPrefix("#") {
        hexString.removeFirst()
      }

      let scanner = Scanner(string: hexString)
      scanner.charactersToBeSkipped = CharacterSet(charactersIn: "+,")
      var rgbValue: UInt64 = 0
      guard scanner.scanHexInt64(&rgbValue) else { return nil }

      var red, green, blue, alpha: CGFloat

      switch hexString.count {
      case 6:
        red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        alpha = 1.0
      case 8:
        red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
        green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
        blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
        alpha = CGFloat(rgbValue & 0x000000FF) / 255.0
      default:
        return nil
      }

      self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}
