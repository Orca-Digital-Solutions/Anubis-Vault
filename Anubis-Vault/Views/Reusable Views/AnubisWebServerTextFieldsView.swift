//
//  AnubisWebServerTextFieldsView.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 18/10/2022.
//

import UIKit

// To use in next versions..

final class AnubisWebServerTextFieldsView: AnubisBaseUIView, UITextFieldDelegate {

    @Published private(set) var bottomConstraint: NSLayoutConstraint!
    
    private lazy var scrollView: UIScrollView = {
        let baseScrollView = UIScrollView()
        baseScrollView.translatesAutoresizingMaskIntoConstraints = false
        return baseScrollView
    }()
    
    private(set) lazy var containerView: AnubisBaseUIView = {
        let baseView = AnubisBaseUIView()
        return baseView
    }()

    private(set) lazy var ipAddressTextField: AnubisBaseUITextField = {
        let baseTextField = AnubisBaseUITextField(
            placeHolder: "Required", textFieldType: .withLabel, textFieldLabelText: "IP-Address:"
        )
        baseTextField.delegate = self
        return baseTextField
    }()
    
    private lazy var friendlyNameTextField: AnubisBaseUITextField = {
        let baseTextField = AnubisBaseUITextField(
            placeHolder: "Optional", textFieldType: .withLabel, textFieldLabelText: "Friendly Name:"
        )
        baseTextField.delegate = self
        return baseTextField
    }()
    
    private lazy var userNameTextField: AnubisBaseUITextField = {
        let baseTextField = AnubisBaseUITextField(
            placeHolder: "Required", textFieldType: .withLabel, textFieldLabelText: "User Name:"
        )
        baseTextField.delegate = self
        return baseTextField
    }()

    private(set) lazy var passwordTextField: AnubisBaseUITextField = {
        let baseTextField = AnubisBaseUITextField(
            placeHolder: "Required", textFieldType: .withLabel, textFieldLabelText: "Password:"
        )
        baseTextField.delegate = self
        baseTextField.isSecureTextEntry = true
        return baseTextField
    }()
    
    private lazy var createButton: AnubisBaseUIButton = {
        let baseButton = AnubisBaseUIButton(buttonTitleText: "Create")
        return baseButton
    }()

    init(includeCreateButton: Bool = false) {
        super.init()
        setupScrollView()
        setupIPAddressTextField()
        setupFriendlyNameTextField()
        setupUserNameTextField()
        setupPasswordTextField()
        guard includeCreateButton else { return }
        setupCreateButton()
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
    
    private func setupIPAddressTextField() {
        
        self.containerView.addSubview(ipAddressTextField)
        let ipAddressTextFieldConstraitns = [
            ipAddressTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            ipAddressTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            ipAddressTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(ipAddressTextFieldConstraitns)
        
    }
    
    private func setupFriendlyNameTextField() {
        
        self.containerView.addSubview(friendlyNameTextField)
        let friendlyNameTextFieldConstraitns = [
            friendlyNameTextField.topAnchor.constraint(equalTo: ipAddressTextField.bottomAnchor, constant: 15),
            friendlyNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            friendlyNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(friendlyNameTextFieldConstraitns)
    }
    
    private func setupUserNameTextField() {
        
        self.containerView.addSubview(userNameTextField)
        let userNameTextFieldConstraitns = [
            userNameTextField.topAnchor.constraint(equalTo: friendlyNameTextField.bottomAnchor, constant: 15),
            userNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            userNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(userNameTextFieldConstraitns)
        
    }
    
    private func setupPasswordTextField() {
        
        self.containerView.addSubview(passwordTextField)
        let passwordTextFieldConstraitns = [
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(passwordTextFieldConstraitns)
        
    }
    
    private func setupCreateButton() {

        self.containerView.addSubview(createButton)
        let createButtonConstraints = [
            createButton.heightAnchor.constraint(equalTo: self.passwordTextField.heightAnchor, multiplier: 1),
            createButton.topAnchor.constraint(greaterThanOrEqualTo: self.passwordTextField.bottomAnchor, constant: 40),
            createButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -15),
            createButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
            createButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(createButtonConstraints)
        self.bottomConstraint = createButtonConstraints[2]
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
