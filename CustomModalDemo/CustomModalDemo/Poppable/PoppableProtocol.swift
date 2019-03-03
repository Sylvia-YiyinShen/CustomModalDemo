//
//  PoppableProtocol.swift
//  CustomModalDemo
//
//  Created by Sylvia Shen on 4/3/19.
//  Copyright © 2019 Sylvia Shen. All rights reserved.
//

import Foundation
import UIKit

public protocol PoppableProtocol: class {
    func showAsPopover(shouldShowDimmingView: Bool, animated: Bool)
    func dismissAsPopover()
    var modalSize: CGSize { get }
}

private var _alertWindowAssociationKey = 0
public extension PoppableProtocol where Self: UIViewController{
    public var alertWindow: UIWindow? {
        get {
            return objc_getAssociatedObject(self, &_alertWindowAssociationKey) as? UIWindow
        }
        set {
            objc_setAssociatedObject(self, &_alertWindowAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func showAsPopover(shouldShowDimmingView: Bool = true, animated: Bool = true) {
        guard alertWindow == nil else {
            return
        }
        
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        window.makeKeyAndVisible()
        if shouldShowDimmingView {
            window.showDimmingView()
        }
        alertWindow = window
        
        var initialVerticalConstraint: NSLayoutConstraint?
        var finalVerticalConstraint: NSLayoutConstraint?
        
        window.rootViewController = self
        window.addSubview(view)
        view.layer.cornerRadius = 15
        preferredContentSize = modalSize
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: preferredContentSize.height),
            view.widthAnchor.constraint(equalToConstant: preferredContentSize.width),
            view.centerXAnchor.constraint(equalTo: window.centerXAnchor)
            ])
        
        initialVerticalConstraint = view.topAnchor.constraint(equalTo: window.bottomAnchor)
        finalVerticalConstraint = view.centerYAnchor.constraint(equalTo: window.centerYAnchor)
        
        if animated {
            initialVerticalConstraint?.isActive = true
            finalVerticalConstraint?.isActive = false
            window.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.2) {
                initialVerticalConstraint?.isActive = false
                finalVerticalConstraint?.isActive = true
                window.layoutIfNeeded()
            }
        } else {
            initialVerticalConstraint?.isActive = false
            finalVerticalConstraint?.isActive = true
            window.layoutIfNeeded()
        }
    }
    
    public func dismissAsPopover() {
        alertWindow?.hideDimmingView()
        alertWindow?.resignKey()
        alertWindow?.isHidden = true
        alertWindow = nil
    }
}


private var dimmingViewAssociationKey = 0

extension UIView {
    private var _dimmingView: UIView? {
        get {
            return objc_getAssociatedObject(self, &dimmingViewAssociationKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &dimmingViewAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func showDimmingView() {
        guard _dimmingView == nil else { return }
        
        let dimmingView = UIView()
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        addSubview(dimmingView)
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        _dimmingView = dimmingView
    }
    
    public func hideDimmingView() {
        _dimmingView?.removeFromSuperview()
        _dimmingView = nil
    }
}
