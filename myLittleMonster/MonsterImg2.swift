//
//  MonsterImg2.swift
//  myLittleMonster
//
//  Created by Jonathan Tsistinas on 4/13/16.
//  Copyright © 2016 Techinator. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg2: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        
        self.image = UIImage(named:"appear1.png")
        
        self.animationImages = nil
        
        
        var imgArray = [UIImage]()
        //swift 2.1 code for loop \/
        //for var x = 1; x <= 10; x += 1 {
        //swift 3.0 code for loop \/
        for x in 1.stride(to: 10, by: 1) {
            let img = UIImage(named: "appear\(x).png")
            imgArray.append(img!)
            
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "hide6.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        //swift 2.1 code for loop \/
        //for var x = 1; x <= 6; x += 1 {
        //swift 3.0 code for loop \/
        for x in 1.stride(to: 6, by: 1) {
            let img = UIImage(named: "hide\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
}

