//
//  ViewController.swift
//  ProfilePageWithSideMenu
//
//  Created by Volodymyr D on 18.09.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let heightForFonImage = 139
    let sizeForAvatarView = 66
    var constantForTopConstrainAvatarImage: Int {
         (heightForFonImage - (sizeForAvatarView / 2)) - Int(navigationController?.navigationBar.bounds.size.height ?? 44)
    }
 
    private lazy var avatarImageView: UIImageView = {
        let imView = UIImageView()
        imView.backgroundColor = .magenta
//        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.layer.masksToBounds = true
        imView.layer.cornerRadius = 33
        return imView
    }()
    
    private lazy var fonImageView: UIImageView = {
        let imView = UIImageView()
//        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.image = UIImage(named: "marsMan")
        return imView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mockView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     
    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView(frame: self.view.frame)
        scroll.backgroundColor = .clear
        scroll.delegate = self
        return scroll
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
//MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        view = scroll
        view.addSubview(contentView)
        contentView.addSubview(fonImageView)
        contentView.addSubview(mockView)
        contentView.addSubview(avatarImageView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupConstraints()
         
    }
    
//MARK: - Metods
    public func setViewController(withImage  image: UIImage?) {
        avatarImageView.image = image
    }
 
    //MARK: setup constraints
    private func updateAvatarConstraints(withHeight height: Int) {
        avatarImageView.snp.updateConstraints {
            $0.top.equalTo(contentView).offset(height)
        }
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scroll.contentLayoutGuide)
            $0.width.equalTo(self.view.bounds.width)
        }
        fonImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(heightForFonImage)
            $0.top.equalTo(contentView).inset(-44)
        }
        mockView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(contentView)
            $0.top.equalTo(fonImageView.snp.bottom)
            $0.height.equalTo(self.view.bounds.height + 162)
        }
        avatarImageView.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(33)
            $0.top.equalTo(contentView).offset(constantForTopConstrainAvatarImage)
            $0.size.equalTo(sizeForAvatarView)
        }
        
    }
    
}

//MARK: -  ScrollView Delegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let hh = Int((CGFloat(scrollView.contentOffset.y) / 2.78) + 33)
        if hh > 0 && hh < 33 {
            let updatedHeightForConstrain = hh + constantForTopConstrainAvatarImage
            updateAvatarConstraints(withHeight: updatedHeightForConstrain)
            avatarImageView.snp.updateConstraints {
                $0.size.equalTo(sizeForAvatarView - (hh / 3))
            }
        }
    }
    
}
 
//MARK: -  NavigationController Delegate
extension ViewController: UINavigationControllerDelegate {
   
    //MARK: setup NavigationController
    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        
        navigationController?.delegate = self
         
        let customGlassButton = UIButton()
        let customDotsButton = UIButton()
        let imageNames = ["ellipsis", "magnifyingglass"]
        [customDotsButton, customGlassButton].enumerated().forEach { (ind, button) in
            button.setImage(UIImage(systemName: imageNames[ind]), for: .normal)
            button.bounds.size = CGSize(width: 28, height: 28)
            button.layer.cornerRadius = button.bounds.width / 2
            button.layer.masksToBounds = true
            button.backgroundColor = .gray.withAlphaComponent(0.5)
            button.tintColor = .white
        }
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: customDotsButton),
            UIBarButtonItem(customView: customGlassButton),
        ]
    }
    
}
