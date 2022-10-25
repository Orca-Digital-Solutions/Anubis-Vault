//
//  VaultVCPreseneter.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 21/10/2022.
//

import Foundation
import RealmSwift

protocol VaultPresenterDelegation: AnyObject {
    func vaultCreated(_ createdEntity: VaultPasswsordEntity)
}

final class VaultVCPreseneter: VaultPresenterDelegation {

    //MARK: - Proprietes
    
    private weak var view: VaultDelegates?
    private var router: VaultVCRouter!
    private var realmRepository: Repository!
    
    
    // MARK: - Initialization
    
    init(view: VaultDelegates!, router: VaultVCRouter!, realmRepository: Repository) {
        self.view = view
        self.router = router
        self.realmRepository = realmRepository
    }

    // MARK: - Functions / Proprietes
    
    private lazy var vaultEntites: [VaultPasswsordEntity] = {
        var entites: [VaultPasswsordEntity] = []
        entites.reserveCapacity(32)
        return entites
    }()
    
    
    var entitesCount: Int {
        return vaultEntites.count
    }
    
    private var sortButtonVaule = AnubisVaultMenuButtonsIndex.newest

    func setSortVaule(_ sortValue: AnubisVaultMenuButtonsIndex) {
        guard sortValue.rawValue != self.sortButtonVaule.rawValue else { return }
        self.sortButtonVaule = sortValue
        self.getVaults()
    }
    
    func getVaults() {
        self.view?.showLoading()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.realmRepository.getEntites(as: VaultPasswsordEntity.self, ascending: self.sortButtonVaule == .oldest) { fetchResult in
                DispatchQueue.main.async {
                    switch(fetchResult) {
                        case .success(let entites):
                            self.vaultEntites.removeAll(keepingCapacity: true)
                            self.vaultEntites.append(contentsOf: entites)
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
        vaultCell.setRemoteImage(entity.websiteAddress)
    }
    
    func deleteVault(vaultCell: VaultCellDelegates, at indexPath: IndexPath) {
        guard let entity = self.vaultEntites.first(where: {$0.uuid == vaultCell.uniqueIdentifier}) else { return }
        self.realmRepository.deleteEntity(entity) { deleteResult in
            guard deleteResult else { return }
            self.vaultEntites.removeAll(where: { $0 === entity})
            self.view?.deleteRow(at: [indexPath])
        }
    }
    
    func vaultCreated(_ createdEntity: VaultPasswsordEntity) {
        var indexNumber = (self.vaultEntites.count - 1)
        if(sortButtonVaule == .newest) {
            indexNumber = 0
            self.vaultEntites.insert(createdEntity, at: 0)
        } else {
            self.vaultEntites.append(createdEntity)
        }
        self.view?.insertRow(at: [IndexPath(row: indexNumber, section: 0)])
        self.view?.showToast(toastMessage: "Vault created successfully")
    }
    
    // MARK: - Clicks \ Push
    
    func addButtonClicked() {
        router.pushAddView(presenter: self)
    }
    
    func searchTextFieldSumbit(_ searchText: String?) {
        guard let searchText = searchText else { return }
        self.router.pushSearchView(searchText)
    }
    
    func pushDetails(at index: IndexPath) {
        let entity = vaultEntites[index.row]
        router.pushDetailsView(for: entity)
    }

}

