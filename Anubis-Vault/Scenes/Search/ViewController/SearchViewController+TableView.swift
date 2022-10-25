//
//  SearchViewController+TableView.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let entitesCount = presenter.entitesCount
        guard let tableView = tableView as? AnubisBaseTableView, presenter.searchIsFinished else { return entitesCount}
        if(entitesCount == 0) {
            tableView.showEmptyBackground(message: "Search finished.\nNothing matches your inputs.")
        } else {
            tableView.hideEmptyBackground()
        }
        return entitesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tabelViewCell = tableView.dequeueCell() as AnubisVaultTableViewCell
        presenter.configureCell(vaultCell: tabelViewCell, at: indexPath)
        return tabelViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.pushDetails(at: indexPath)
    }
}

