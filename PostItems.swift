//
//  PostItems.swift
//  KallerRadar
//
//  Created by Kuli Gabor on 2015. 05. 22..
//  Copyright (c) 2015. kebodev. All rights reserved.
//

import UIKit

class PostItems: UIView {

    var labelText : String!
    var labelHeader : String!
    var outView : UIView!
    
    init(labelText: String , labelHeader: String) {
        super.init(frame: CGRectMake(0, 0, 1, 1))
        self.labelText = labelText
        self.labelHeader = labelHeader
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        setupContent()
        
    }

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        println("required public")
    }
    
    
    private func setupContent(){
        println("setupContent fut nem a forban")
        /*
        for v in subviews{
            println("setupContent fut for ciklusban")
            v.removeFromSuperview()
        }
        */
        self.outView = blockForTimeFrame()
        addSubview(blockForTimeFrame())
    }
    
    private func blockForTimeFrame() -> UIView{
        
        
        
        let viewNew = UIView()
        viewNew.setTranslatesAutoresizingMaskIntoConstraints(false)

        
        let titleLabel = UILabel()
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont(name: "ArialMT", size: 20)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.text = labelHeader
        titleLabel.numberOfLines = 0
        titleLabel.layer.masksToBounds = false
        viewNew.addSubview(titleLabel)
        viewNew.addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .Width, relatedBy: .Equal, toItem: viewNew, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: viewNew, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: viewNew, attribute: .Top, multiplier: 1.0, constant: 0)
            ])
        
        
        
        /*
        
        let textLabel = UILabel()
        textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        textLabel.font = UIFont(name: "ArialMT", size: 16)
        textLabel.text = labelText
        textLabel.textColor = UIColor.blackColor()
        textLabel.numberOfLines = 0
        textLabel.layer.masksToBounds = false
        

        
        v.addSubview(textLabel)
        v.addConstraints([
            NSLayoutConstraint(item: textLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: textLabel, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: textLabel, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1.0, constant: 5)
            ])
*/
        return viewNew
        
    }

}
