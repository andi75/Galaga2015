//
//  ViewController.swift
//  Galaga2015
//
//  Created by Andreas Umbach on 13/09/15.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let scene = GalagaScene()
        
        let view = self.view as! SKView
        view.presentScene(scene)        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

