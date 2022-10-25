//
//  CreatePasswordRouter.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 23/10/2022.
//

import UIKit

final class CreatePasswordRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func dismissView() {
        self.view?.navigationController?.popViewController(animated: true)
    }
}
