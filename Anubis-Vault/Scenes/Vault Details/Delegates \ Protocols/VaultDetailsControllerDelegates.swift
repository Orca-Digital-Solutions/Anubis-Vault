//
//  VaultDetailsControllerDelegates.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import Foundation

protocol VaultDetailsVCDelegates: AnyObject {
    var presenter: VaultDetailsPresenter! { get set }
    func setTitleText(_ title: String!)
    func setWebsiteAddress(_ websiteAddress: String!)
    func setEmailAddress(_ emailAddress: String!)
    func setEntityPassword(_ entityPassword: String!)
}

typealias VaultDetailsDelegates = VaultDetailsVCDelegates & BaseViewControllerDelegates
