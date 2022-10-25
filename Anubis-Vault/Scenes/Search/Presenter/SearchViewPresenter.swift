//
//  SearchViewPresenter.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import Foundation

final class SearchViewPresenter {
    
    private weak var view: SearchViewDelegates?
    private var router: SearchVCRouter!
    
    var realmRepository: Repository!
    
    var searchText: String!

    init(view: SearchViewDelegates, router: SearchVCRouter!, realmRepository: Repository!, searchText: String!) {
        self.view = view
        self.router = router
        self.realmRepository = realmRepository
        self.searchText = searchText
    }
    private lazy var vaultEntites: [VaultPasswsordEntity] = {
        var entites: [VaultPasswsordEntity] = []
        entites.reserveCapacity(32)
        return entites
    }()
    
    var entitesCount: Int {
        return vaultEntites.count
    }
    
    var searchIsFinished: Bool {
        guard let view = self.view else { return false }
        return view.loadingViewIsActive()
    }
    
    func getVaults() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let searchText = self.searchText.lowercased()
            self.realmRepository.getEntites(as: VaultPasswsordEntity.self, searchBlock: {
                $0.websiteAddress.lowercased().contains(searchText) ||
                $0.emailAddress.lowercased().contains(searchText) || $0.securePassword.lowercased().contains(searchText) }) { fetchResult in
                DispatchQueue.main.async {
                    switch(fetchResult) {
                        case .success(let entites):
                            self.vaultEntites.removeAll(keepingCapacity: true)
                            self.vaultEntites.append(contentsOf: entites)
                            self.view?.setupNavigationBarTitle(viewTitle: "Results")
                            self.view?.onSuccess()
                        case .failure(let error):
                            self.view?.showAlertView(alertMessage: error.localizedDescription)
                    }
                    self.view?.hideLoading()
                }
            }
        }
    }
        
    func configureCell(vaultCell: VaultCellDelegates, at indexPath: IndexPath) {
        let entity = vaultEntites[indexPath.row]
        vaultCell.uniqueIdentifier = entity.uuid
        vaultCell.setTitle(entity.title ?? entity.websiteAddress)
        vaultCell.setSubTitle(entity.emailAddress)
    }
    
    func pushDetails(at index: IndexPath) {
        let entity = vaultEntites[index.row]
        self.router.pushDetailsView(for: entity)
    }

}
