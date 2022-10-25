//
//  KeyboardManager.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 19/10/2022.
//

import UIKit
import Combine

final class KeyboardManager {
    
    private weak var view: UIView?
    
    var bottmConstraint: NSLayoutConstraint!
    
    var bottomConstraintValue: CGFloat!
    
    var subrscriper: AnyCancellable?
    
    init(view: UIView, publisher: Published<NSLayoutConstraint?>.Publisher) {
        self.view = view
        self.setupNotification()
        subrscriper = publisher.sink { [weak self] bottomConstraint in
            guard let self = self else { return }
            self.bottmConstraint = bottomConstraint
            self.bottomConstraintValue = bottomConstraint?.constant
        }
    }
    
    init(view: UIView, bottomConstraint: NSLayoutConstraint!) {
        self.view = view
        self.setupNotification()
        self.bottmConstraint = bottomConstraint
        self.bottomConstraintValue = bottomConstraint.constant
 }
    
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self,
          selector: #selector(self.keyboardNotification(notification:)),
          name: UIResponder.keyboardWillChangeFrameNotification,
          object: nil)
    }
    
    deinit {
        subrscriper?.cancel()
        subrscriper = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardNotification(notification: NSNotification) {
      guard let userInfo = notification.userInfo else { return }
      let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      let endFrameY = endFrame?.origin.y ?? 0
      let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
      let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
      let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
      let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
      if endFrameY >= UIScreen.main.bounds.size.height {
          self.bottmConstraint.constant = bottomConstraintValue
      } else {
          self.bottmConstraint.constant = -endFrame!.size.height - 20
      }
      UIView.animate(
        withDuration: duration,
        delay: 0,
        options: animationCurve,
        animations: { [weak self] in
            guard let self = self else { return }
            guard let view = self.view else { return }
            view.layoutIfNeeded() })
    }

}
