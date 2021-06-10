//
//  RectangularButton.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/7/21.
//

import UIKit

class RectangularButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        //self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.5
        // Drawing code
    }

}
