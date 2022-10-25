//
//  AnubisVaultTableViewCell.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 16/10/2022.
//

import UIKit

protocol VaultCellDelegates: AnyObject {
    var uniqueIdentifier: String! { get set }
    func setTitle(_ title: String)
    func setSubTitle(_ subTitle: String)
    func setRemoteImage(_ baseURL: String!)
}

final class AnubisVaultTableViewCell: AnubisBaseTableViewCell, VaultCellDelegates {

    // MARK: - Properties
    
    var uniqueIdentifier: String!
    var httpTask: URLSessionTask?
    
    private lazy var vaultBaseImage: UIImage? = {
        let baseImage = UIImage.createFromBaseName("globe")
        return baseImage
    }()
    
    private lazy var vaultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.backgroundColor = .subViewsBackgroundColor
        imageView.image = vaultBaseImage
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var vaultTitle: UILabel = {
        let vaultTitle = UILabel()
        vaultTitle.translatesAutoresizingMaskIntoConstraints = false
        vaultTitle.font = .preferredFont(forTextStyle: .headline)
        vaultTitle.textColor = .label
        return vaultTitle
    }()
    
    private lazy var vaultSubTitle: UILabel = {
        let vaultSubTitle = UILabel()
        vaultSubTitle.translatesAutoresizingMaskIntoConstraints = false
        vaultSubTitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        vaultSubTitle.textColor = .secondaryLabel
        return vaultSubTitle
    }()
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupVaultCell()
    }
    
    private func setupVaultImageView() {

        self.contentView.addSubview(vaultImageView)
        let imageViewConstraints = [
            vaultImageView.widthAnchor.constraint(equalTo: vaultImageView.heightAnchor),
            vaultImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8),
            vaultImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            vaultImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
    }
    
    private func setupVaultTitleLabel() {

        self.contentView.addSubview(vaultTitle)
        let titleLabelConstraints = [
            vaultTitle.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 15),
            vaultTitle.centerYAnchor.constraint(equalTo: vaultImageView.centerYAnchor, constant: -10),
            vaultTitle.leadingAnchor.constraint(equalTo: vaultImageView.trailingAnchor, constant: 10),
            vaultTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ]
        vaultTitle.setContentCompressionResistancePriority(.required, for: .vertical)
        NSLayoutConstraint.activate(titleLabelConstraints)

    }

    private func setupVaultSubTitleLable() {

        self.contentView.addSubview(vaultSubTitle)
        let subTitleLabelConstraints = [
            vaultSubTitle.topAnchor.constraint(equalTo: self.vaultTitle.bottomAnchor),
            vaultSubTitle.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -15),
            vaultSubTitle.leadingAnchor.constraint(equalTo: self.vaultImageView.trailingAnchor, constant: 10),
            vaultSubTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
        ]
        vaultSubTitle.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        NSLayoutConstraint.activate(subTitleLabelConstraints)
   
    }

    private func setupVaultCell() {
        self.backgroundColor = .viewBackgroundColor
        setupVaultImageView()
        setupVaultTitleLabel()
        setupVaultSubTitleLable()
    }
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.uniqueIdentifier = String()
        vaultImageView.image = vaultBaseImage
        vaultTitle.text = "Title: "
        vaultSubTitle.text = "SubTitle: "
        httpTask?.cancel()
    }
    
    //MARK: - Functions
    
    func setTitle(_ title: String) {
        self.vaultTitle.text = "\(title)"
    }
    
    func setSubTitle(_ subTitle: String) {
        self.vaultSubTitle.text = "\(subTitle)"
    }
    
    func setRemoteImage(_ baseURL: String!)
    {
        guard let baseURL = baseURL.extractDomainFromString(),
              let url = URL(string: String(format: "https://%@/favicon.ico", baseURL)) else {
            
            return }
        httpTask = URLSession.shared.dataTask(with: url) { [weak self] data, respone, error in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            guard let respone = respone as? HTTPURLResponse, respone.statusCode == 200 else {
                return
            }
            guard let data = data, let imageData = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                UIView.transition(with: self.vaultImageView, duration: 0.25, options: [.transitionCrossDissolve]) {
                    self.vaultImageView.image = imageData
                }
            }
        }
        httpTask?.resume()
    }

}
