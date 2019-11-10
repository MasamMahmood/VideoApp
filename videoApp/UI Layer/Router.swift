//
//  Router.swift
//  videoApp
//
//  Created by Olga Vorona on 03/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

class Router {
    
    func openBoxScreen(post: IBoxPost) {
        
    }
    
    func openComments(vc: UIViewController?, post: IContentPost) {
        if let comments: CommentsViewController = Storyboard.load(from: .main, identifier: "CommentsViewController") as? CommentsViewController {
            comments.post = post
            comments.modalPresentationStyle = .fullScreen
            vc?.show(comments, sender: nil)
        }
    }
    
    func bottomVC() -> BottomSheetViewController {
        if let bottom: BottomSheetViewController = Storyboard.load(from: .main, identifier: "BottomSheetViewController") as? BottomSheetViewController {
            return bottom
        } else {
            return BottomSheetViewController()
        }
    }
    
}
