//
//  CreatePasswordViewController.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 17/10/2022.
//

import UIKit

protocol CreatePassswordTextFieldDelegates: UITextFieldDelegate & AnyObject {
    func createButtonClicked()
}

final class CreatePasswordViewController: AnubisBaseViewController, CreatePasswordVCDelegates, CreatePassswordTextFieldDelegates {
    
    var presenter: CreatePasswordPresenter!

    internal var keyboardManager: KeyboardManager!
    
    internal lazy var mainView: AnubisPasswordTextFieldsView = {
        let baseView = AnubisPasswordTextFieldsView(includeCreateButton: true, delegates: self)
        baseView.translatesAutoresizingMaskIntoConstraints = true
        return baseView
    }()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle(viewTitle: "Create Password")
    }
    
    func createButtonClicked() {
        presenter.createEntity()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldEvents(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldEvents(textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == mainView.passwordTextField && !mainView.passwordTextField.isSecureTextEntry) {
            mainView.passwordTextField.isSecureTextEntry = true
        }
        return true
    }
    
    private func textFieldEvents(_ textField: UITextField) {
        switch(textField) {
            case mainView.titleTextField:
                presenter.setTitle(textField.text)
            case mainView.websiteAddressTextField:
                presenter.setWebsiteAddress(textField.text)
            case mainView.emailAddressTextField:
                presenter.setEmailAddress(textField.text)
            case mainView.passwordTextField:
                presenter.setSecurePassword(textField.text)
        default:
            break
        }
    }
    enum textFieldsError: String, LocalizedError {
        case titleError = "Title cannot be more than 32 characters"
        case websiteAddressError = "Website cannot be more than 48 characters or less than 6 characters."
        case emailAddressError = "Email Address cannot be more than 64 characters or less than 4 characters."
        case passwordError = "Password cannot be more than 48 characters or less than 6 characters."
        var errorDescription: String? {
            return self.rawValue
        }
    }
    
    func validateTextFields() throws {
        if mainView.titleTextField.text?.count ?? 0 > 32 {
            throw textFieldsError.titleError
        }
        guard mainView.websiteAddressTextField.validateInputs() else {
            throw textFieldsError.websiteAddressError
        }
        guard mainView.emailAddressTextField.validateInputs() else {
            throw textFieldsError.emailAddressError
        }
        guard mainView.passwordTextField.validateInputs() else {
            throw textFieldsError.passwordError
        }
    }
}
