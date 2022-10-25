//
//  AnubisBaseViewController.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 16/10/2022.
//

import UIKit

protocol BaseViewControllerDelegates: AnyObject {
    func showLoading()
    func hideLoading()
    func loadingViewIsActive() -> Bool
    func setupNavigationBarTitle(viewTitle: String!)
    func showAlertView(alertMessage: String!)
    func showConfirmationView(alertMessage: String!, handler: @escaping (Bool) -> Void)
    func showToast(toastMessage: String!)
}

class AnubisBaseViewController: UIViewController, BaseViewControllerDelegates {

    // MARK: - Properties
    
    private(set) lazy var safeArea = {
        return self.view.safeAreaLayoutGuide
    }()
    
    private lazy var loadingInteractor: AnubisLoadingView = {
        let baseLoadingView = AnubisLoadingView()
        return baseLoadingView
    }()
    
    private(set) lazy var viewLabel: UILabel = {
        let viewLabel = UILabel()
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        viewLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).Bold()
        return viewLabel
    }()

    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.view.backgroundColor = .viewBackgroundColor
  }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationStack = navigationController?.viewControllers, navigationStack.count > 1 else {
            self.navigationController?.isNavigationBarHidden = true
            return
        }
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navigationStack = navigationController?.viewControllers, navigationStack.count > 1 else {
            self.navigationController?.isNavigationBarHidden = false
            return
        }
        self.navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Functions
    
    func setupViewLabel(viewLabelText: String!, includeTrailingAnchor: Bool = true) {
        
        self.view.addSubview(viewLabel)
        var viewLabelConstraints = [
            self.viewLabel.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 20),
            self.viewLabel.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 15),
        ]
        includeTrailingAnchor ?
            viewLabelConstraints.append(self.viewLabel.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -15)) : nil
        NSLayoutConstraint.activate(viewLabelConstraints)
        
        viewLabel.text = viewLabelText
    }
    
    func setupNavigationBarTitle(viewTitle: String!) {
        self.navigationItem.title = viewTitle
        self.hidesBottomBarWhenPushed = true
    }

    func showLoading() {
        self.view.isUserInteractionEnabled.toggle()
        self.view.addSubview(loadingInteractor)
        let loadingInteractor = [
            loadingInteractor.centerYAnchor.constraint(equalTo: self.safeArea.centerYAnchor, constant: -15),
            loadingInteractor.centerXAnchor.constraint(equalTo: self.safeArea.centerXAnchor),
        ]
        NSLayoutConstraint.activate(loadingInteractor)
    }
    
    func hideLoading() {
        self.loadingInteractor.removeFromSuperview()
        self.view.isUserInteractionEnabled.toggle()
    }
    
    func loadingViewIsActive() -> Bool {
        return self.view.isUserInteractionEnabled == false
    }
    
    func showAlertView(alertMessage: String!) {
        let alertController = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
    
    func showConfirmationView(alertMessage: String!, handler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: nil, message: alertMessage, preferredStyle: .actionSheet)
        let continueBtn = UIAlertAction(title: "CONTINUE", style: .destructive) { _ in
            handler(true)
        }
        alertController.addAction(continueBtn)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            handler(false)
        })
        alertController.addAction(cancelBtn)
        self.present(alertController, animated: true)
    }
    
    func showToast(toastMessage: String!) {
        let toastView = UIView()
        toastView.alpha = 0
        toastView.backgroundColor = .black.withAlphaComponent(0.75)
        toastView.layer.cornerRadius = 12
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        let toastMessageLabel = UILabel()
        toastMessageLabel.text = toastMessage
        toastMessageLabel.textColor = .white
        toastMessageLabel.numberOfLines = 0
        toastMessageLabel.textAlignment = .center
        toastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        toastView.addSubview(toastMessageLabel)
        let toastLabelConstraints = [
            toastMessageLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 15),
            toastMessageLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -15),
            toastMessageLabel.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 15),
            toastMessageLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(toastLabelConstraints)
        
        self.view.addSubview(toastView)
        
        let toastViewConstraints = [
            toastView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            toastView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            toastView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(toastViewConstraints)
        
        UIView.animate(withDuration: 1, delay: 0.0) {
            toastView.alpha = 1
        } completion: { isCompleted in
            if(isCompleted == true) {
                UIView.animate(withDuration: 1, delay: 2.5) {
                    toastView.alpha = 0
                } completion: { isCompleted in
                    if(isCompleted == true) {
                        toastView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
}
