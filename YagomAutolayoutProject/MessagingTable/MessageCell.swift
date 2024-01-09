//
//  MessageCell.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 1/9/24.
//

import UIKit

// 1. 라벨 내부에 마진을 주는 방법
extension UILabel {
    func setMargins(margin: CGFloat = 10) {
        if let textString = self.text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.firstLineHeadIndent = margin
            paragraphStyle.headIndent = margin
            paragraphStyle.tailIndent = -margin
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

// 2. 서브클래싱을 사용하는 방법
class MessageLabel: UILabel {
    let padding: UIEdgeInsets

   // Create a new PaddingLabel instance programamtically with the desired insets
   required init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)) {
       self.padding = padding
       super.init(frame: CGRect.zero)
   }

   // Create a new PaddingLabel instance programamtically with default insets
   override init(frame: CGRect) {
       padding = UIEdgeInsets.zero // set desired insets value according to your needs
       super.init(frame: frame)
   }

   // Create a new PaddingLabel instance from Storyboard with default insets
   required init?(coder aDecoder: NSCoder) {
       padding = UIEdgeInsets.zero // set desired insets value according to your needs
       super.init(coder: aDecoder)
   }

   override func drawText(in rect: CGRect) {
       super.drawText(in: rect.inset(by: padding))
   }

   // Override `intrinsicContentSize` property for Auto layout code
   override var intrinsicContentSize: CGSize {
       let superContentSize = super.intrinsicContentSize
       let width = superContentSize.width + padding.left + padding.right
       let height = superContentSize.height + padding.top + padding.bottom
       return CGSize(width: width, height: height)
   }

   // Override `sizeThatFits(_:)` method for Springs & Struts code
   override func sizeThatFits(_ size: CGSize) -> CGSize {
       let superSizeThatFits = super.sizeThatFits(size)
       let width = superSizeThatFits.width + padding.left + padding.right
       let heigth = superSizeThatFits.height + padding.top + padding.bottom
       return CGSize(width: width, height: heigth)
   }
}

class MessageCell: UITableViewCell {
    
    private let width: CGFloat = UIScreen.main.bounds.width * 0.7
    
    private var messageLeadingConstraint: NSLayoutConstraint?
    private var messageTrailingConstraint: NSLayoutConstraint?

    lazy var messageView: MessageLabel = {
        let view = MessageLabel(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        view.font = .preferredFont(forTextStyle: .callout)
        view.numberOfLines = 0
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.adjustsFontForContentSizeCategory = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLeadingConstraint?.isActive = false
        messageTrailingConstraint?.isActive = false
        messageView.text = ""
    }
    
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
        contentView.addSubview(messageView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageView.widthAnchor.constraint(lessThanOrEqualToConstant: width)
        ])
    }
    
    func confiure(text: String, me: Bool) {
        messageView.text = text
        
        if me {
            messageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
            messageView.backgroundColor = .green
            messageView.textColor = .white
            
            messageTrailingConstraint =  messageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8)
            messageTrailingConstraint?.isActive = true
        }
        
        else {
            messageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
            messageView.backgroundColor = .lightGray
            messageView.textColor = .black
            
            messageLeadingConstraint = messageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8)
            messageLeadingConstraint?.isActive = true
        }
    }

}
