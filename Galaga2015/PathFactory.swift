//
//  PathFactory.swift
//  Galaga2015
//
//  Created by Andreas Umbach on 13.09.2015.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import Foundation
import UIKit

class PathFactory
{
    static func verticalPath(frameSize: CGSize, x: CGFloat) -> CGPath
    {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, x, frameSize.height)
        CGPathAddLineToPoint(path, nil, x, 0)
        return path
    }
    static func horizontalPath(frameSize: CGSize, y: CGFloat, fromLeft: Bool) -> CGPath
    {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, fromLeft ? 0 : frameSize.width, y)
        CGPathAddLineToPoint(path, nil, fromLeft ? frameSize.width : 0, y)
        return path
    }
}