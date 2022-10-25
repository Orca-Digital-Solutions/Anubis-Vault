//
//  SearchVCRouter.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import UIKit

final class SearchVCRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func pushDetailsView(for vaultEntity: VaultPasswsordEntity) {
        let viewController = VaultDetailsControllerConfigrator.createVaultDetails(vaultEntity)
        self.view?.present(viewController, animated: true)
    }

    func dismissView() {
        self.view?.navigationController?.popViewController(animated: true)
    }
    
}

