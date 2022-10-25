//
//  VaultViewController+Delegates.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 19/10/2022.
//

import Foundation

extension VaultViewController: VaultVCDelegates {
    
    func insertRow(at indexPath: [IndexPath]) {
        self.vaultTableView.insertRows(at: indexPath, with: .automatic)
    }
    
    func deleteRow(at indexPath: [IndexPath]) {
        self.vaultTableView.deleteRows(at: indexPath, with: .fade)
    }
    
    func onSuccess() {
        self.vaultTableView.reloadData()
    }
    
}
