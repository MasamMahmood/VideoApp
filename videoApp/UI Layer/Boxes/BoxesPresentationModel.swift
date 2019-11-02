//
//  BoxesPresentationModel.swift
//  videoApp
//
//  Created by Olga Vorona on 02/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class BoxesPresentationModel: IBoxesPresentationModel, BoxesViewOutput {
    var view: BoxesViewInput
    private var service: IBoxesService = ServiceProvider.instance.boxService

    init(view: BoxesViewInput) {
           self.view = view
       }
    
    func feedRequested() {
        service.getBoxes(userId: "niltest", completion: { [weak self] boxes in
            self?.view.feedRecieved(posts: boxes)
        })
    }
    
    func postOpened(postId: String) {
        
    }
}
