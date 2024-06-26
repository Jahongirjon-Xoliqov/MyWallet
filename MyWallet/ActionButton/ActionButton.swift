//
//  ActionButton.swift
//  MyWallet
//
//  Created by Dzakhon on 16/03/24.
//

import UIKit

class ActionButton: UIButton {
    
    var customImageView = UIImageView()
    var customTitleLabel = UILabel()

    enum ActionButtonControlState: UInt, CaseIterable {
        case normal = 0
        case highlighted = 1
        case disabled = 2
        case selected = 4
        case focused = 8
        case application = 16777216
        case reserved = 4294967295
    }

    final class ActionButtonStateConfig: Hashable {
        var image: UIImage?
        var imageTintColor: UIColor?
        var state: ActionButtonControlState
        var attributedText: NSAttributedString?
        init(state: ActionButtonControlState) {
            self.state = state
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(state)
        }
        static func == (lhs: ActionButtonStateConfig, rhs: ActionButtonStateConfig) -> Bool {
            lhs.state == rhs.state
        }
    }

    struct Converter {
        static func convert(from state: UIControl.State) -> ActionButtonControlState {
            ActionButtonControlState(rawValue: state.rawValue) ?? .normal
        }
        static func convert(from state: ActionButtonControlState) -> UIControl.State {
            UIControl.State(rawValue: state.rawValue)
        }
    }
    
    private var configurationsBag: Set<ActionButtonStateConfig> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        
        configureContentView()
        
        createOrUpdateTitleConfigsForAllCases(with: nil)
        createOrUpdateImageConfigsForAllCases(with: nil)
        
