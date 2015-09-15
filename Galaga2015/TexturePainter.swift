//
//  TexturePainter.swift
//  Galaga2015
//
//  Created by Andreas Umbach on 13.09.2015.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class TexturePainter
{
    static func dpadTexture(size: CGSize, dpadSize: DPadSize) -> SKTexture
    {
        UIGraphicsBeginImageContext(size)
        let rect = CGRectMake(0, 0, size.width, size.height)
        let ctx = UIGraphicsGetCurrentContext()
        
        let outerColor = UIColor.blueColor()
        outerColor.setFill()
        CGContextFillEllipseInRect(ctx, rect)
        
        let middleColor = UIColor.purpleColor()
        let rectMiddle = CGRectInset(
            rect,
            size.width * 0.5 * (1 - dpadSize.r_gradient),
            size.height * 0.5 * (1 - dpadSize.r_gradient)
        )
        
        middleColor.setFill()
        CGContextFillEllipseInRect(ctx, rectMiddle )
        
        let innerColor = UIColor.whiteColor()
        innerColor.setFill()
        
        let rectInner = CGRectInset(
            rect,
            size.width * 0.5 * (1 - dpadSize.r_rest),
            size.height * 0.5 * (1 - dpadSize.r_rest)
        )
        CGContextFillEllipseInRect(ctx, rectInner )
        
        let textureImage = UIGraphicsGetImageFromCurrentImageContext();
        return SKTexture(image: textureImage!)
    }
}
