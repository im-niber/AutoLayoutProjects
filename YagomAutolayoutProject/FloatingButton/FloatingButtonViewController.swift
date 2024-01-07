//
//  ViewController.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 2024/01/06.
//

import UIKit

class FloatingButtonViewController: UIViewController {
    
    private lazy var menuButton: UIButton = {
        let view = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "shippingbox", withConfiguration: imageConfig)
        view.setImage(image, for: .normal)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addTarget(self, action: #selector(showingStackView), for: .touchUpInside)
        
        return view
    }()

    private lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .center
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private func getButton(imageName: String) -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(systemName: imageName), for: .normal)
        view.tintColor = .purple
        view.isHidden = true
        
        return view
    }
    
    @objc func showingStackView() {
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5) {
            
            self.vStackView.arrangedSubviews.forEach { view in
                view.isHidden = !view.isHidden
            }
            
            if !self.vStackView.arrangedSubviews.contains(where: { view in
                view.isHidden == false
            }) {
                self.vStackView.isHidden = true
            }
            
            else { self.vStackView.isHidden = false }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(menuButton)
        view.addSubview(vStackView)
        
        vStackView.addArrangedSubview(getButton(imageName: "pencil"))
        vStackView.addArrangedSubview(getButton(imageName: "person"))
        vStackView.addArrangedSubview(getButton(imageName: "photo"))
        vStackView.addArrangedSubview(getButton(imageName: "archivebox"))
    
        let testImageView: UIImageView = {
            let view = UIImageView(image: UIImage(systemName: "photo"))
            view.tintColor = .purple
            view.isHidden = true
            return view
        }()
        
        vStackView.addArrangedSubview(testImageView)
        
        NSLayoutConstraint.activate([
            menuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            menuButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            vStackView.centerXAnchor.constraint(equalTo: menuButton.centerXAnchor),
            vStackView.bottomAnchor.constraint(equalTo: menuButton.topAnchor, constant: -8),
        ])
    }
}
