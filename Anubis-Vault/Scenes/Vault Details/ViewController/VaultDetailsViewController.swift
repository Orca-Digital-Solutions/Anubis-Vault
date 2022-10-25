//
//  VaultDetailsViewController.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 24/10/2022.
//

import UIKit

final class VaultDetailsViewController: AnubisBaseViewController, VaultDetailsVCDelegates {
    
    var presenter: VaultDetailsPresenter!
    
    private lazy var doneButton: AnubisBaseUIButton = {
        let baseButton = AnubisBaseUIButton(buttonTitleText: "Done", backgroundColor: .tintColor)
        baseButton.addTarget(self, action: #selector(doneButtonClicked(_:)), for: .touchUpInside)
        return baseButton
    }()
    
    internal lazy var mainView: AnubisPasswordTextFieldsView = {
        let baseView = AnubisPasswordTextFieldsView()
        baseView.translatesAutoresizingMaskIntoConstraints = true
        return baseView
    }()
    
    override func loadView() {
        self.view = mainView
    }
    
    private func setupDoneButton() {
        
        self.mainView.containerView.addSubview(doneButton)
        let doneButtonConstraints = [
            doneButton.heightAnchor.constraint(equalTo: self.mainView.passwordTextField.heightAnchor, multiplier: 1),
            doneButton.topAnchor.constraint(greaterThanOrEqualTo: self.mainView.passwordTextField.bottomAnchor, constant: 35),
            doneButton.bottomAnchor.constraint(equalTo: self.mainView.containerView.bottomAnchor, constant: -15),
            doneButton.leadingAnchor.constraint(equalTo: self.mainView.containerView.leadingAnchor, constant: 15),
            doneButton.trailingAnchor.constraint(equalTo: self.mainView.containerView.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(doneButtonConstraints)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle(viewTitle: "Details")
        setupDoneButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @objc private func doneButtonClicked(_ sender: AnubisBaseUIButton!) {
        presenter.doneButtonClicked()
    }
    
    func setTitleText(_ title: String!) {
        mainView.titleTextField.text = title
    }
    
    func setWebsiteAddress(_ websiteAddress: String!) {
        mainView.websiteAddressTextField.text = websiteAddress
    }
    
    func setEmailAddress(_ emailAddress: String!) {
        mainView.emailAddressTextField.text = emailAddress
    }
    
    func setEntityPassword(_ entityPassword: String!) {
        mainView.passwordTextField.text = entityPassword
    }
    
}
