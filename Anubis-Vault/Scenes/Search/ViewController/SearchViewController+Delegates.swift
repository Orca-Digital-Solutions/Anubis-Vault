//
//  SearchViewController+Delegates.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import UIKit

extension SearchViewController: SearchVCDelegates {

    func onSuccess() {
        self.searchTableView.reloadData()
    }
    
}

