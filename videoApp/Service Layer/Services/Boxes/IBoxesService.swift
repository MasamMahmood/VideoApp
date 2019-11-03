//
//  IBoxesService.swift
//  videoApp
//
//  Created by Olga Vorona on 18/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

protocol IBoxesService {
    func getBoxes(userId: String, completion: @escaping (([IBoxPost]?) -> Void))
    func openBox(userId: String, boxId: String, completion: @escaping ((IBoxPost?) -> Void))
}
