//
//  PieSlice.swift
//  MyWallet
//
//  Created by Dzakhon on 03/03/24.
//

import UIKit

struct PieSlice {
    var startAngle: CGFloat
    var endAngle: CGFloat
    var centerPoint: CGPoint
    var colors: [CGColor]
    
    private var shapeLayer: CAShapeLayer
    private var shadowLayer: CAShapeLayer
    private var gradientLayer: CAGradientLayer
    private var shapePath: UIBezierPath
    private var shadowPath: UIBezierPath
}

