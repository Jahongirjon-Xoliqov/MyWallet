//
//  UIChartViewForLowerVersion.swift
//  MyWallet
//
//  Created by Dzakhon on 28/04/24.
//

import UIKit


public struct UIPlottableValue<Value: NSNumber> {
    var attr: NSAttributedString
    var value: Value
    /// Creates a parameter value with label and value.
    /// - Parameter label: The label.
    /// - Parameter value: The parameter's value.
    public static func value(_ attr: NSAttributedString, _ value: Value) -> UIPlottableValue<Value> {
        let plottableValue = UIPlottableValue<Value>(attr: attr, value: value)
        return plottableValue
    }
}

public protocol UISectorMarkProtocol {
    var sectorLayer: CAShapeLayer { get }
    var gradientLayer: CAGradientLayer { get }
}

public struct UISectorMark: UISectorMarkProtocol {
    public var sectorLayer: CAShapeLayer
    private var textLayer: CATextLayer
    public var gradientLayer: CAGradientLayer
    /// Creates a sector mark, which uses the angular size to represent the proportion of the value to the sum of all values.
    ///
    /// Use this initializer to map angular positions to a sector for each data element.
    ///
    /// - Parameters:
    ///   - angle: A plottable value that will map to the angular size of the sector. It’s either a value that the angle within the full circle will be proportional with, or a value range for explicit start/end angles.
    ///   - innerRadius: The inner radius of the sector. It is either a size in points, or a `.ratio` or `.inset` relative to the outer radius.
    ///   - outerRadius: The outer radius of the sector. It is either a size in points, or a `.ratio`or `.inset` relative to the available plot area.
    ///   - angularInset: A radius for the corners of the sector.
    ///
    public init(angle angleConfigs: UIPlottableValue<some NSNumber>) {
        
        let rect = CGRect(origin: .zero, size: .init(width: 200, height: 200))
        
        let path = UIBezierPath()
        path.move(to: .init(x: 100, y: 100))
        path.addArc(withCenter: .init(x: 100, y: 100),
                    radius: 100,
                    startAngle: -CGFloat.pi/2,
                    endAngle: (CGFloat(angleConfigs.value.doubleValue * 360 / 100) * CGFloat.pi / 180) - CGFloat.pi/2,
                    clockwise: true)
        path.close()
        
        sectorLayer = CAShapeLayer()
        sectorLayer.frame = rect
        sectorLayer.fillColor = UIColor.black.cgColor
        sectorLayer.path = path.cgPath
        
        textLayer = CATextLayer()
        textLayer.frame = rect
        textLayer.fontSize = 12
        textLayer.alignmentMode = .center
        textLayer.string = angleConfigs.attr.string
        textLayer.isWrapped = true
        textLayer.truncationMode = .end
        //textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.foregroundColor = UIColor.black.cgColor
        
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = rect
        gradientLayer.type = .radial
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.gray.cgColor]
        gradientLayer.startPoint = .init(x: 0.5, y: 0.5)
        gradientLayer.endPoint = .init(x: 1, y: 1)
        
        gradientLayer.addSublayer(textLayer)
        //sectorLayer.addSublayer(gradientLayer)
        gradientLayer.mask = sectorLayer
        
    }
    
    public func foregroundStyle(_ colors: [UIColor]) -> Self {
        gradientLayer.colors = colors.map { $0.cgColor }
        return self
    }

}

public class UIChart: UIView {
    
    public init<Data, C>(_ data: Data, content: @escaping (Data.Element) -> C)
    where Data : RandomAccessCollection, C : UISectorMarkProtocol, Data.Element : Identifiable {
        super.init(frame: .zero)
        data.forEach {
            layer.addSublayer(content($0).gradientLayer)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

