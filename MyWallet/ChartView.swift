//
//  ChartView.swift
//  MyWallet
//
//  Created by Dzakhon on 21/04/24.
//

import SwiftUI
import Charts

@available(iOS 17.0,*)
struct UIChartView: View {
    
    var products: [Product]
    
    var body: some View {
        Chart(products) { product in
            SectorMark(
                angle: .value(
                    Text(verbatim: product.title),
                    product.revenue
                )
            )
            .foregroundStyle(
                Color(UIColor(hex: product.colors.first!)!)
            )
            .cornerRadius(5)
            .foregroundStyle(
                by: .value(
                    Text(verbatim: product.title),
                    product.title
                )
            )
        }
    }
    
}


final class UIChartViewForLowerVersions: UIView {
    
    init(_ products: [Product]) {
        super.init(frame: .init(origin: .zero, size: .init(width: 200, height: 200)))
        
        let chartViews = UIChart(products) { product in
            UIChartViewSector(
                angle: UIChartViewSectorValue.value(
                    NSAttributedString(),
                    product.revenue
                )
            )
            .color(
                UIColor(hex: product.colors.first!)
            )
            .cornerRadius(5)
        }
        
        addSubview(chartViews)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

final class UIChart: UIView, ChartItem {
    typealias Item = Product
    
    init(_ products: [Item], repeatableClosure: (Item) -> CALayer) {
        super.init(frame: .init(origin: .zero, size: .init(width: 200, height: 200)))
        products.forEach { product in
            let chartSlice = repeatableClosure(product)
            layer.addSublayer(chartSlice)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func draw(with data: Item) {
        
    }
    
}

protocol ChartItem {
    associatedtype Item
}

protocol ChartItemValue {
    associatedtype Value
}

struct UIChartViewSectorValue: ChartItemValue {
    typealias Value = Double
    public static func value(_ label: NSAttributedString, _ value: Value) -> CALayer {
        let path = UIBezierPath()
        path.move(to: .init(x: 100, y: 100))
        path.addArc(withCenter: .init(x: 100, y: 100),
                    radius: 100,
                    startAngle: -CGFloat.pi/2,
                    endAngle: (CGFloat(value * 360 / 100) * CGFloat.pi / 180) - CGFloat.pi/2,
                    clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = .init(origin: .zero, size: .init(width: 200, height: 200))
        shapeLayer.path = path.cgPath
        return shapeLayer
    }
}

final class UIChartViewSector: CAShapeLayer {
    var angle: CALayer?
    init(angle: CALayer) {
        super.init(layer: angle)
        self.angle = angle
        addSublayer(angle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cornerRadius(_ value: CGFloat) -> CALayer {
        self.cornerRadius = value
        return self
    }
    
    func color(_ color: UIColor?) -> Self {
        (angle as! CAShapeLayer).fillColor = color?.cgColor
        return self
    }
    
}

