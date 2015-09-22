//
//  PageViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 12/9/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit
//@objc (PageViewController)

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pageHeadings = ["事项提醒,充实每一天", "纪念日,不忘这一天", "计时提醒,做事更加效率"]
    var pageImages = ["page3", "page1", "page2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data source to itself
        dataSource = self
//        view.backgroundColor = []
        // Create the first walkthrough screen
        if let startingViewController = self.viewControllerAtIndex(0) {
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
        
        index++
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
        
        index--
        
        return self.viewControllerAtIndex(index)
    }

    func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        
        if index == NSNotFound || index < 0 || index >= self.pageHeadings.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }

}
