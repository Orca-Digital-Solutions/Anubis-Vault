//
//  AnubisBaseUIView.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 18/10/2022.
//

import UIKit

class AnubisBaseUIView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .viewBackgroundColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
}
