//
//  UITableView+Extensions.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 16/10/2022.
//

import UIKit

extension UITableView {
    
    /// Register TableView Cell
    func registerTableViewCell(_ tableViewCell: UITableViewCell.Type) {
        let reuseIdentifier = String(describing: tableViewCell)
        self.register(tableViewCell, forCellReuseIdentifier: reuseIdentifier)
    }
    
    /// Dequeue TableView Cell with type, no need for identifier
    func dequeueCell<RequiredTableViewCell: UITableViewCell>() -> RequiredTableViewCell {
        let cellIdentifer = String(describing: RequiredTableViewCell.self)
        guard let tableViewCell = self.dequeueReusableCell(withIdentifier: cellIdentifer) as? RequiredTableViewCell else {
            fatalError("Cannot dequeue cell with identifer \(cellIdentifer)")
        }
        return tableViewCell
    }
    
}

