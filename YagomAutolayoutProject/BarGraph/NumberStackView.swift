//
//  NumberStackView.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 1/10/24.
//

import UIKit

class NumberStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.spacing = 15
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appendLabelView(num: String) {
        let view = UILabel()
        view.text = num
        view.textColor = .black
        view.font = .preferredFont(forTextStyle: .body)
        
        self.addArrangedSubview(view)
    }
    
}
