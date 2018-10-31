//
//  StickyHeaderController.swift
//  StickyHeaderController
//
//  Created by Przemyslaw Bobak on 31/10/2018.
//  Copyright © 2018 Przemyslaw Bobak. All rights reserved.
//

import UIKit

/// StickyHeaderController maintains the top position of a view
/// placed in the table view as user scrolls the view
class StickyHeaderController {
    /// View that should stick to the top of view controller
    let view: UIView
    /// Default height for the view, before factoring in the height of a navigation bar
    let initialHeight: CGFloat
    /// View Controller the view is attached to
    weak var trackedViewController: UITableViewController?

    /// Total height for the calculated view
    var viewHeight: CGFloat {
        return initialHeight + topBarHeight
    }

    /// Height value of the status bar and, if visible, the navigation bar
    var topBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (trackedViewController?.navigationController?.navigationBar.frame.height ?? 0.0)
    }

    /// Initialize the Sticky Header Controller
    ///
    /// - Parameters:
    ///   - view: View ti display as the header of the view controller
    ///   - initial: Height value that the view should maintain
    init(view: UIView, height initial: CGFloat) {
        self.view = view
        initialHeight = initial
    }

    /// Attaches to given Table View
    ///
    /// - Parameter viewController: An instance of a UIViewController
    func attach(to viewController: UITableViewController) {
        self.trackedViewController = viewController

        viewController.tableView.tableHeaderView = nil
        viewController.tableView.addSubview(view)

        viewController.tableView.contentInset = UIEdgeInsets(top: viewHeight, left: 0, bottom: 0, right: 0)
        viewController.tableView.contentOffset = CGPoint(x: 0, y: -viewHeight)


        if #available(iOS 11.0, *) {
            viewController.tableView.contentInsetAdjustmentBehavior = .never
        }

        // Initial layout setup
        layoutStickyView()
    }

    /// Updates the height of the view depending on the scroll position of the tracked view controller
    func layoutStickyView() {
        guard let tableView = trackedViewController?.tableView else { return }

        var newFrame = CGRect(x: 0, y: -viewHeight, width: tableView.bounds.width, height: viewHeight)

        if tableView.contentOffset.y < -viewHeight {
            // Expanding…
            newFrame.origin.y = tableView.contentOffset.y
            newFrame.size.height = -tableView.contentOffset.y
        } else {
            // Normal scrolling…
            newFrame.origin.y = tableView.contentOffset.y
            newFrame.size.height = viewHeight
        }

        view.frame = newFrame
        view.layer.zPosition = 1000
    }
}
