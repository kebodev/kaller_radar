//
//  ViewController.swift
//  Timeline
//
//  Created by Evan Dekhayser on 7/26/14.
//  Copyright (c) 2014 Evan Dekhayser. All rights reserved.
//

import UIKit

class TineLineViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    //var timeline:   TimelineView!
    var refreshControl: UIRefreshControl!
    var tstFrames = [TimeFrame]()
    var tstFramesRefresh = [TimeFrame]()
    var menuButton = UIButton(frame: CGRectMake(0, 0, 100, 100))
    var goToPostButton : UIButton!
    
    
    
    func postLeft(sender: AnyObject!)
    {
        
        
        println("go to secound view..")
        let secondViewController = PostCreateController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    
    
    
    func wsServiceFeedTst()  {
        println("WS called...")
        println("tstFrames count: " + tstFrames.count.description)
        
        let json = JSON(url:"http://79.172.249.175:7001/RestWebServiceApp/webresources/entity.bkkkallerfeedtst")
        
        //println(json)
        
        var bkkKallerFeedTst = json["bkkKallerFeedTst"]
        var bkkKallerFeedTstArray : [JSON]
        
        
        if bkkKallerFeedTst.isDictionary {
            bkkKallerFeedTstArray = [bkkKallerFeedTst] //initialize
        } else if !bkkKallerFeedTst.isError   {
           
            bkkKallerFeedTstArray = bkkKallerFeedTst.asArray!
            
        }
        else {
            bkkKallerFeedTstArray = []
            
            let dateCurr = NSDate()
            var finalFormatter = NSDateFormatter()
            finalFormatter.dateFormat = "yyyy.MM.dd - HH:mm"
            let finalDate = finalFormatter.stringFromDate(dateCurr)
            
            tstFrames.append(TimeFrame(text: "Sajnos nincs post 5 órája", date: finalDate, image: nil, routeName: "Nincs járat", postId: "0",routType: "0"))
        }
        
        for bkk in bkkKallerFeedTstArray {
            
            let dateShow : NSDate = bkk["feedDate"].asDate!
            var finalFormatter = NSDateFormatter()
            finalFormatter.dateFormat = "yyyy.MM.dd - HH:mm"
            let finalDate = finalFormatter.stringFromDate(dateShow)
            
            tstFrames.append(TimeFrame(text: bkk["feedText"].description, date: finalDate, image: nil, routeName: bkk["feedRouteShName"].description, postId: bkk["id"].description,routType: bkk["feedImgType"].description))
            
        }
        
    }
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
    }
    
    
    func reset(sender: AnyObject) {
        //Animate and get post ITEMS
        var chosedItem = sender.view as UIView
        
        /*chosedItem.transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.animateWithDuration(2.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                chosedItem.transform = CGAffineTransformIdentity
            }, completion: nil)
        */
        
        UIView.animateWithDuration(0.7, animations: {
            
            chosedItem.center.x += self.view.bounds.width - 160
            
        })
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        // if goToPostButton.on == true {
        //   goToPostButton.on = false
        //}
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kaller feed"
        //var tst = UIBarButtonItem()
        //tst.title = "tst"
        //var tst2 = UIBarButtonItem()
        //tst2.title = "tst2"
        //var items = [UIBarButtonItem]()
        //items.append(tst)
        //items.append(tst2)
        //self.navigationItem.setRightBarButtonItem(tst, animated: true)
        //self.navigationItem.setRightBarButtonItems(items, animated: true)
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.17, green:0.30, blue:0.45, alpha:1.0)        
        println("viewDidloadCalled...")
        //let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        //self.view.backgroundColor = UIColor(red:0.18, green:0.62, blue:0.69, alpha:1.0)

        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        var color1 = UIColor(red:0.17, green:0.30, blue:0.45, alpha:1.0)
        var color2 = UIColor(red:0.18, green:0.62, blue:0.69, alpha:1.0)

        gradientLayer.colors = [color1.CGColor, color2.CGColor]
        
        gradientLayer.locations = [0.0, 1.5]
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.scrollEnabled = true
        self.scrollView.alwaysBounceVertical = true
        
        scrollView.delegate = self
        
        
        view.addSubview(scrollView)
        
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 45),
            NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -70)
            ])
        
        
        goToPostButton = UIButton()
        view.addSubview(goToPostButton)
        
        //goToPostButton.on = false
        goToPostButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        goToPostButton.addTarget(self, action: "postLeft:", forControlEvents: .TouchUpInside);
        
        view.addConstraints([
            
            NSLayoutConstraint(item: goToPostButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0),
            //NSLayoutConstraint(item: goToPostButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 65),
            NSLayoutConstraint(item: goToPostButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: goToPostButton, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0)
            ])
        goToPostButton.setImage(UIImage(named: "postbar.png"), forState: UIControlState.Normal)
        
        wsServiceFeedTst()
        addPosts()
        
        
        var logo = UILabel()
        logo.setTranslatesAutoresizingMaskIntoConstraints(false)
        logo.text = "Kaller feed"
        logo.textColor = UIColor.whiteColor()
        view.addSubview(logo)
        
        view.addConstraints([
            
            //NSLayoutConstraint(item: logo, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: logo, attribute: .Bottom, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: logo, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 23),
            NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.CenterX, relatedBy: .Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
            ])
        
        
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Frissítéshez húzzad! :)")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.scrollView.addSubview(refreshControl)
        
    }
    
    
    
    func addPosts() {
        
        
        println("adding post TimeframesCount:")
        println(tstFrames.count)
        let guideView = UIView()
        guideView.setTranslatesAutoresizingMaskIntoConstraints(false)
        guideView.backgroundColor = UIColor.blackColor()
        scrollView.addSubview(guideView)
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(item: guideView, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 3),
            NSLayoutConstraint(item: guideView, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1.0, constant: 3),
            NSLayoutConstraint(item: guideView, attribute: .Right, relatedBy: .Equal, toItem: scrollView, attribute: .Right, multiplier: 1.0, constant: -3),
            NSLayoutConstraint(item: guideView, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: -6),
            NSLayoutConstraint(item: guideView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant:0)
            ])
        guideView.backgroundColor = UIColor.blackColor()
        var viewFromAbove = guideView
        
        
        var counter = 0
        for post in tstFrames {
            
            let v = PostLineItem(labelText: post.text, labelHeader: post.routeName, routType: post.routType, dateLabel: post.date)
            v.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            
            scrollView.addSubview(v)
            
            /*UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
                self.scrollView.addSubview(v)
                v.center = CGPoint(x: 0, y: 40 - 300)
                
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: nil, animations: {
                
                v.center = CGPoint(x: 0, y: 0 + 200)
                
                }, completion: nil)
           */
            NSLayoutConstraint.activateConstraints([
                NSLayoutConstraint(item: v, attribute: .Top, relatedBy: .Equal, toItem: viewFromAbove, attribute: .Bottom, multiplier: 1.0, constant: 3),
                NSLayoutConstraint(item: v, attribute: .Left, relatedBy: .Equal, toItem: viewFromAbove, attribute: .Left, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: v, attribute: .Width, relatedBy: .Equal, toItem: viewFromAbove, attribute: .Width, multiplier: 1.0, constant: 0)
                ])
            
            
            if (counter % 2 == 0) {
                v.backgroundColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0)
                                  v.alpha = 0.7
                v.opaque = true
                var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
                
                visualEffectView.frame = v.bounds
                
                v.addSubview(visualEffectView)

            }
            else {
                v.backgroundColor = UIColor(red:0.88, green:0.90, blue:0.92, alpha:1.0)
                    
                  
                v.alpha = 0.6
                v.opaque = true
                var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
                
                visualEffectView.frame = v.bounds
                
                v.addSubview(visualEffectView)

            }
            
            v.layer.borderWidth = 0.3
            v.layer.borderColor = UIColor.blackColor().CGColor
            v.layer.cornerRadius = 5
            v.layer.masksToBounds = true
            
            
            let cSelector : Selector = "reset:"
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: cSelector)
            rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
            v.addGestureRecognizer(rightSwipe)
            
            viewFromAbove = v
            counter++
        }
        
        
        scrollView.addConstraints([
            NSLayoutConstraint(item: viewFromAbove, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
            ])
        
        scrollView.reloadInputViews()
        
    }
    
    
    
    
    func refresh(sender:AnyObject)
    {
        //remove all subviews from scrollview..
        let subViews = self.scrollView.subviews
        for subview in subViews{
            println("for removing...")
            if (subview is PostLineItem) {
                subview.removeFromSuperview()
            }
            else {
                println("not removing..")
            }
        }

        println("refresh called..")
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        //remove all elements from the array
        tstFrames.removeAll(keepCapacity: false)
        //refresh data from webservice and adding it to tstFrames Array
        wsServiceFeedTst()
        //adding items to the scrollview from tstFramesArray
        addPosts()
        self.refreshControl.endRefreshing()
        
    }
    
    
    
    
    /* override func prefersStatusBarHidden() -> Bool {
    return true
    }
    */
    
    
    
    
    
    
    
    
}

