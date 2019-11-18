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
    
    func update(box: IBoxPost, at index: Int) {
        tableView.beginUpdates()
        posts.remove(at: index)
        posts.insert(box, at: index)
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
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
        
        viewOutput?.postOpened(postId: posts[indexPath.row].id, index: indexPath.row)
        
        let refreshAlert = UIAlertController(title: "Appodeal", message: "Content will be available after short Ad.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popToRootViewController(animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BoxViewController") as! BoxViewController
            vc.boxId = self.posts[indexPath.row].id
            self.present(vc, animated: true, completion: nil)
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
        refreshAlert .dismiss(animated: true, completion: nil)

        }))

        self.present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
