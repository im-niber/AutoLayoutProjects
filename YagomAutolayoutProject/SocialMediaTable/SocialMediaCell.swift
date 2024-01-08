//
//  SocialMediaCell.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 1/8/24.
//

import UIKit

struct SocialMedia {
    let profileImage: UIImage
    let name: String
    let time: Date
    let content: String
    let image: UIImage
    let isLiked: Bool
    let likeCount: Int
}

class SocialMediaCell: UITableViewCell {
    
    private var imageRatioConstraint: NSLayoutConstraint!
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = UIStackView.spacingUseSystem
        
        return view
    }()
    
    private lazy var topStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = UIStackView.spacingUseSystem
        
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.adjustsFontForContentSizeCategory = true
        view.font = .preferredFont(forTextStyle: .caption1)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.adjustsFontForContentSizeCategory = true
        view.font = .preferredFont(forTextStyle: .caption2)
        
        return view
    }()
    
    private lazy var descriptionTextView: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.adjustsFontForContentSizeCategory = true
        view.font = .preferredFont(forTextStyle: .body)
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return view
    }()
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fulledImage)))
        
        view.setContentHuggingPriority(.required, for: .vertical)
        return view
    }()
    
    private lazy var likeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        view.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        view.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .selected)

        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        return view
    }()
    
    private lazy var likeCountLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .callout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        
        return view
    }()
    
    private lazy var stackLikeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("좋아요", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.tintColor = .darkGray
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor

        return view
    }()
    
    private lazy var stackReplyButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("댓글 달기", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.tintColor = .darkGray
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    private lazy var stackShareButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("공유하기", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.tintColor = .darkGray
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor

        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        contentView.addSubview(mainStackView)
        
        [profileImageView, nameLabel, timeLabel].forEach { topStackView.addArrangedSubview($0) }
        [likeButton, likeCountLabel].forEach { likeStackView.addArrangedSubview($0) }
        [stackLikeButton, stackReplyButton, stackShareButton].forEach { bottomStackView.addArrangedSubview($0) }
        
        [topStackView, descriptionTextView, contentImageView, likeStackView, bottomStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
    }
    
    private func configureLayout() {
        let likeButtonHeight30 = likeButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        
        let likeButtonHeightLabel = likeButton.heightAnchor.constraint(lessThanOrEqualTo: likeCountLabel.heightAnchor, multiplier: 1.0)
        likeButtonHeightLabel.priority = .defaultHigh
        
        let contentImageWidthConstraint = contentImageView.widthAnchor.constraint(equalTo: contentImageView.heightAnchor)
        contentImageWidthConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            profileImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1.0),
            
            contentImageWidthConstraint,
            
            likeButtonHeight30,
            likeButtonHeightLabel,
            likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor, multiplier: 1.0),
        ])
    }
    
    func configure(media: SocialMedia) {
        profileImageView.image = media.profileImage
        nameLabel.text = media.name
        
        timeLabel.text = DateFormatter.localizedString(from: Date(timeIntervalSinceNow: media.time.timeIntervalSince1970), dateStyle: .short, timeStyle: .short)
        
        descriptionTextView.text = media.content
        contentImageView.image = media.image
        
        descriptionTextView.isHidden = descriptionTextView.text?.isEmpty == true
        contentImageView.isHidden = contentImageView.image == UIImage()
        
        if media.isLiked { likeButton.isSelected = true }
        
        likeCountLabel.text = String(media.likeCount)
        
        if let contentImageRationConstraint = imageRatioConstraint {
            contentImageRationConstraint.isActive = false
            contentImageView.removeConstraint(contentImageRationConstraint)
        }
        
        if media.image != UIImage() {
            if media.image.size.height > media.image.size.width {
                imageRatioConstraint = contentImageView.heightAnchor.constraint(equalTo: contentImageView.widthAnchor, multiplier: media.image.size.height / media.image.size.width)
            }
            
            else {
                imageRatioConstraint = contentImageView.heightAnchor.constraint(equalTo: contentImageView.widthAnchor, multiplier: media.image.size.width / media.image.size.height)
            }
        }
        
    }
    
    @objc func fulledImage() {
        guard let imageRatioConstraint else { return }
        
        imageRatioConstraint.isActive = !imageRatioConstraint.isActive
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        NotificationCenter.default.post(name: Notification.Name("NeedsUpdateLayout"), object: nil)
    }
}
