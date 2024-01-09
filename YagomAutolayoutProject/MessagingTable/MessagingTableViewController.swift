//
//  MessagingTableViewController.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 2024/01/06.
//

import UIKit

class MessagingTableViewController: UIViewController {
    
    var dummy: [(String, Bool)] = [
        ("asdfasdfasdfasdf", false),
        ("asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf", false),
        ("asdfasdfasdfasdf", false),
        ("asdfasdfasdfasdfasdfasdfasdfasdf", true),
        ("asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf", true),
        ("asdfasdfasdfasdf", false),
        ("asdfasdfasdfasdf", true),
        ("asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf",true),
        ("asdfasdfasdfasdf", false),
        ("asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf",true),
    ]
    
    private var bottomConstraint: NSLayoutConstraint!
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.keyboardDismissMode = .onDrag
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var messageTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.textColor = .black
        view.backgroundColor = .lightGray
        view.setContentHuggingPriority(.init(1), for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var messageButton: UIButton = {
        let view = UIButton()
        view.setTitle("SEND", for: .normal)
        view.tintColor = .blue
        view.setTitleColor(UIColor.black, for: .normal)
        view.addTarget(self, action: #selector(appendData), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    @objc private func appendData() {
        dummy.append((messageTextField.text ?? "", Bool.random()))
        messageTextField.text = ""

        let indexPath = IndexPath(row: dummy.count - 1, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .none)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        
        view.addSubview(tableView)
        view.addSubview(messageTextField)
        view.addSubview(messageButton)
        
        bottomConstraint = messageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor),
            
            messageTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            messageTextField.trailingAnchor.constraint(equalTo: messageButton.leadingAnchor, constant: -8),
            bottomConstraint,
            
            messageButton.topAnchor.constraint(equalTo: messageTextField.topAnchor),
            messageButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor, constant: 8),
            messageButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { noti in
            guard let userInfo = noti.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            self.bottomConstraint.constant = -(keyboardFrame.height + 8) + self.view.safeAreaInsets.bottom
        
            guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
            
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { noti in
            guard let userInfo = noti.userInfo, let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
            
            self.bottomConstraint.constant = -8
            
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
}

extension MessagingTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell else { return UITableViewCell() }
        let item = dummy[indexPath.row]
        cell.confiure(text: item.0, me: item.1)
        
        return cell
    }
    
}
