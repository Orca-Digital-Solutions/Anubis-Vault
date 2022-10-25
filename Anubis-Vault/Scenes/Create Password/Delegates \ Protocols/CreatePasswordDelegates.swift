//
//  CreatePasswordDelegates.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 23/10/2022.
//

import Foundation

protocol CreatePasswordVCDelegates: AnyObject {
    var presenter: CreatePasswordPresenter! { get set }
    func validateTextFields() throws
}

typealias CreatePasswordDelegates = CreatePasswordVCDelegates & BaseViewControllerDelegates
