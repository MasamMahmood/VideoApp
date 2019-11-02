//
//  BoxesViewController.swift
//  videoApp
//
//  Created by Olga Vorona on 02/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

class BoxesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewOutput: BoxesViewOutput?
    private var posts: [IBoxPost] = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput = BoxesPresentationModel(view: self)
        viewOutput?.feedRequested()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.registerReusableCell(FeedBoxTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refreshBoxes(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    @objc private func refreshBoxes(_ sender: Any) {
        viewOutput?.feedRequested()
    }
}

extension BoxesViewController: BoxesViewInput {
    func feedRecieved(posts: [IBoxPost]?) {
        refreshControl.endRefreshing()
        guard let posts = posts else { return }
        self.posts = posts
        tableView.reloadData()
    }
}

extension BoxesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let box = posts[indexPath.row]
        let cell: FeedBoxTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(with: box)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
