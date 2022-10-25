//
//  AnubisBaseUITextField.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 16/10/2022.
//

import UIKit

enum AnubisUITextFieldType {
    case ordinary
    case withLabel
}

final class AnubisBaseUITextField: UITextField {
    
    // MARK: - Properties
    
    var validateRegex: String?
    
    private var textFieldType: AnubisUITextFieldType = .ordinary
    
    private lazy var textFieldLabel: UILabel = {
        let textFieldLabel = UILabel()
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        textFieldLabel.textColor = .labelColor
        return textFieldLabel
    }()
    
    private var padding: UIEdgeInsets {
        var padding = UIEdgeInsets()
        
        switch(textFieldType) {
            case .ordinary:
                padding.top = 15
                padding.bottom = 15
                padding.right = 40
                if self.leftViewMode == .always {
                    padding.left = 40
                } else {
                    padding.left = 20
                    
                }
            case .withLabel:
                padding.top = 20
                padding.bottom = 6.25
                padding.right = 40
                if self.leftViewMode == .always {
                    padding.left = 35
                } else {
                    padding.left = 10
                    
                }
        }
        return padding
    }
    
    override func borderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let clearButtonRect = super.clearButtonRect(forBounds: bounds)
        return clearButtonRect.offsetBy(dx: -10, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let leftViewRect = super.leftViewRect(forBounds: bounds)
        switch(textFieldType) {
        case .ordinary:
            return leftViewRect.offsetBy(dx: 10, dy: 0)
        case .withLabel:
            return leftViewRect.offsetBy(dx: 10, dy: 7.5)
        }
    }
    
    // MARK: - Initialization
    
    init(placeHolder: String? = nil, textFieldType: AnubisUITextFieldType = .ordinary, textFieldLabelText: String? = nil) {
        super.init(frame: CGRect.zero)
        self.setupTextField(textFieldType)
        self.setupTextLabel(textFieldLabelText)
        self.setPlaceHolder(placeHolder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 6
        self.setupViewShadows()
    }
    
    private func setupTextField(_ textFieldType: AnubisUITextFieldType) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textFieldType = textFieldType
        self.backgroundColor = .subViewsBackgroundColor
        
        self.borderStyle = .none
        self.defaultTextAttributes = [.foregroundColor : UIColor.label, .font: UIFont.preferredFont(forTextStyle: .subheadline)]
        self.clearButtonMode = .whileEditing
    }
    
    private func setupTextLabel(_ textFieldLabelText: String?) {
        guard let textFieldLabelText = textFieldLabelText else { return }
        
        self.addSubview(textFieldLabel)
        let textFieldConstraints = [
            textFieldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            textFieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textFieldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(textFieldConstraints)
        
        textFieldLabel.text = textFieldLabelText
    }
    
    // MARK: - Functions
    
    /// Add Place holder text to textfield
    func setPlaceHolder(_ placeHolder: String?) {
        guard let placeHolder = placeHolder else { return }
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
    }
    
    /// Add Image to text field, it's must be system icon
    func setupLetfImage(baseName: String!) {
        let imageView = UIImageView()
        imageView.image = UIImage.createFromBaseName(baseName, tintColor: .systemGray)
        self.leftView = imageView
        self.leftViewMode = .always
    }
    
    func setupCopyButton() {
        let copyButton = AnubisBaseUIButton(baseImageName: "rectangle.on.rectangle")
        copyButton.addTarget(self, action: #selector(copyButtonClicked(_:)), for: .touchUpInside)
        self.rightView = copyButton
        self.rightViewMode = .always
    }
    
    @objc private func copyButtonClicked(_ sender: AnubisBaseUIButton!) {
        sender.animateViewFadeInOut()
        UIPasteboard.general.string = self.text
    }
    
    func validateInputs() -> Bool {
        guard let text = self.text, let validateRegex = validateRegex else { return false }
        let regaxPredicate = NSPredicate(format:"SELF MATCHES %@", validateRegex)
        return regaxPredicate.evaluate(with: text)
    }
}
