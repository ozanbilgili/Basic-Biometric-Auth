//
//  ViewController.swift
//  Basic Bio Auth
//
//  Created by Ozan Bilgili on 10.09.2021.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 0, y:0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Auth", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton() {
     
        let context = LAContext()
        var error : NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            
            let reason = "Please auth with TocuhID"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason)
            { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        
                        // Fail auth
                        let alert = UIAlertController(title: "Failed to Auth",
                                                      message: "Please try again.",
                                                      preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .cancel,
                                                      handler: nil))
                        
                        self?.present(alert, animated: true)
                        return
                    }
                }
                
                //Success auth
                
                let vc = UIViewController()
                vc.title = "Hi!"
                vc.view.backgroundColor = .systemGray
                self?.present (UINavigationController(rootViewController: vc),
                               animated: true,
                               completion: nil)
            }
        }
        
        else {
            let alert = UIAlertController(title: "Unavailable",
                                          message: "You can't use this feature",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel,
                                          handler: nil))
            
            present(alert, animated: true)
        }
    }
}


