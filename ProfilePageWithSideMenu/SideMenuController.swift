//
//  SideMenuController.swift
//  ProfilePageWithSideMenu
//
//  Created by Volodymyr D on 20.02.2023.
//

import UIKit
 

class SideMenuController: UIViewController {
   
   private lazy var buttonForAvatar: UIButton = {
       let button = UIButton()
       button.addTarget(self, action: #selector(avatarButtonTapped), for: .touchUpInside)
       button.layer.masksToBounds = true
       button.layer.cornerRadius = 33
       let conf = UIImage.SymbolConfiguration(pointSize: 68)
       let image = UIImage(systemName: "face.smiling.fill", withConfiguration: conf )
       button.setImage(image, for: .normal)
       return button
   }()
    
//MARK: - Life Cycle
   override func loadView() {
       super.loadView()
       view.backgroundColor = .magenta
       view.addSubview(buttonForAvatar)
   }
   
   override func viewDidLoad() {
       super.viewDidLoad()
       setupConstraints()
   }
    
//MARK: - Metods
   private func setupConstraints() {
       buttonForAvatar.snp.makeConstraints {
           $0.leading.equalTo(view.safeAreaLayoutGuide).offset(58)
           $0.top.equalTo(view.safeAreaLayoutGuide).offset(47)
           $0.size.equalTo(68)
       }
   }
   
//MARK: - Actions
   @objc private func avatarButtonTapped() {
       let viewController = ViewController()
       viewController.setViewController(withImage: buttonForAvatar.imageView?.image)
       self.navigationController?.pushViewController(viewController, animated: true)
   }
   
}
