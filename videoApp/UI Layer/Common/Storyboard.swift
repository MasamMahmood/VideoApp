//
//  Storyboard.swift
//  videoApp
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
        let storyboard: UIStoryboard? = UIStoryboard(name: type.rawValue, bundle: Bundle.main)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as? T else {
            return nil
        }
        return vc
    }
}

