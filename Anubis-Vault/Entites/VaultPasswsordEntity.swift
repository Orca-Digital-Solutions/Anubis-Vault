//
//  VaultPasswsordEntity.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 23/10/2022.
//

import Foundation
import RealmSwift

final class VaultPasswsordEntity: Object {
    
    @Persisted(primaryKey: true) var uuid: String!
    @Persisted var title: String?
    @Persisted var websiteAddress: String!
    @Persisted var emailAddress: String!
    @Persisted var securePassword: String!
    @Persisted var createdAt: Date!
    
    convenience init(uuid: String!, title: String? = nil, websiteAddress: String!, emailAddress: String!, securePassword: String!, createdAt: Date!) {
        self.init()
        self.uuid = uuid
        self.title = title
        self.websiteAddress = websiteAddress
        self.emailAddress = emailAddress
        self.securePassword = securePassword
        self.createdAt = createdAt
    }
    
}
