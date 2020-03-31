//
//  ViewController.swift
//  NSLayoutConstraint-Animation-macOS
//
//  Created by zuolin on 2020/4/1.
//  Copyright © 2020 zuolin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet private weak var contentView: NSView!
    
    @IBOutlet private weak var contentViewTopSpaceLayoutConstraint: NSLayoutConstraint!
    
    private var contentViewTrackingArea: NSTrackingArea?
    
    private let minTopConstant: CGFloat = -48.0
    private let maxTopConstant: CGFloat = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateContentView()
        contentViewAddTrackingArea()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        updateLayourConstraintWhenMouseEntered()
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
     
        updateLayourConstraintWhenMouseExited()
    }
    
    deinit {
        contentViewRemoveTrackingArea()
    }
}

extension ViewController {
    private func updateContentView() {
        contentView.wantsLayer = true
        
        if let layer = contentView.layer {
            layer.backgroundColor = NSColor.controlAccentColor.cgColor
        }
    }
    
    private func contentViewAddTrackingArea() {
        contentViewTrackingArea = NSTrackingArea(rect: contentView.bounds, options: [.activeAlways, .inVisibleRect, .mouseEnteredAndExited], owner: self, userInfo: nil)
        
        guard let trackingArea = contentViewTrackingArea else {
            return
        }
        
        contentView.addTrackingArea(trackingArea)
    }
    
    private func contentViewRemoveTrackingArea() {
        guard let trackingArea = contentViewTrackingArea else {
            return
        }
        
        contentView.removeTrackingArea(trackingArea)
    }
    
    private func updateLayourConstraintWhenMouseEntered() {
        if contentViewTopSpaceLayoutConstraint.priority != .defaultHigh {
            contentViewTopSpaceLayoutConstraint.animator().constant = maxTopConstant
        }
        
        view.layoutSubtreeIfNeeded()
    }
        
    private func updateLayourConstraintWhenMouseExited() {
        if contentViewTopSpaceLayoutConstraint.priority != .defaultHigh {
            contentViewTopSpaceLayoutConstraint.animator().constant = minTopConstant
        }
        
        view.layoutSubtreeIfNeeded()
    }
}

