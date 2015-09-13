//
//  GalagaScene.swift
//  Galaga2015
//
//  Created by Andreas Umbach on 13/09/15.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GalagaScene : SKScene
{
    let dpad = GalagaDPad()
    
    override func didMoveToView(view: SKView)
    {
        self.size = view.bounds.size
        self.scaleMode = .AspectFill

        dpad.position = CGPointMake(100, 100)
        dpad.color = UIColor.redColor()
        dpad.size = CGSizeMake(100, 100)
        
        self.addChild(dpad)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for e in touches
        {
            let touch = e as! UITouch
            let touchpoint = self.convertPointFromView(touch.locationInView(self.view))
            let node = self.nodeAtPoint(touchpoint)
            if(node == dpad)
            {
                let pointinnode = touch.locationInNode(dpad)
                println("(\(pointinnode.x), \(pointinnode.y) => \(sqrt(pointinnode.x * pointinnode.x + pointinnode.y * pointinnode.y))")
            }
        }
    }
}
