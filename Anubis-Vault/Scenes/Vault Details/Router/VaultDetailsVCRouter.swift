//
//  VaultDetailsVCRouter.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import UIKit

final class VaultDetailsVCRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func dismissView() {
        guard let navigationController = self.view?.navigationController else {
            self.view?.dismiss(animated: true)
            return
        }
        navigationController.popViewController(animated: true)
    }
    
}

