//
//  VaultViewController.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 16/10/2022.
//

import UIKit

enum AnubisVaultMenuButtonsIndex: Int {
    case newest
    case oldest
}

final class VaultViewController: AnubisBaseViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    var preseneter: VaultVCPreseneter!
    
    var keyboardManager: KeyboardManager!
    
    @Published private(set) var bottomConstraint: NSLayoutConstraint!

    // MARK: - Sub Views
    
    private lazy var searchView: AnubisBaseUIView = {
        let baseView = AnubisBaseUIView()
        return baseView
    }()
    
    private lazy var searchTextField: AnubisBaseUITextField = {
        let searchTextField = AnubisBaseUITextField(placeHolder: "Search")
        searchTextField.setupLetfImage(baseName: "magnifyingglass")
        searchTextField.delegate = self
        return searchTextField
    }()
    
    private lazy var vaultFilterButton: AnubisBaseUIButton = {
        let filterButton = AnubisBaseUIButton(baseImageName: "list.dash", imageColor: .label, backgroundColor: .subViewsBackgroundColor)
        filterButton.setupMenuButtons(
            "Sort By",
            AnubisUIButtonMenuItem(AnubisVaultMenuButtonsIndex.newest.rawValue, buttonTitle: "Newest"),
            AnubisUIButtonMenuItem(AnubisVaultMenuButtonsIndex.oldest.rawValue, buttonTitle: "Oldest")
            ) { [weak self] buttonIndex in
                guard let self = self else { return }
                guard let buttonValueFromIndex = AnubisVaultMenuButtonsIndex(rawValue: buttonIndex) else { return }
                self.preseneter.setSortVaule(buttonValueFromIndex)
            }
        return filterButton
    }()
    
    private(set) lazy var vaultTableView: AnubisBaseTableView = {
        let tableView = AnubisBaseTableView()
        tableView.setDelegates(self)
        tableView.setDataSource(self)
        tableView.registerTableViewCell(AnubisVaultTableViewCell.self)
        return tableView
    }()
    
    private lazy var vaultAddButton: AnubisBaseUIButton = {
        let addButton = AnubisBaseUIButton(baseImageName: "plus", imageColor: .white)
        addButton.addTarget(self, action: #selector(addButtonClicked(_:)), for: .touchUpInside)
        return addButton
    }()
    
    @objc private func addButtonClicked(_ sender: AnubisBaseUIButton!) {
        preseneter.addButtonClicked()
    }
    
    private func setupSearchView() {
        
        self.view.addSubview(searchView)
        let searchViewConstraints = [
            searchView.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 10),
            searchView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            searchView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(searchViewConstraints)
        
    }
    
    private func setupFilterButton() {
        
        self.searchView.addSubview(vaultFilterButton)
        let filterButtonConstraints = [
            vaultFilterButton.widthAnchor.constraint(equalTo: searchView.widthAnchor, multiplier: 0.025, constant: 45),
            vaultFilterButton.topAnchor.constraint(equalTo: searchView.topAnchor),
            vaultFilterButton.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            vaultFilterButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor),
        ]
        NSLayoutConstraint.activate(filterButtonConstraints)
        
    }
    
    private func setupSearchTextField() {
        
        self.searchView.addSubview(searchTextField)
        let searchTextFieldConstraints = [
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: vaultFilterButton.leadingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(searchTextFieldConstraints)
        
    }

    private func setupTableView() {

        self.view.addSubview(vaultTableView)
        let tableViewConstraints = [
            vaultTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 5),
            vaultTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            vaultTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            vaultTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)

        self.bottomConstraint = tableViewConstraints.last
  }

    private func setupAddButton() {
        
        self.view.addSubview(vaultAddButton)
        let addButtonConstraints = [
            vaultAddButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            vaultAddButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
        ]
        NSLayoutConstraint.activate(addButtonConstraints)

    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLabel(viewLabelText: "Vault")
        setupSearchView()
        setupFilterButton()
        setupSearchTextField()
        setupTableView()
        setupAddButton()
    }

    private var viewDidAppeared = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewDidAppeared == false {
            preseneter.getVaults()
            viewDidAppeared = true
        }
    }
    // MARK: - UI Events

    func textFieldDidBeginEditing(_ textField: UITextField) {
        visibilityOfAddButton(false, disableSearchText: false)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        visibilityOfAddButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        preseneter.searchTextFieldSumbit(textField.text)
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        visibilityOfAddButton(false)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        visibilityOfAddButton()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(!decelerate) {
            visibilityOfAddButton()
        }
    }
    
    private func visibilityOfAddButton(_ showButton: Bool = true, disableSearchText: Bool = true) {
        if(self.searchTextField.isFirstResponder && disableSearchText) {
            super.touchesBegan(Set<UITouch>(), with: nil)
        } else if(self.vaultTableView.isEditing || self.vaultTableView.indexPathsForVisibleRows?.count == 0) {
            return
        }
        if(showButton == true) {
            self.vaultAddButton.showView()
        } else {
            self.vaultAddButton.hideView()
        }
    }

}

