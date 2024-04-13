//
//  MonitoringViewController.swift
//  MyWallet
//
//  Created by Dzakhon on 03/03/24.
//

import UIKit

final class MonitoringViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let centerRect = CGRect(x: view.frame.width/2-200, y: view.frame.height/2-200, width: 400, height: 400)
        let pathCenterRect = CGRect(origin: .zero, size: CGSize(width: 400, height: 400))

        let pi = CGFloat.pi
        let radius: CGFloat = 50
        
        let path = UIBezierPath()

        path.move(to: .init(x: 0, y: 300))
        path.addLine(to: .init(x: 0, y: radius))
        path.addQuadCurve(to: .init(x: radius, y: 0),
                          controlPoint: .init(x: 0, y: 0))
        path.addQuadCurve(to: .init(x: 300, y: 300-radius),
                          controlPoint: .init(x: 300, y: 0))
        path.addQuadCurve(to: .init(x: 300-radius, y: 300),
                          controlPoint: .init(x: 300, y: 300))
        path.addLine(to: .init(x: 0, y: 300))
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.black.cgColor
//        shapeLayer.strokeColor = UIColor.black.cgColor
//        shapeLayer.strokeStart = 0
//        shapeLayer.strokeEnd = 1
//        shapeLayer.lineWidth = 10
//        shapeLayer.lineCap = .butt
//        shapeLayer.cornerRadius = 10
        shapeLayer.shadowOffset = .zero
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowColor = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = centerRect
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = .init(x: 0.5, y: 0.5)
        gradientLayer.endPoint = .init(x: 1, y: 1)
        gradientLayer.type = .radial
        
        gradientLayer.mask = shapeLayer
        view.layer.addSublayer(gradientLayer)
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = path.cgPath
        shadowLayer.fillColor = nil
        shadowLayer.strokeColor = UIColor.black.cgColor
        shadowLayer.strokeStart = 0
        shadowLayer.strokeEnd = 1
        shadowLayer.lineWidth = 2
        shadowLayer.shadowOffset = .zero
        shadowLayer.shadowRadius = 10
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowColor = UIColor.black.cgColor
        
    }
    
}



extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
