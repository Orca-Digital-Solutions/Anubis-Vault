//
//  CreatePasswordViewControllerConfigrator.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 23/10/2022.
//

import UIKit

final class CreatePasswordViewControllerConfigrator {
    
    class func createPasswordVC(presenter: VaultPresenterDelegation) -> UIViewController {
        let view = CreatePasswordViewController()
        let keyboardManager = KeyboardManager(view: view.view, publisher: view.mainView.$bottomConstraint)
        view.keyboardManager = keyboardManager
        let realmRepository = RealmManager()
        let passwordBuilder =  PasswordBuilder()
        let router = CreatePasswordRouter(view: view)
        let presenter = CreatePasswordPresenter(view: view, router: router, realmRepository: realmRepository, passwordBuilder: passwordBuilder, presenter: presenter)
        view.presenter = presenter
        return view
    }
    
}
