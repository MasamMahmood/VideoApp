//
//  BoxesViewProtocol.swift
//  videoApp
//
//  Created by Olga Vorona on 02/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

protocol BoxesViewInput: class {
    func feedRecieved(posts: [IBoxPost]?)
    func update(box: IBoxPost, at index: Int)
}

protocol BoxesViewOutput: class {
    func feedRequested()
    func postOpened(postId: String, index: Int)
}
