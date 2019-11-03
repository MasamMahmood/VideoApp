//
//  Storyboard.swift
//  videoApp
//
//  Created by Olga Vorona on 03/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit
//
public enum Storyboard: String {
    case main          = "Main"
    
    public func bundle() -> Bundle? {
        return Bundle.main
    }
    
    public static func load<T: UIViewController>(from type: Storyboard,
                                                 bundle: Bundle? = nil) -> T? {
        let identifier = String(describing: T.self)
        return load(from: type, identifier: identifier, bundle: bundle)
    }
    
    public static func load<T: UIViewController>(from type: Storyboard,
                                                 identifier: String,
                                                 bundle: Bundle? = nil) -> T? {
        let currBundle = bundle ?? Bundle(for: T.self)
        let storyboard: UIStoryboard? = UIStoryboard(name: type.rawValue, bundle: currBundle)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as? T else {
            return nil
        }
        return vc
    }
    //
    //    public static func loadInitial<T: UIViewController>(from type: Storyboard,
    //                                                        bundle: Bundle? = nil) -> T? {
    //        let currBundle = bundle ?? Bundle(for: T.self)
    //        let storyboard: UIStoryboard? = UIStoryboard(name: type.rawValue, bundle: currBundle)
    //        guard let vc = storyboard?.instantiateInitialViewController() as? T else {
    //            log.assert(false, "Can't load initial view controller: \(T.self)")
    //            return nil
    //        }
    //        tryToResolveVC(vc: vc)
    //        return vc
    //    }
}

