//
//  RootViewController.swift
//  ProfilePageWithSideMenu
//
//  Created by Volodymyr D on 18.09.2022.
//

import UIKit
import SnapKit
import SideMenu

class RootViewController: UIViewController {
    
    private var sideMenu: SideMenuNavigationController = {
        let sideMenu = SideMenuNavigationController(rootViewController: SideMenuController())
        sideMenu.leftSide = true
        return sideMenu
    }()
    private lazy var buttonForAvatarForNavi: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero,
                                            size: CGSize(width: 44, height: 44)))
        let conf = UIImage.SymbolConfiguration(pointSize: 44, weight: .bold )
//        "rectangle.portrait.leadinghalf.inset.filled"
        var image = UIImage(systemName: "text.justify", withConfiguration: conf)
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(avatarButtonTapped), for: .touchUpInside)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.03
        animation.duration = 0.15
        animation.autoreverses = true
        animation.repeatCount = .infinity
        button.layer.add(animation, forKey: nil)
        
        return button
    }()
    
//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        configureSideMenu()
        configureNavigationController()
    }

//MARK: - Metods
    private func configureNavigationController() {
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: buttonForAvatarForNavi),
        ]
    }
    
    private func configureSideMenu() {
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
//MARK: - Actions
    @objc private func avatarButtonTapped() {
         present(sideMenu, animated: true)
        buttonForAvatarForNavi.layer.removeAllAnimations()
    }
    
}

 

//MARK: - CLAAASSSS))) SideMenuController
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
