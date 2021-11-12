//
//  ViewController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 12/04/2021.
//

import UIKit
import Hero
class LoginViewController: UIViewController {
    
    private lazy var containerView: UIView = UIView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.containerColor
        $0.layer.cornerRadius = 12
    }
    
    private lazy var emailField: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setIcon(icon: Icon.App.user.typographyIcon(font: Font.Icon._16))
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = "Email".typography(.caption, color: Color.lightGray)
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
    }
    
    private lazy var passwordField: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.setIcon(icon: Icon.App.bell.typographyIcon(font: Font.Icon._16))
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = "Password".typography(.caption, color: Color.lightGray)
        $0.leftViewMode = .always
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
    }
    
    private lazy var nameField: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setIcon(icon: Icon.App.user.typographyIcon(font: Font.Icon._16))
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = "Name".typography(.caption, color: Color.lightGray)
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
        $0.isHidden = true
    }
    
    private lazy var selectionIndicator: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.white
    }
    
    private lazy var loginChooseButton: UIButton = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.containerColor
        $0.setAttributedTitle("LOG IN".typography(.text, color: Color.white), for: .normal)
        $0.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    private lazy var registerChooseButton: UIButton = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.containerColor
        $0.setAttributedTitle("SIGN UP".typography(.text, color: Color.white.withAlphaComponent(0.5)), for: .normal)
        $0.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    private lazy var loginButton: UIButton = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Log In", for: .normal)
        $0.setTitleColor(Color.white, for: .normal)
        $0.backgroundColor = Color.buttonColor
        $0.layer.cornerRadius = 20
    }
    
    private lazy var forgotPasswordLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "Forgot Password?".typography(.caption)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHeroEnabled = true
        containerView.hero.id = "containerView"
        loginButton.hero.id = "button"
        selectionIndicator.hero.id = "selection"
        configureStyleAndLayout()
    }
    
    private func configureStyleAndLayout() {
        self.view.backgroundColor = Color.backgroundColor
        self.view.addSubview(containerView)
        
        containerView.addSubview(emailField)
        containerView.addSubview(passwordField)
        containerView.addSubview(loginButton)
        containerView.addSubview(forgotPasswordLabel)
        containerView.addSubview(loginChooseButton)
        containerView.addSubview(registerChooseButton)
        containerView.addSubview(nameField)
        loginChooseButton.addSubview(selectionIndicator)

        

        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 260),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loginChooseButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin._10),
            loginChooseButton.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -Margin._20),
            loginChooseButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            
            selectionIndicator.leadingAnchor.constraint(equalTo: loginChooseButton.leadingAnchor),
            selectionIndicator.trailingAnchor.constraint(equalTo: loginChooseButton.trailingAnchor),
            selectionIndicator.bottomAnchor.constraint(equalTo: loginChooseButton.bottomAnchor),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 2),

            registerChooseButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin._10),
            registerChooseButton.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -Margin._20),
            registerChooseButton.leadingAnchor.constraint(equalTo: loginChooseButton.trailingAnchor, constant: Margin._10),
            
            emailField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            emailField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            
            nameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            nameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            nameField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: Margin._20),
            
            passwordField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            passwordField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: Margin._20),
            
            loginButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Margin._20),
            loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            forgotPasswordLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: Margin._24),

        ])
    }
    
    @objc private func didTapRegister() {
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .fullScreen
        registerVC.heroModalAnimationType = HeroDefaultAnimationType.fade
        present(registerVC, animated: true, completion: nil)
    }
    
    @objc private func didTapLogin() {

    }
}

extension UITextField {
    func setIcon(icon:NSAttributedString) {
        let iconLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 3, width: 16, height: 16))
        let iconContainerView = UIView(frame:CGRect(x: 20, y: 0, width: 40, height: 20))
        
        iconLabel.attributedText = icon
        iconLabel.textColor = Color.buttonColor
        iconContainerView.addSubview(iconLabel)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}
