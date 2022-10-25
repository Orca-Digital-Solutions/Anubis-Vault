//
//  SearchViewDelegates.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import Foundation

protocol SearchVCDelegates: AnyObject {
    var presenter: SearchViewPresenter! { get set }
    func onSuccess()
}

typealias SearchViewDelegates = SearchVCDelegates & BaseViewControllerDelegates

