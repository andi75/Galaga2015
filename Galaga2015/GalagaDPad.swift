//
//  GalagaDPad.swift
//  Galaga2015
//
//  Created by Andreas Umbach on 13/09/15.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import Foundation
import SpriteKit

struct DPadSize {
    let r_rest : CGFloat = 0.2
    let r_gradient : CGFloat  = 0.6
}

class GalagaDPad : SKSpriteNode {
    let dpadSize = DPadSize()
    var value : CGFloat = 0
    var dx : CGFloat = 1.0
    var dy : CGFloat = 0
}
