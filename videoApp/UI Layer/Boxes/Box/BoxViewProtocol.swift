//
//  BoxViewProtocols.swift
//  videoApp
//
//  Created by Olga Vorona on 03/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol BoxViewInput: class {
    func update(box: IBoxPost, at index: Int)
}

protocol BoxViewOutput: class {
    func postOpened(postId: String, index: Int)
}
