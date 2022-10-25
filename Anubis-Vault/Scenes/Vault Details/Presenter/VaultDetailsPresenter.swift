//
//  VaultDetailsPresenter.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import Foundation

final class VaultDetailsPresenter {
    private let entity: VaultPasswsordEntity
    private weak var view: VaultDetailsDelegates?
    private var router: VaultDetailsVCRouter!
    
    init(entity: VaultPasswsordEntity, view: VaultDetailsDelegates, router: VaultDetailsVCRouter!) {
        self.entity = entity
        self.view = view
        self.router = router
    }
    
    func viewWillAppear() {
        view?.setTitleText(entity.title ?? "No Title")
        view?.setWebsiteAddress(entity.websiteAddress)
        view?.setEmailAddress(entity.emailAddress)
        view?.setEntityPassword(entity.securePassword)
    }
    
    func doneButtonClicked() {
        self.router.dismissView()
    }
    
}
