//
//  TimelineView.swift
//  Evan Dekhayser
//
//  Created by Evan Dekhayser on 7/25/14.
//  Copyright (c) 2014 Evan Dekhayser. All rights reserved.
//

import UIKit

/**
	Represents an instance in the Timeline. A Timeline is built using one or more of these TimeFrames.
*/
public struct TimeFrame{

	let text: String

	let date: String

	let image: UIImage?
    
    let routeName: String
    
    let postId : String
    
    let routType : String
}

