//
//  TabBarController.swift
//  FrostedSidebar
//
//  Created by Evan Dekhayser on 8/28/14.
//  Copyright (c) 2014 Evan Dekhayser. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
	
	var sidebar: FrostedSidebar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
		tabBar.hidden = true
		
		moreNavigationController.navigationBar.hidden = true
		
		sidebar = FrostedSidebar(itemImages: [
			UIImage(named: "gear")!,
			UIImage(named: "globe")!,
            UIImage(named: "globe")!
],
			colors: [
				UIColor(red:0.15, green:0.43, blue:0.72, alpha:1.0),
				UIColor(red:0.15, green:0.43, blue:0.72, alpha:1.0),
                UIColor(red:0.15, green:0.43, blue:0.72, alpha:1.0),
],
			selectedItemIndices: NSIndexSet(index: 0))
		
		sidebar.isSingleSelect = true
		sidebar.actionForIndex = [
			0: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 0}) },
			1: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 1}) },
			2: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 2}) },
			3: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 3}) },
			4: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 4}) },
			5: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 5}) },
			6: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 6}) },
			7: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 7}) }]
	}
	
}