        addTarget(self, action: #selector(userIsHoldingTouch), for: .touchDown)
        addTarget(self, action: #selector(userDidEndTouching), for: .touchUpInside)
        addTarget(self, action: #selector(userDidCancelTouching), for: .touchDragExit)
        
    }
    
    func configureContentView() {
        addSubview(customImageView)
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        customImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        customImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        addSubview(customTitleLabel)
        customTitleLabel.numberOfLines = 2
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        customTitleLabel.topAnchor.constraint(equalTo: customImageView.bottomAnchor, constant: 10).isActive = true
        customTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        customTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        customTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
    
    @objc func userIsHoldingTouch() {
        applyConfigurations(for: .highlighted)
    }
    
    @objc func userDidEndTouching() {
        applyConfigurations(for: .normal)
    }
    
    @objc func userDidCancelTouching() {
        applyConfigurations(for: .normal)
    }
    
    private func applyConfigurations(for state: UIControl.State) {
        let currentState = Converter.convert(from: state)
        let configurations = configurationsBag.filter { $0.state == currentState }.first
        customImageView.image = configurations?.image
        customImageView.tintColor = configurations?.imageTintColor
        customTitleLabel.attributedText = configurations?.attributedText
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(nil, for: state)
        createOrUpdateConfig(for: Converter.convert(from: state)) { conf in
            conf.image = image
        }
    }
    
    func setImage(_ image: UIImage?, tintColor: UIColor?) {
        createOrUpdateImageConfigsForAllCases(with: image)
        createOrUpdateImageTintColorConfigsForAllCases(with: tintColor)
    }
    
    func setImage(_ image: UIImage?, tintColor: UIColor?, for state: UIControl.State) {
        setImage(image, for: state)
        createOrUpdateConfig(for: Converter.convert(from: state)) { conf in
            conf.imageTintColor = tintColor
        }
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle("", for: state)
    }
    
    override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        super.setAttributedTitle(nil, for: state)
        createOrUpdateConfig(for: Converter.convert(from: state)) { conf in
            conf.attributedText = title
        }
    }
    
    func setAttributedTitle(_ title: NSAttributedString?) {
        super.setAttributedTitle(nil, for: .normal)
        createOrUpdateAttributedTitleConfigsForAllCases(with: title)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        applyConfigurations(for: state)
    }
    
    private func createOrUpdateConfig(for state: ActionButtonControlState, param: (ActionButtonStateConfig) -> ()) {
        let conf = configurationsBag.filter { $0.state == state }
        if conf.isEmpty {
            let newConf = ActionButtonStateConfig(state: state)
            param(newConf)
            configurationsBag.insert(newConf)
        } else {
            conf.forEach {
                param($0)
            }
        }
    }
    
    private func createOrUpdateTitleConfigsForAllCases(with title: String?) {
        ActionButtonControlState.allCases.forEach {
            setTitle(title, for: Converter.convert(from: $0))
        }
    }
    
    private func createOrUpdateImageConfigsForAllCases(with image: UIImage?) {
        ActionButtonControlState.allCases.forEach {
            createOrUpdateConfig(for: $0) { conf in
                conf.image = image
            }
        }
    }
    
    private func createOrUpdateImageTintColorConfigsForAllCases(with color: UIColor?) {
        ActionButtonControlState.allCases.forEach {
            createOrUpdateConfig(for: $0) { conf in
                conf.imageTintColor = color
            }
        }
    }
    
    private func createOrUpdateAttributedTitleConfigsForAllCases(with attributedText: NSAttributedString?) {
        ActionButtonControlState.allCases.forEach {
            createOrUpdateConfig(for: $0) { conf in
                conf.attributedText = attributedText
            }
        }
    }
    
}


class BottomImageActionButton: ActionButton {
    override func configureContentView() {
        addSubview(customTitleLabel)
        customTitleLabel.numberOfLines = 2
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        customTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        customTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        customTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        addSubview(customImageView)
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        customImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        customImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        customImageView.topAnchor.constraint(equalTo: customTitleLabel.bottomAnchor, constant: 10).isActive = true
    }
}

class LeftAlignedActionButton: ActionButton {
    override func configureContentView() {
        addSubview(customImageView)
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        customImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        customImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        addSubview(customTitleLabel)
        customTitleLabel.numberOfLines = 2
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        customTitleLabel.topAnchor.constraint(equalTo: customImageView.bottomAnchor, constant: 10).isActive = true
        customTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        customTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        customTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
    }
}

class RightAlignedActionButton: ActionButton {
    override func configureContentView() {
        addSubview(customImageView)
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        customImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        customImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        addSubview(customTitleLabel)
        customTitleLabel.numberOfLines = 2
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        customTitleLabel.topAnchor.constraint(equalTo: customImageView.bottomAnchor, constant: 10).isActive = true
        customTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        customTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        customTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
}

class IdentityActionButton: ActionButton {
    
    override func configureContentView() {
        
        addSubview(customTitleLabel)
        customTitleLabel.numberOfLines = 2
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        customTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 15).isActive = true
        customTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(customImageView)
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        customImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        customImageView.trailingAnchor.constraint(equalTo: customTitleLabel.leadingAnchor, constant: -10).isActive = true
        
    }
}

class IdentityRightAlignedActionButton: ActionButton {
    
    private var gradientLayer: CAGradientLayer?
    
    override func configureContentView() {
        
        addSubview(customTitleLabel)
        customTitleLabel.numberOfLines = 2
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        customTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -15).isActive = true
        customTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(customImageView)
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        customImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        customImageView.leadingAnchor.constraint(equalTo: customTitleLabel.trailingAnchor, constant: 10).isActive = true
        
        gradientLayer = CAGradientLayer()
        gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1)
        layer.insertSublayer(gradientLayer ?? CALayer(), at: 0)
     
    }
    
    override func userIsHoldingTouch() {
        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }
    
    override func userDidEndTouching() {
        transform = .identity
    }
    
    override func userDidCancelTouching() {
        transform = .identity
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientLayer?.frame = bounds
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                gradientLayer?.colors = [UIColor.systemOrange.cgColor,
                                         UIColor.systemPink.cgColor]
            } else {
                gradientLayer?.colors = [UIColor.cyan.cgColor,
                                         UIColor.blue.cgColor]
            }
        }
    }
    
}

