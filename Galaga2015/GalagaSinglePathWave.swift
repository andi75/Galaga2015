//
//  GalagaSinglePathWave.swift
//  Galaga2015
//
//  Created by Andreas Umbach on 13.09.2015.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GalagaSinglePathWave : GalagaWave
{
    var path : CGPath?
    var pathTime = 3.0
    
    init(scene: GalagaScene, path: CGPath, maxObjects: Int, appearanceTime: NSTimeInterval, timeBetweenObjects: NSTimeInterval)
    {
        super.init(scene: scene)
        
        self.path = path
        self.maxObjects = maxObjects
        self.appearanceTime = appearanceTime
        self.timeBetweenObjects = timeBetweenObjects
    }
    
    override func doTick(currentTime: NSTimeInterval) {
        
        if(
            numObjects < maxObjects &&
            (currentTime - appearanceTime) / timeBetweenObjects >= NSTimeInterval(numObjects)
            )
        {
            println("creating node \(numObjects)")

            numObjects++
            let node = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(50, 50))
            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
            node.physicsBody?.categoryBitMask = 4 // GalagaGroups.HostileShips
            node.physicsBody?.contactTestBitMask = 1 // GalagaGroups.PlayerShip
            node.physicsBody?.collisionBitMask = 0
            node.physicsBody?.affectedByGravity = false
            
            let followPath = SKAction.followPath(path!, asOffset: false, orientToPath: true, duration: pathTime)
            node.runAction(followPath)
            sprites.append(node)
            
            scene.addChild(node)
        }
    }
}