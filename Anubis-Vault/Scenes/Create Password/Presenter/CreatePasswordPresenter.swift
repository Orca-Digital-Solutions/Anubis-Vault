//
//  CreatePasswordPresenter.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 23/10/2022.
//

import Foundation

final class CreatePasswordPresenter {
    
    //MARK: - Proprietes
    
    private weak var view: CreatePasswordDelegates?
    private var router: CreatePasswordRouter!
    private var realmRepository: Repository!
    private var passwordBuilder: PasswordBuilder!
    private var presenter: VaultPresenterDelegation!

    // MARK: - Initialization

    init(view: CreatePasswordDelegates?, router: CreatePasswordRouter!, realmRepository: Repository!, passwordBuilder: PasswordBuilder!, presenter: VaultPresenterDelegation) {
        self.view = view
        self.router = router
        self.realmRepository = realmRepository
        self.passwordBuilder = passwordBuilder
        self.presenter = presenter
    }
    
    // MARK: - Functions

    func setTitle(_ title: String?) {
        self.passwordBuilder.title = title
    }
    
    func setWebsiteAddress(_ websiteAddress: String?) {
        guard let websiteAddress = websiteAddress else { return }
        self.passwordBuilder.websiteAddress = websiteAddress
    }
    
    func setEmailAddress(_ emailAddress: String?) {
        guard let emailAddress = emailAddress else { return }
        self.passwordBuilder.emailAddress = emailAddress
    }
    
    func setSecurePassword(_ securePassword: String?) {
        guard let securePassword = securePassword else { return }
        self.passwordBuilder.securePassword = securePassword
    }
    
    func createEntity() {
        self.view?.showLoading()
        do {
            try self.view?.validateTextFields()
            let vaultEntity = try self.passwordBuilder.buildEntity()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                self.realmRepository.createEntity(entity: vaultEntity) { createResult in
                    DispatchQueue.main.async {
                        self.view?.hideLoading()
                        switch(createResult) {
                            case .success(let createdEntity):
                                self.presenter.vaultCreated(createdEntity as! VaultPasswsordEntity)
                                self.router.dismissView()
                            case .failure(let errorCode):
                                self.view?.showAlertView(alertMessage: errorCode.localizedDescription)
                        }
                    }
                }
            }
        } catch {
            self.view?.hideLoading()
            self.view?.showAlertView(alertMessage: error.localizedDescription)
        }
    }
}

