//
//  AnubisPasswordTextFieldsView.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 18/10/2022.
//

import UIKit

final class AnubisPasswordTextFieldsView: AnubisBaseUIView, UITextFieldDelegate {
    
    private weak var delegates: CreatePassswordTextFieldDelegates?
    
    @Published private(set) var bottomConstraint: NSLayoutConstraint!
    
    private lazy var scrollView: UIScrollView = {
        let baseScrollView = UIScrollView()
        baseScrollView.backgroundColor = .viewBackgroundColor
        baseScrollView.translatesAutoresizingMaskIntoConstraints = false
        return baseScrollView
    }()
    
    private(set) lazy var containerView: AnubisBaseUIView = {
        let baseView = AnubisBaseUIView()
        return baseView
    }()

    private(set) lazy var titleTextField: AnubisBaseUITextField = {
        let baseTextField = AnubisBaseUITextField(placeHolder: "Optional", textFieldType: .withLabel, textFieldLabelText: "Title:")
        baseTextField.validateRegex = "^.{0,32}$"
        baseTextField.delegate = delegates ?? self
        return baseTextField
        
    }()
    
    private(set) lazy var websiteAddressTextField: AnubisBaseUITextField = {
        let baseTextField = AnubisBaseUITextField(placeHolder: "Required", textFieldType: .withLabel, textFieldLabelText: "Website Address:")
        baseTextField.validateRegex = "((http|https)://)?([(w|W)]{3}+\\.)?+(.)+\\.+[A-Za-z]{2,3}+(\\.)?+(/(.)*)?"
        baseTextField.delegate = delegates ?? self
        baseTextField.keyboardType = .URL
        if(delegates == nil) { baseTextField.setupCopyButton() }
        return baseTextField
    }()
    
    private(set) lazy var emailAddressTextField: AnubisBaseUITextField = {
        let baseTextField = AnubisBaseUITextField(placeHolder: "Required", textFieldType: .withLabel, textFieldLabelText: "Email Address:")
        baseTextField.validateRegex = "[[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]]{5,64}"
        baseTextField.delegate = delegates ?? self
        baseTextField.keyboardType = .emailAddress
        if(delegates == nil) { baseTextField.setupCopyButton() }
        return baseTextField
    }()

    private(set) lazy var passwordTextField: AnubisBaseUITextField = {
        let baseTextField = AnubisBaseUITextField(placeHolder: "Required", textFieldType: .withLabel, textFieldLabelText: "Password:")
        baseTextField.validateRegex = "^.{6,48}$"
        baseTextField.delegate = delegates ?? self
        baseTextField.keyboardType = .asciiCapable
        if(delegates == nil) { baseTextField.setupCopyButton() }
        return baseTextField
    }()
    
    private(set) lazy var createButton: AnubisBaseUIButton = {
        let baseButton = AnubisBaseUIButton(buttonTitleText: "Create", backgroundColor: .tintColor)
        baseButton.addTarget(self, action: #selector(createButtonClicked(_:)), for: .touchUpInside)
        return baseButton
    }()
   
    init(includeCreateButton: Bool = false, delegates: CreatePassswordTextFieldDelegates? = nil) {
        super.init()
        self.delegates = delegates
        setupScrollView()
        setupTitleTextField()
        setupWebsiteTextField()
        setupEmailAddressTextField()
        setupPasswordTextField()
        includeCreateButton ? setupCreateButton() : nil
    }

    private func setupScrollView() {
        
        self.addSubview(scrollView)
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
        
        scrollView.addSubview(containerView)
        let containterViewConstraints = [
            containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            containerView.heightAnchor.constraint(greaterThanOrEqualTo: self.scrollView.heightAnchor)
        ]
        NSLayoutConstraint.activate(containterViewConstraints)
    }
    
    private func setupTitleTextField() {
        
        containerView.addSubview(titleTextField)
        let titleTextFieldConstraints = [
            titleTextField.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 15),
            titleTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
            titleTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(titleTextFieldConstraints)
        
    }
    
    private func setupWebsiteTextField() {
        
        containerView.addSubview(websiteAddressTextField)
        let websiteTextFieldConstraints = [
            websiteAddressTextField.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 15),
            websiteAddressTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
            websiteAddressTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(websiteTextFieldConstraints)
        
    }
    
    private func setupEmailAddressTextField() {
        
        containerView.addSubview(emailAddressTextField)
        let emailAddressTextFieldConstraints = [
            emailAddressTextField.topAnchor.constraint(equalTo: self.websiteAddressTextField.bottomAnchor, constant: 15),
            emailAddressTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
            emailAddressTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(emailAddressTextFieldConstraints)
        
    }
    
    private func setupPasswordTextField() {
        
        containerView.addSubview(passwordTextField)
        let passwordTextFieldConstraitns = [
            passwordTextField.topAnchor.constraint(equalTo: emailAddressTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(passwordTextFieldConstraitns)
        
    }
    
    private func setupCreateButton() {
        
        containerView.addSubview(createButton)
        let createButtonConstraints = [
            createButton.heightAnchor.constraint(equalTo: self.passwordTextField.heightAnchor, multiplier: 1),
            createButton.topAnchor.constraint(greaterThanOrEqualTo: self.passwordTextField.bottomAnchor, constant: 35),
            createButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -15),
            createButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
            createButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(createButtonConstraints)
        
        bottomConstraint = createButtonConstraints[2]
    }
    
    @objc private func createButtonClicked(_ sender: AnubisBaseUIButton!) {
        delegates?.createButtonClicked()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
