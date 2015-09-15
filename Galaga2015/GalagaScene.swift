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

enum GalagaGroups : UInt32 {
    case PlayerShip = 1
    case PlayerShots = 2
    case HostileShips = 4
    case HostileShots = 8
}

class GalagaScene : SKScene, SKPhysicsContactDelegate
{
    let dpad = GalagaDPad()
    let ship = GalagaShip()
    
    var lasttime : NSTimeInterval = 0
    var timeoffset : NSTimeInterval = 0
    
    var waves = [GalagaWave]()
    
    override func didMoveToView(view: SKView)
    {
        self.size = view.bounds.size
        self.scaleMode = .AspectFill

        dpad.position = CGPointMake(view.center.x, 60)
        dpad.color = UIColor.redColor()
        dpad.size = CGSizeMake(160, 160)
        dpad.texture = TexturePainter.dpadTexture(dpad.size, dpadSize: dpad.dpadSize)
        
        self.addChild(dpad)
        
        ship.position = view.center
        ship.size = CGSizeMake(60, 60)
        ship.color = UIColor.whiteColor()
        ship.physicsBody = SKPhysicsBody(rectangleOfSize: ship.size)
        ship.physicsBody?.categoryBitMask = 1 // GalagaGroups.PlayerShip
        ship.physicsBody?.collisionBitMask = 0
        ship.physicsBody?.contactTestBitMask = 4 | 8 // GalagaGroups.HostileShips | GalagaGroups.HostileShots
        ship.physicsBody?.affectedByGravity = false
        
        
        self.addChild(ship)
        
        let path1 = PathFactory.verticalPath(self.size, x: self.size.width * 0.25)
        let path2 = PathFactory.verticalPath(self.size, x: self.size.width * 0.5)
        let path3 = PathFactory.verticalPath(self.size, x: self.size.width * 0.75)
        let path4 = PathFactory.horizontalPath(self.size, y: self.size.height * 0.33, fromLeft: true)
        let path5 = PathFactory.horizontalPath(self.size, y: self.size.height * 0.66, fromLeft: false)
        
        let wave1 = GalagaSinglePathWave(scene: self, path: path2, maxObjects: 3, appearanceTime: 2.0, timeBetweenObjects: 3.0 )
        let wave2 = GalagaSinglePathWave(scene: self, path: path1, maxObjects: 5, appearanceTime: 6.0, timeBetweenObjects: 5.0 )
        let wave3 = GalagaSinglePathWave(scene: self, path: path3, maxObjects: 4, appearanceTime: 10.0, timeBetweenObjects: 2.5 )
        let wave4 = GalagaSinglePathWave(scene: self, path: path4, maxObjects: 3, appearanceTime: 14.0, timeBetweenObjects: 3.0 )
        let wave5 = GalagaSinglePathWave(scene: self, path: path5, maxObjects: 2, appearanceTime: 10.0, timeBetweenObjects: 2.0 )
        let wave6 = GalagaSinglePathWave(scene: self, path: path2, maxObjects: 3, appearanceTime: 5.0,
            timeBetweenObjects: 4.0)
        
        waves.append(wave1)
        waves.append(wave2)
        waves.append(wave3)
        waves.append(wave4)
        waves.append(wave5)
        waves.append(wave6)
        
        self.physicsWorld.contactDelegate = self
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node as! SKSpriteNode
        let nodeB = contact.bodyB.node as! SKSpriteNode
        nodeA.color = UIColor.blueColor()
        nodeB.color = UIColor.greenColor()
        println(contact)
    }

    func touchOrMove(touches: Set<NSObject>)
    {
        for e in touches
        {
            let touch = e as! UITouch
            let touchpoint = self.convertPointFromView(touch.locationInView(self.view))
            let node = self.nodeAtPoint(touchpoint)
            if(node == dpad)
            {
                let pointinnode = touch.locationInNode(dpad)
                
                let d = sqrt(pointinnode.x * pointinnode.x + pointinnode.y * pointinnode.y)
                let r = d / (node.frame.width / 2.0)
                if(r != 0)
                {
                    dpad.dx = pointinnode.x / d
                    dpad.dy = pointinnode.y / d
                }
                if(r < dpad.dpadSize.r_rest || r > 1)
                {
                    dpad.value = 0
                }
                else if(r < dpad.dpadSize.r_gradient)
                {
                    dpad.value = (r - dpad.dpadSize.r_rest) / (dpad.dpadSize.r_gradient - dpad.dpadSize.r_rest)
                }
                else
                {
                    dpad.value = 1
                }
                println(dpad.value)
                println(pointinnode)
            }
        }

    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
         touchOrMove(touches)
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        touchOrMove(touches)
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        dpad.value = 0
    }
    
    override func update(currentTime: NSTimeInterval) {
        if(timeoffset == 0)
        {
            timeoffset = currentTime
        }
        if(lasttime == 0)
        {
            lasttime = currentTime
        }
        let dt = currentTime - lasttime
        if(dt < 0.01)
        {
            return
        }
        else
        {
            doTick(CGFloat(dt))
        }
        
        for wave in waves
        {
            wave.doTick(currentTime - timeoffset)
        }
        
        lasttime = currentTime
    }
    
    func doTick(dt: CGFloat)
    {
        ship.position.x += ship.gspeed * dpad.dx * dpad.value * dt
        ship.position.y += ship.gspeed * dpad.dy * dpad.value * dt
        ship.position.x = max(ship.position.x, view!.frame.minX)
        ship.position.x = min(ship.position.x, view!.frame.maxX)
        ship.position.y = max(ship.position.y, view!.frame.minY)
        ship.position.y = min(ship.position.y, view!.frame.maxY)
        
//        println(ship.position)
    }
}
