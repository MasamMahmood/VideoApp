//
//  BottomSheetViewController.swift
//  videoApp
//
//  Created by Olga Vorona on 09/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

protocol BottomSheetDelegate: class {
    func didCloseComments()
    func didWriteComment(text: String)
}

protocol BottomSheetInputView: class {
    func updateComments(with: [IComment])
    var delegate: BottomSheetDelegate? { get set }
}

final class BottomSheetViewController: UIViewController, BottomSheetInputView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentsLabel: UILabel!
    
    weak var delegate: BottomSheetDelegate?
    private var comments: [IComment]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func updateComments(with: [IComment]) {
        self.comments = with
        commentsLabel.text = "\(comments.count) comments"
        tableView.reloadData()
    }

    private func setupTableView() {
          tableView.delegate = self
          tableView.dataSource = self
          tableView?.registerReusableCell(CommentCell.self)
      }
    
    
    @IBAction func closePressed(_ sender: Any) {
        delegate?.didCloseComments()
    }
}

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(with: comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
