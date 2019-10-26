//
//  ViewFromNib.swift
//  videoApp
//
//  Created by Olga Vorona on 26/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    class func loadFrom<T: UIView>(viewClass: T.Type) -> T {
        let key = String(describing: T.self)
        let bundle = Bundle(for: T.self)
        if let nib = UINib(nibName: key, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? T {
            return nib
        } else {
            preconditionFailure()
        }
    }

    class func loadFrom(nib nibName: String, for anyClass: AnyClass) -> UIView? {
        return UINib(nibName: nibName, bundle: Bundle(for: anyClass)).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }

    class func loadFromXib<T:Any>() -> T {
        let key = String(describing: T.self)
        let bundle = Bundle(for: T.self as! AnyClass)
        if let nib = UINib(nibName: key, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? T {
            return nib
        } else {
            preconditionFailure()
        }
    }
}
