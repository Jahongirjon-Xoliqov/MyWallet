//
//  MonitoringViewController.swift
//  MyWallet
//
//  Created by Dzakhon on 03/03/24.
//

import UIKit

final class MonitoringViewController: UIViewController {

    struct PieSliceData {
        var procent: Double
    }
    
    struct PieData {
        var slices: [PieSliceData]
    }
    
    struct PieSliceLayerData {
        var startAngle: CGFloat
        var endAngle: CGFloat
        var centerPoint: CGPoint
        var colors: [CGColor]
    }
    
    class PieSliceLayer: CALayer {
        
        var data: PieSliceLayerData?
        
        private var shapeLayer = CAShapeLayer()
        private var shadowLayer = CAShapeLayer()
        private var gradientLayer = CAGradientLayer()
        private var shapePath = UIBezierPath()
        //private var shadowPath: UIBezierPath
        
        func draw(data: PieSliceLayerData) {
            self.data = data
            let rect = bounds
            shapePath = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY),
                                     radius: rect.width/2,
                                     startAngle: data.startAngle,
                                     endAngle: data.endAngle,
                                     clockwise: true)
            
            gradientLayer.type = .radial
            gradientLayer.frame = bounds
            gradientLayer.colors = data.colors
            gradientLayer.startPoint = .init(x: 0.5, y: 0.5)
            gradientLayer.endPoint = .init(x: 1, y: 1)
            
            shapeLayer.path = shapePath.cgPath
            gradientLayer.mask = shapeLayer
            
            gradientLayer.removeFromSuperlayer()
            addSublayer(gradientLayer)
            
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let pieRect = CGRect(x: view.frame.midX-100, y: view.frame.midY-100, width: 200, height: 200)
        let pieChartLayer = CALayer()
        pieChartLayer.frame = pieRect
        view.layer.addSublayer(pieChartLayer)
//        fetchPieData { pieData in
//            
//            let firstPieSliceLayerData = PieSliceLayerData(startAngle: 0,
//                                                           endAngle: 288*CGFloat.pi/180,
//                                                           centerPoint: CGPoint(x: pieRect.midX, y: pieRect.midY),
//                                                           colors: [UIColor.systemOrange.cgColor, UIColor.systemPink.cgColor])
//            let secondPieSliceLayerData = PieSliceLayerData(startAngle: 288*CGFloat.pi/180,
//                                                           endAngle: 303*CGFloat.pi/180,
//                                                           centerPoint: CGPoint(x: pieRect.midX, y: pieRect.midY),
//                                                           colors: [UIColor.blue.cgColor, UIColor.cyan.cgColor])
//            let thirdPieSliceLayerData = PieSliceLayerData(startAngle: 303*CGFloat.pi/180,
//                                                           endAngle: 360*CGFloat.pi/180,
//                                                           centerPoint: CGPoint(x: pieRect.midX, y: pieRect.midY),
//                                                           colors: [UIColor.green.cgColor, UIColor.magenta.cgColor])
//            
//            
//            let firstPieSliceLayer = PieSliceLayer()
//            firstPieSliceLayer.frame = pieChartLayer.bounds
//            firstPieSliceLayer.draw(data: firstPieSliceLayerData)
//            pieChartLayer.addSublayer(firstPieSliceLayer)
//            
//            let secondPieSliceLayer = PieSliceLayer()
//            secondPieSliceLayer.frame = pieChartLayer.bounds
//            secondPieSliceLayer.draw(data: secondPieSliceLayerData)
//            pieChartLayer.addSublayer(secondPieSliceLayer)
//            
//            let thirdPieSliceLayer = PieSliceLayer()
//            thirdPieSliceLayer.frame = pieChartLayer.bounds
//            thirdPieSliceLayer.draw(data: thirdPieSliceLayerData)
//            pieChartLayer.addSublayer(thirdPieSliceLayer)
//            
//        }
        
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width-40, height: 100)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 0))
        path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 100, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.close()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 200, height: 200))//CGRect(x: 20, y: view.bounds.midY-50, width: view.bounds.width-40, height: 100)
        gradientLayer.colors = [UIColor.systemOrange.cgColor, UIColor.systemPink.cgColor]
        gradientLayer.startPoint = .init(x: 0.5, y: 0)
        gradientLayer.endPoint = .init(x: 0.5, y: 1)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        gradientLayer.mask = shapeLayer
        
//        let shadowLayer = CAShapeLayer()
//        shadowLayer.masksToBounds = false
//        shadowLayer.shadowColor = UIColor.black.cgColor
//        shadowLayer.shadowRadius = 16
//        shadowLayer.shadowOffset = .zero
//        shadowLayer.shadowOpacity = 1
//        shadowLayer.path = UIBezierPath(ovalIn: CGRect(x: 20, y: view.bounds.midY-50, width: view.bounds.width-40, height: 100)).cgPath
//        shadowLayer.fillColor = UIColor.red.cgColor
//        shadowLayer.strokeColor = UIColor.clear.cgColor
        
//        view.layer.addSublayer(shadowLayer)
        view.layer.addSublayer(gradientLayer)
        
    }
    
    private func fetchPieData(completion: @escaping (PieData) -> ()) {
        let firstSlice = PieSliceData(procent: 80)
        let secondSlice = PieSliceData(procent: 15)
        let thirdSlice = PieSliceData(procent: 5)
        let pieData = PieData(slices: [firstSlice, secondSlice, thirdSlice])
        completion(pieData)
    }
    
}


/*
 let rect = CGRect(x: 0, y: 0, width: view.bounds.width-40, height: 100)
 
 let path = UIBezierPath(ovalIn: rect)
 
 let gradientLayer = CAGradientLayer()
 gradientLayer.frame = CGRect(x: 20, y: view.bounds.midY-50, width: view.bounds.width-40, height: 100)
 gradientLayer.colors = [UIColor.systemOrange.cgColor, UIColor.systemPink.cgColor]
 gradientLayer.startPoint = .init(x: 0.5, y: 0)
 gradientLayer.endPoint = .init(x: 0.5, y: 1)
 
 let shapeLayer = CAShapeLayer()
 shapeLayer.path = path.cgPath
 gradientLayer.mask = shapeLayer
 
 let shadowLayer = CAShapeLayer()
 shadowLayer.masksToBounds = false
 shadowLayer.shadowColor = UIColor.black.cgColor
 shadowLayer.shadowRadius = 16
 shadowLayer.shadowOffset = .zero
 shadowLayer.shadowOpacity = 1
 shadowLayer.path = UIBezierPath(ovalIn: CGRect(x: 20, y: view.bounds.midY-50, width: view.bounds.width-40, height: 100)).cgPath
 shadowLayer.fillColor = UIColor.red.cgColor
 shadowLayer.strokeColor = UIColor.clear.cgColor
 
 view.layer.addSublayer(shadowLayer)
 view.layer.addSublayer(gradientLayer)
 
 //view.layer.addSublayer(gradientLayer)
 */
