//
//  CommentsViewController.swift
//  videoApp
//
//  Created by Olga Vorona on 09/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//
import UIKit

class CommentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        if let bottomSheetVC: BottomSheetViewController = Storyboard.load(from: .main, identifier: "BottomSheetViewController") as? BottomSheetViewController {
            // 2- Add bottomSheetVC as a child view
            self.addChild(bottomSheetVC)
            self.view.addSubview(bottomSheetVC.view)
            bottomSheetVC.didMove(toParent: self)

            // 3- Adjust bottomSheet frame and initial position.
            let height = view.frame.height
            let width  = view.frame.width
            bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        }
    }
}
