//
//  BarGraphViewController.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 2024/01/06.
//

import UIKit

class BarGraphViewController: UIViewController {
    
    private var maxGraphHeight: CGFloat = 0
    
    private let nums = [100, 80, 60, 40, 20, 0]
    private var beforeSize: CGSize = CGSize(width: 0, height: 0)
    
    private var chartData = [
        "Jan", "Feb", "Mar", "Apr",
        "May", "Jun", "Jul", "Aug",
        "Sep", "Oct", "Nov", "Dec", "Sep", "Oct", "Nov", "Dec"
    ]
    
    private lazy var numberStackView: NumberStackView = {
        let view = NumberStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var scrollStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = UIStackView.spacingUseSystem
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var setRandomHeightButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "person.fill"), for: .normal)
        view.tintColor = .systemBlue
        view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        view.addTarget(self, action: #selector(setRandomHegiht), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(numberStackView)
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackView)
        
        view.addSubview(setRandomHeightButton)
        
        for item in nums { numberStackView.appendLabelView(num: String(item)) }
        
        configureLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        maxGraphHeight = numberStackView.bounds.height
        
        for mon in chartData {
            let view = BarGraphView()
            let height = CGFloat(CGFloat(Int.random(in: 0...100)) * (maxGraphHeight / 100))
            
            view.configure(val: (mon, height))
            view.currentHeight = height
            scrollStackView.addArrangedSubview(view)
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard !(beforeSize.width != 0 && beforeSize == size) else { return }
        beforeSize = size
        
        let newGraphHeight = (numberStackView.bounds.height * UIScreen.main.bounds.height) / UIScreen.main.bounds.width
        
        for view in self.scrollStackView.subviews {
            guard let graphView = view as? BarGraphView else { return }
            graphView.currentHeight = graphView.currentHeight / numberStackView.bounds.height * newGraphHeight
            graphView.setHeight(val: graphView.currentHeight)
        }
        
        maxGraphHeight = newGraphHeight
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            setRandomHeightButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            setRandomHeightButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            numberStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            numberStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            numberStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -32),
            numberStackView.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: -8),
    
            scrollView.topAnchor.constraint(equalTo: numberStackView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: numberStackView.trailingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollStackView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
            
            scrollStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc private func setRandomHegiht() {
        UIView.animate(withDuration: 0.3) {
            for view in self.scrollStackView.subviews {
                guard let graphView = view as? BarGraphView else { return }
                let height = CGFloat(Int.random(in: 0...100) * (Int(self.maxGraphHeight) / 100))
                graphView.currentHeight = height
                graphView.setHeight(val: height)
            }
            
            self.view.layoutIfNeeded()
        }
    }

}
