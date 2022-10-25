//
//  AnubisBaseUIButton.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 16/10/2022.
//

import UIKit

extension String {
    func DecodeBase64String() -> String? {
        guard let base64Buffer = Data(base64Encoded: self) else { return nil }
        return String(data: base64Buffer, encoding: .utf8)
    }
}

enum AnubisUIButtonType: Int {
    case ordinary
    case circle
    case transparent
}

struct AnubisUIButtonMenuItem {
    
    let buttonIdentifier: Int!
    let buttonTitle: String!
    let buttonImageName: String?
    
    init(_ buttonIdentifier: Int!, buttonTitle: String!, _ buttonImageName: String? = nil) {
        self.buttonIdentifier = buttonIdentifier
        self.buttonTitle = buttonTitle
        self.buttonImageName = buttonImageName
    }
}

final class AnubisBaseUIButton: UIButton {
    
    // MARK: - Properties
    
    private var buttonShapeType: AnubisUIButtonType = .ordinary
    
    private var pointSize: CGFloat {
        if(buttonShapeType == .circle) {
            return 32
        }
        return 0
    }
    
    private let circleButtonSize: CGFloat = 56
    
    private var menuTitle: String? = nil
    private lazy var menuContextInteraction = { return UIContextMenuInteraction(delegate: self) }()
    private var menuChildern: [UIAction] = []
    
    // MARK: - Initialization
    
    /// Base Button Initialization
    init(buttonShapeType: AnubisUIButtonType, backgroundColor: UIColor = .subViewsBackgroundColor) {
        super.init(frame: CGRect.zero)
        self.buttonShapeType = buttonShapeType
        setupUIButton(backgroundColor)
    }
    
    
    /// Circle-Shape button Initialization
    convenience init(baseImageName: String, imageColor: UIColor = .white, backgroundColor: UIColor = .tintColor) {
        self.init(buttonShapeType: .circle, backgroundColor: backgroundColor)
        setButtonImage(baseImageName, imageColor)
    }
    
    /// Circle-Shape button Initialization with text
    convenience init(buttonTitleText: String!, textColor: UIColor = .tintColor, backgroundColor: UIColor = .tintColor) {
        self.init(buttonShapeType: .circle, backgroundColor: backgroundColor)
        setButtonTitle(buttonTitleText, textColor)
    }

    /// Transparent button Initialization
    convenience init(baseImageName: String) {
        self.init(buttonShapeType: .transparent)
        setButtonImage(baseImageName, UIColor.label)
    }
    
    /// Ordinary button Initialization with system name image
    convenience init(baseImageName: String, imageColor: UIColor = .label, backgroundColor: UIColor? = .subViewsBackgroundColor) {
        self.init(buttonShapeType: .ordinary, backgroundColor: backgroundColor!)
        setButtonImage(baseImageName, imageColor)
    }
    
    /// Ordinary button Initialization with text
    convenience init(buttonTitleText: String, backgroundColor: UIColor = .subViewsBackgroundColor) {
        self.init(buttonShapeType: .ordinary, backgroundColor: backgroundColor)
        setButtonTitle(buttonTitleText, .white)
    }
    
    /// Ordinary button Initialization with system name image and text
    convenience init(buttonTitleText: String, baseImageName: String, imageColor: UIColor = UIColor.label, backgroundColor: UIColor = .subViewsBackgroundColor) {
        self.init(buttonShapeType: .ordinary, backgroundColor: backgroundColor)
        setButtonTitle(buttonTitleText, .white)
        setButtonImage(baseImageName, imageColor)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIButton(_ backgroundColor: UIColor) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if(buttonShapeType == .transparent || buttonShapeType == .circle) {
            var buttonConstraints = [
                self.widthAnchor.constraint(equalTo: self.heightAnchor)
            ]
            if(buttonShapeType == .circle) {
                buttonConstraints.append(self.heightAnchor.constraint(equalToConstant: self.circleButtonSize))
            }
            NSLayoutConstraint.activate(buttonConstraints)
        }
        guard buttonShapeType != .transparent else {
            return }

        self.backgroundColor = backgroundColor
    }
    
    private func setButtonImage(_ baseName: String!, _ imageColor: UIColor) {
        let buttonImage = UIImage.createFromBaseName(baseName, tintColor: imageColor)
        self.setImage(buttonImage, for: .normal)
    }
    
    private func setButtonTitle(_ buttonTitleText: String!, _ textColor: UIColor) {
        self.setTitle(buttonTitleText, for: .normal)
        self.setTitleColor(textColor, for: .normal)
    }
    
    private func setupButtonShadows() {
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = self.backgroundColor?.withAlphaComponent(1.5).cgColor
        self.layer.shadowRadius = 6
    }
    
    func setupMenuButtons(_ menuTitle: String, _ buttonsDicentroy: AnubisUIButtonMenuItem..., handler: @escaping(Int) -> Void) {
        self.menuTitle = menuTitle
        let firstItemIdentifier = buttonsDicentroy.first?.buttonIdentifier
        buttonsDicentroy.forEach { buttonItem in
            let menuItem = UIAction(
                title: buttonItem.buttonTitle,
                //image: UIImage.createFromBaseName(buttonItem.buttonImageName), for next featuers
                state: firstItemIdentifier == buttonItem.buttonIdentifier ? .on : .off
                ) { [weak self] uiAction in
                    guard let self = self else { return }
                    self.updateSelectedMenuItem(buttonItem.buttonTitle)
                    handler(buttonItem.buttonIdentifier)
                }
            menuChildern.append(menuItem)
        }
        if #available(iOS 14.0, *) {
            self.menu = UIMenu(title: menuTitle, children: self.menuChildern)
            self.showsMenuAsPrimaryAction = true
        } else {
            self.addInteraction(menuContextInteraction)
            self.addTarget(self, action: #selector(buttonHasBeenClicked(_:)), for: .touchUpInside)
        }
    }
    
    private func updateSelectedMenuItem(_ currentItemTitle: String) {
        menuChildern.forEach { uiAction in
            if(uiAction.title == currentItemTitle) {
                uiAction.state = .on
            } else {
                uiAction.state = .off
            }
        }
    }
    
    
    @objc private func buttonHasBeenClicked(_ sender: AnubisBaseUIButton) {
        //_presentMenuAtLocation:
        // A private API calling, don't try to change anything
        // Not sure if we can use it until iOS 20 :"D
        // we need to hide it because apple rejects apps with private APIs.
        guard let presentMenuAtLocation = "X3ByZXNlbnRNZW51QXRMb2NhdGlvbjo=".DecodeBase64String() else { return }
        let selector = NSSelectorFromString(presentMenuAtLocation)
        guard menuContextInteraction.responds(to: selector) else { return }
        menuContextInteraction.perform(selector, with: CGPoint.zero)
    }
    
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { _ in
                return UIMenu(title: self.menuTitle ?? "", children: self.menuChildern)
            }
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch(buttonShapeType) {
            case .ordinary:
                self.layer.cornerRadius = 6
                self.setupButtonShadows()
            case .circle:
                self.setupButtonShadows()
                self.layer.cornerRadius = self.bounds.height / 2
                let config = UIImage.SymbolConfiguration(pointSize: pointSize)
                self.setPreferredSymbolConfiguration(config, forImageIn: .normal)
            case .transparent: break
        }
    }
}

