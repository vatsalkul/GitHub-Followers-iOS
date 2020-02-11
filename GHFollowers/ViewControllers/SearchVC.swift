//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Vatsal Kulshreshtha on 10/02/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let getFollowerButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextView()
        configureButton()
        createDismissKeyboardGesture()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    
    func createDismissKeyboardGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func pushfollowersListVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to search 😅", buttonTitle: "OK")
            return }
        let followerListVC = FollowerListVC()
        followerListVC.userName = usernameTextField.text
        followerListVC.title = usernameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
        
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)

        
        ])
    }
    
    func configureTextView(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureButton(){
        view.addSubview(getFollowerButton)
        
        
        getFollowerButton.addTarget(self, action: #selector(pushfollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getFollowerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushfollowersListVC()
        return true
    }
}
