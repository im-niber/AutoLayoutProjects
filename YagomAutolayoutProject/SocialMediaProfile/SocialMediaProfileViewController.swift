//
//  SocialMediaProfileViewController.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 2024/01/06.
//

import UIKit

class SocialMediaProfileViewController: UIViewController {
    
    private var backgroundHeightConstraint: NSLayoutConstraint!
    
    private let defaultHeight: CGFloat = 350
    private let maxHeight: CGFloat = 440
    
    private var beforeHeight: CGFloat = 0
    
    private var dynamicHeight: CGFloat = 0 {
        didSet {
            backgroundHeightConstraint.constant += dynamicHeight - oldValue
        }
    }
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "2")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(changeHeight(_:))))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var profileLabel: UILabel = {
        let view = UILabel()
        view.text = "프로필"
        view.font = .preferredFont(forTextStyle: .callout)
        view.adjustsFontForContentSizeCategory = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private func getButton(systemImageName: String) -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(systemName: systemImageName), for: .normal)
        
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundView)
        view.addSubview(bottomBackgroundView)
        view.addSubview(profileImageView)
        view.addSubview(profileLabel)
        view.addSubview(buttonStackView)
        
        ["ellipsis.message", "message.circle.fill", "message.badge.waveform.fill"].forEach { buttonStackView.addArrangedSubview(getButton(systemImageName: $0)) }
        
        backgroundHeightConstraint = backgroundView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundHeightConstraint,
            
            bottomBackgroundView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            bottomBackgroundView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            bottomBackgroundView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            bottomBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            profileImageView.centerYAnchor.constraint(equalTo: bottomBackgroundView.topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: bottomBackgroundView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1),
            
            profileLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            profileLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            buttonStackView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    @objc private func changeHeight(_ gesture: UIPanGestureRecognizer) {
        let height = gesture.translation(in: gesture.view).y
        let newHeight = height - beforeHeight
        
        switch gesture.state {
        case .began: ()
        case .changed:
            /// 프로퍼티 래퍼를 사용하는 방법
            dynamicHeight = height
            
            /// 바로 더해주는 방법
//            backgroundHeightConstraint.constant += newHeight
        case .ended:
            backgroundHeightConstraint.constant = defaultHeight
        default: break
        }
        
        // 특정 범위를 넘어가지 않게 조절해줌니다
        if backgroundHeightConstraint.constant > maxHeight {
            backgroundHeightConstraint.constant = maxHeight
        }
        
        if backgroundHeightConstraint.constant < defaultHeight {
            backgroundHeightConstraint.constant = defaultHeight
        }
        
        beforeHeight = height
        
        UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
    }
}
