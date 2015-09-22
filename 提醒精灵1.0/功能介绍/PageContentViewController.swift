//
//  PageContentViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 11/9/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    @IBOutlet weak var headingLabel:UILabel!
    @IBOutlet weak var contentImageView:UIImageView!
    @IBOutlet weak var pageControl:UIPageControl!
    @IBOutlet weak var getStartedButton:UIButton!

    var index : Int = 0
    var heading : String = ""
    var imageFile : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        
        getStartedButton.hidden = (index == 2) ? false : true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        
        let loginViewController = storyboard?.instantiateInitialViewController() as! WRLogInViewController
        
        UIApplication.sharedApplication().delegate!.window!!.rootViewController = loginViewController
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasLaunthed2")
        defaults.synchronize()
        
    }
    

}
