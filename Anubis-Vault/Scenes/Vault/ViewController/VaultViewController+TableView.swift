//
//  VaultViewController+TableView.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 17/10/2022.
//

import UIKit

extension VaultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let entitesCount = preseneter.entitesCount
        guard let tableView = tableView as? AnubisBaseTableView else { return entitesCount}
        if(entitesCount == 0) {
            tableView.showEmptyBackground(message: "You don't save any passwords yet.\nyou can create by clicking (+) button.")
        } else {
            tableView.hideEmptyBackground()
        }
        return entitesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tabelViewCell = tableView.dequeueCell() as AnubisVaultTableViewCell
        preseneter.configureCell(vaultCell: tabelViewCell, at: indexPath)
        return tabelViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        super.touchesBegan(Set<UITouch>(), with: nil)
        preseneter.pushDetails(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let vaultCell = tableView.cellForRow(at: indexPath) as? AnubisVaultTableViewCell else {
            return nil
        }
        let deleteAction = UIContextualAction(style: .normal, title: nil) { [ weak self ] _, _, completionHandler in
            guard let self = self else { return }
            self.showConfirmationView(alertMessage: "deleting an entity is definitive, no way to restore it, are you sure?") { [weak self] actionResult in
                guard let self = self else { return }
                if(actionResult == true) {
                    self.preseneter.deleteVault(vaultCell: vaultCell, at: indexPath)
                }
                completionHandler(actionResult)
            }
        }
        deleteAction.image = UIImage.createFromBaseName("trash.fill", tintColor: .red)
        deleteAction.backgroundColor = .subViewsBackgroundColor
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

