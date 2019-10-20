//
//  TableViewHelper.swift
//  videoApp
//
//  Created by Olga Vorona on 20/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

public protocol ICollectionCell: class {

    // MARK: - Static

    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

public protocol ICollectionCellFromNib: ICollectionCell {}

public extension ICollectionCellFromNib {
    static var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

public extension ICollectionCellFromNib {
    
    static func loadFromNib(withOwner owner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> Self? {
        return nib?.instantiate(withOwner: owner, options: options).first as? Self
    }
    
}

extension UITableView {
    
    public func register<Cell: UITableViewCell & ICollectionCell>(_ cell: Cell.Type) {
        if let nib = cell.nib {
            register(nib, forCellReuseIdentifier: Cell.reuseIdentifier)
        } else {
            register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        }
    }
    
    public func dequeueReusableCell<Cell: UITableViewCell & ICollectionCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell // swiftlint:disable:this force_cast line_length
    }
    
}

public extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: ICollectionCell {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: ICollectionCell {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ICollectionCell {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T? where T: ICollectionCell {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
    }
}

