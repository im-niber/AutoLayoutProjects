//
//  BarGraphView.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 1/10/24.
//

import UIKit

class BarGraphView: UIView {
    
    private var chartHeightConstraint: NSLayoutConstraint!
    
    var currentHeight: CGFloat = 1
    
    private lazy var chartView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var chartLabel: UILabel = {
        let view = UILabel()
        view.adjustsFontSizeToFitWidth = true
        view.font = .preferredFont(forTextStyle: .body)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(chartView)
        addSubview(chartLabel)
    }
    
    private func configureLayout() {
        chartHeightConstraint = chartView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: currentHeight)
        
        let lessThanTopConstraint = chartView.topAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.topAnchor)
        lessThanTopConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            chartLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            chartLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            chartLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            chartView.leadingAnchor.constraint(equalTo: chartLabel.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: chartLabel.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: chartLabel.topAnchor, constant: -8),
            lessThanTopConstraint,
            chartHeightConstraint
        ])
    }
    
    func configure(val: (String, CGFloat)) {
        chartLabel.text = val.0
        chartHeightConstraint.constant = val.1
        currentHeight = val.1
    }
    
    func setHeight(val: CGFloat) {
        chartHeightConstraint.constant = val
        currentHeight = val
    }
}
