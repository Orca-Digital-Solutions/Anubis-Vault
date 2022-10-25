//
//  AnubisLoadingView.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 23/10/2022.
//

import UIKit

final class AnubisLoadingView: AnubisBaseUIView {
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let baseIndicator = UIActivityIndicatorView()
        baseIndicator.style = .large
        baseIndicator.color = .white
        baseIndicator.translatesAutoresizingMaskIntoConstraints = false
        return baseIndicator
    }()
    
    private lazy var loadingLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.attributedText = NSAttributedString(string: "Loading...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        baseLabel.translatesAutoresizingMaskIntoConstraints = false
        return baseLabel
    }()
    
    override init() {
        super.init()
        setupView()
    }
    
    private func setupView()  {
        
        self.backgroundColor = .black.withAlphaComponent(0.5)
        
        self.addSubview(loadingIndicator)
        let loadingIndicatorConstraints = [
            loadingIndicator.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 5),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ]
        NSLayoutConstraint.activate(loadingIndicatorConstraints)
        loadingIndicator.startAnimating()
        
        
        self.addSubview(loadingLabel)
        let loadingLabelConstraints = [
            loadingLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 10),
            loadingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            loadingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            loadingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
        ]
        NSLayoutConstraint.activate(loadingLabelConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 12
    }
    
}

