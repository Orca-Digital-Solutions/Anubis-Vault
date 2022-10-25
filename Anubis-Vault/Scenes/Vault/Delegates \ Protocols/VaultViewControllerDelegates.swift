//
//  VaultViewControllerDelegates.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 21/10/2022.
//

import Foundation

protocol VaultVCDelegates: AnyObject {
    var preseneter: VaultVCPreseneter! { get set }
    func insertRow(at indexPath: [IndexPath])
    func deleteRow(at indexPath: [IndexPath])
    func onSuccess()
}

typealias VaultDelegates = VaultVCDelegates & BaseViewControllerDelegates

