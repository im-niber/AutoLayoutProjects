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
            
            // width로 히든 처리하는 방식
            // 누를 때 기준으로 0이 아니라면 이미 메뉴들이 보이는데
            // 누른거라서 히든처리를 해주면 된드아
            print(self.vStackView.bounds.width)
            if self.vStackView.bounds.width != 0 { self.vStackView.isHidden = true }
            else { self.vStackView.isHidden = false }
            
            // 서브 뷰가 전부 히든인지 보고 처리하는 방식
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
