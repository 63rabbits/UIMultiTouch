//
//  MultiTouchableView.swift
//  UIMultiTouch
//  Base Code :
//      https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view/implementing_a_multi-touch_app
//
//  Created by 63rabbits goodman on 2023/12/21.
//

import UIKit

class MultiTouchableView: UIView {
    var touchViews = [UITouch:TouchSpotView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCommon()
    }

    func initCommon() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            createViewForTouch(touch: touch)
        }

        // for Debug
        print("--- [ \(touches.count) ] @ \(Double(touches.first!.timestamp)) sec ---")
        for touch in touches {
            let location = touch.location(in: self)
            print("(x, y) = ( \(location.x), \(location.y) )")
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let view = viewForTouch(touch: touch)
            // Move the view to the new location.
            let newLocation = touch.location(in: self)
            view?.center = newLocation
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            removeViewForTouch(touch: touch)
        }

        // for Debug
        print("--- [ Cancelled ] @ \(Double(touches.first!.timestamp)) sec ---")
        if let allTouches = event?.allTouches {
            for touch in allTouches {
                let location = touch.location(in: self)
                print("(x, y) = ( \(location.x), \(location.y) )")
            }
        }

    }

    func createViewForTouch( touch : UITouch ) {
        let newView = TouchSpotView()
        newView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        newView.center = touch.location(in: self)

        // Add the view and animate it to a new size.
        addSubview(newView)

        // Save the views internally
        touchViews[touch] = newView
    }

    func viewForTouch (touch : UITouch) -> TouchSpotView? {
        return touchViews[touch]
    }

    func removeViewForTouch (touch : UITouch ) {
        if let view = touchViews[touch] {
            view.removeFromSuperview()
            touchViews.removeValue(forKey: touch)
        }
    }

}


class TouchSpotView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }

    func initCommon() {
        isUserInteractionEnabled = false
        backgroundColor = UIColor.lightGray
    }

    override var bounds: CGRect {
        get { return super.bounds }
        set(newBounds) {
            super.bounds = newBounds
            // Update the corner radius when the bounds change.
            layer.cornerRadius = newBounds.size.width / 2.0
        }
    }
}
