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

class ChartView: UIView {
    
}

class ChartDrawer: NSObject {
    
}


class ShapeLayer: CAShapeLayer {
    
}

func circle(in size: CGSize) -> CALayer {
    let layer = CALayer()
    layer.masksToBounds = true
    layer.cornerRadius = size.height / 2
    layer.frame = .init(origin: .zero, size: size)
    return layer
}


