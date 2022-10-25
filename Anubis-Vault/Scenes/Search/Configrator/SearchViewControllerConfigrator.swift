//
//  SearchViewControllerConfigrator.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import UIKit

final class SearchViewControllerConfigrator {
    
    class func createSearchView(_ searchText: String!) -> UIViewController {
        let viewController = SearchViewController()
        let realmRepo = RealmManager()
        let router = SearchVCRouter(view: viewController)
        let presenter = SearchViewPresenter(view: viewController, router: router, realmRepository: realmRepo, searchText: searchText)
        viewController.presenter = presenter
        return viewController
    }
    
}


