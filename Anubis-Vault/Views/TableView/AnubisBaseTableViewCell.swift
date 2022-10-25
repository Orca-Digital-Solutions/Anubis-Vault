//
//  AnubisBaseTableViewCell.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 16/10/2022.
//

import UIKit

class AnubisBaseTableViewCell: UITableViewCell {
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBaseTableViewCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBaseTableViewCell() {
        self.selectionStyle = .none
    }
    
}

