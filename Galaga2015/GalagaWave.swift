//
//  GalagaWave.swift
//  Galaga2015
//
//  Created by Andreas Umbach on 13.09.2015.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import Foundation
import SpriteKit

class GalagaWave
{
    var appearanceTime : NSTimeInterval = 0
    var numObjects : Int = 0
    var maxObjects : Int = 0
    var timeBetweenObjects : NSTimeInterval = 0

    var sprites = [SKSpriteNode]()
    
    let scene : GalagaScene
    
    init(scene: GalagaScene)
    {
        self.scene = scene
    }
    
    func doTick(currentTime: NSTimeInterval) { }
}