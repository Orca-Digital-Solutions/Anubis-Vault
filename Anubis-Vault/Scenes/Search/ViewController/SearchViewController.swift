//
//  SearchViewController.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import UIKit

final class SearchViewController: AnubisBaseViewController {
    
    var presenter: SearchViewPresenter!

    lazy var searchTableView: AnubisBaseTableView = {
        let baseTableView = AnubisBaseTableView()
        baseTableView.setDataSource(self)
        baseTableView.setDelegates(self)
        baseTableView.registerTableViewCell(AnubisVaultTableViewCell.self)
        return baseTableView
    }()
    
    func setupTableView() {
        self.view.addSubview(searchTableView)
        let searchTableViewConstraints = [
            searchTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15),
            searchTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            searchTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(searchTableViewConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarTitle(viewTitle: "Searching...")
        setupTableView()
        self.showLoading()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getVaults()
        
    }
}

