//
//  IPost.swift
//  videoApp
//
//  Created by Olga Vorona on 19/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol IPost {
    var id: String { get }
    var title: String { get }
    var type: String { get }
    var width: Int { get }
    var height: Int { get }
    var createAt: Date { get }
}
