//
//  PasswordBuilder.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 23/10/2022.
//

import Foundation

final class PasswordBuilder {
    var title: String?
    var websiteAddress: String! = ""
    var emailAddress: String! = ""
    var securePassword: String! = ""

    func buildEntity() throws -> VaultPasswsordEntity {
        guard websiteAddress.count > 0 else { throw Passowrd_BulderError.websiteAddressError}
        guard emailAddress.count > 0 else { throw Passowrd_BulderError.emailAddressError}
        guard securePassword.count > 0 else { throw Passowrd_BulderError.securePasswordError}
        return VaultPasswsordEntity(
            uuid: UUID().uuidString, title: title, websiteAddress: websiteAddress,
            emailAddress: emailAddress, securePassword: securePassword, createdAt: Date())
    }
    
    enum Passowrd_BulderError: String, LocalizedError {
        case websiteAddressError = "The website address cannot be empty"
        case emailAddressError = "The email address cannot be empty"
        case securePasswordError = "The password cannot be empty"
        var errorDescription: String? {
            return self.rawValue
        }
    }
}
