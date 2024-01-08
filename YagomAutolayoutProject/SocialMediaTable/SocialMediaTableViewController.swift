//
//  SocialMediaTableViewController.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 2024/01/06.
//

import UIKit

class SocialMediaTableViewController: UIViewController {
    
    let dummy: [SocialMedia] = [
        SocialMedia(profileImage: UIImage(systemName: "figure.walk")!, name: "walk", time: Date(timeIntervalSinceNow: -3000), content: "iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?", image: UIImage(named: "1")!, isLiked: false, likeCount: 334),
        SocialMedia(profileImage: UIImage(systemName: "airplane")!, name: "비행기", time: Date(timeIntervalSinceNow: -59595), content: "iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?", image: UIImage(named: "2")!, isLiked: true, likeCount: 302),
        SocialMedia(profileImage: UIImage(systemName: "car")!, name: "자동차", time: Date(timeIntervalSinceNow: -59595), content: "iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?", image: UIImage(named: "3")!, isLiked: true, likeCount: 444),SocialMedia(profileImage: UIImage(systemName: "airplane")!, name: "안비행기", time: Date(timeIntervalSinceNow: -232323), content: "iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?", image: UIImage(named: "2")!, isLiked: false, likeCount: 555),
        SocialMedia(profileImage: UIImage(systemName: "car")!, name: "자동차", time: Date(timeIntervalSinceNow: -59595), content: "iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?", image: UIImage(named: "3")!, isLiked: true, likeCount: 444),
        SocialMedia(profileImage: UIImage(systemName: "airplane")!, name: "안비행기", time: Date(timeIntervalSinceNow: -232323), content: "iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?, iYppWqJOoCh5Bz1Rj8N9LWA1ZRG82YzicUZWCpnBpXRQsQwxz3bHkkzM1oS8eKdCxxIlolziUOARt5Netm9xUNYFlH?", image: UIImage(), isLiked: false, likeCount: 555)
    ]
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.automaticallyAdjustsScrollIndicatorInsets = true
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        view.separatorStyle = .singleLine
        view.separatorInset = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SocialMediaCell.self, forCellReuseIdentifier: "SocialMediaCell")
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        NotificationCenter.default.addObserver(forName: Notification.Name("NeedsUpdateLayout"), object: nil, queue: nil) { noti in
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            
//            self.tableView.performBatchUpdates(nil)
        }
        
    }
}


extension SocialMediaTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialMediaCell", for: indexPath)
        
        guard let cell = cell as? SocialMediaCell else { return UITableViewCell() }
        cell.configure(media: dummy[indexPath.row])
        
        return cell
    }
    
}
