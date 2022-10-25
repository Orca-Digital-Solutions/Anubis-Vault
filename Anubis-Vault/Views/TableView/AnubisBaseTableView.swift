//
//  AnubisBaseTableView.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 16/10/2022.
//

import UIKit

final class AnubisBaseEmptyBackgroundView: AnubisBaseUIView  {
    
    private lazy var messageLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.font = .preferredFont(forTextStyle: .headline)
        baseLabel.textAlignment = .center
        baseLabel.textColor = .secondaryLabel
        baseLabel.numberOfLines = 0
        baseLabel.translatesAutoresizingMaskIntoConstraints = false
        return baseLabel
    }()
    
    override init() {
        super.init()
        setupView()
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.isHidden = true
        self.addSubview(messageLabel)
        let messageLabelConstraitns = [
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -25),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ]
        NSLayoutConstraint.activate(messageLabelConstraitns)
    }
    
    func setLabelMessage(_ labelMessage: String!) {
        self.messageLabel.text = labelMessage
    }
    
}

final class AnubisBaseTableView: UITableView {
    
    private lazy var emptyBackground: AnubisBaseEmptyBackgroundView = {
        let baseView = AnubisBaseEmptyBackgroundView()
        return baseView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .viewBackgroundColor
        self.separatorStyle = .none
        self.backgroundView = emptyBackground
    }
    
    //MARK: - Functions
    
    func setDelegates(_ tableViewDelegates: UITableViewDelegate) {
        self.delegate = tableViewDelegates
    }
    
    func setDataSource(_ tableViewDataSource: UITableViewDataSource) {
        self.dataSource = tableViewDataSource
    }
    
    func showEmptyBackground(message: String!) {
        if(self.backgroundView?.isHidden == true) {
            self.backgroundView?.isHidden = false
            emptyBackground.setLabelMessage(message)
        }
    }
    
    func hideEmptyBackground() {
        if(self.backgroundView?.isHidden == false) {
            self.backgroundView?.isHidden = true
        }
    }
}
