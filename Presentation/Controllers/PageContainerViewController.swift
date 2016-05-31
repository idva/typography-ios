//
//  PageContainerViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 15.05.16.
//  Copyright © 2016 RC. All rights reserved.
//


import UIKit

class PageContainerViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var pageControllers = [String]()
    var pageViewController:UIPageViewController!
    var currentIndex = 0
    
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    @IBOutlet weak var contentsCollectionViewTopGesture: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControllers = [
            "FrontPageViewController",
            "ThemeListViewController",
            "TypefaceViewController",
            "PointSizeViewController",
            "FontMetricksViewController",
            "LeadingViewController",
            "ParagraphStyleViewController",
            "KerningViewController",
            "LigaturesViewController",
            "FirstPartResumeViewController",
            "TextKitStackViewController",
            "TextStorageViewController",
            "TextContainerViewController",
            "LayoutManagerViewController",
            "TextKitStackProgrammaticallyViewController",
            "CompareViewController",
            "TextViewInsetsViewController",
            "HyphenationFactorViewController",
            "TextAttachmentViewController",
            "SubclassTextStorageViewController",
            "TextStorageExampleViewController",
            "TextContainerExampleViewController",
            "TextKitFeaturesViewController",
            "LinksViewController",
            "ContactsViewController"
        ]
        
        let firstSlideViewController = viewControllerAtIndex(0)
        
        pageViewController.setViewControllers([firstSlideViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        view.backgroundColor = UIColor.whiteColor()
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor();
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor();
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "PageViewControllerEmbedSegue") {
            pageViewController = segue.destinationViewController as! UIPageViewController;
            pageViewController.delegate = self
            pageViewController.dataSource = self
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let slideViewController = viewController as? SlideViewController
        let index = slideViewController?.slideIndex
        
        if index == nil || index == 0 {
            return nil
        }
        
        currentIndex = index! - 1

        return viewControllerAtIndex(currentIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let slideViewController = viewController as? SlideViewController
        let index = slideViewController?.slideIndex
        
        if index == nil  || index == pageControllers.count - 1 {
            return nil
        }
        
        currentIndex = index! + 1
        
        return viewControllerAtIndex(currentIndex)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController {
        let storyboardId = pageControllers[index]
        let controller = storyboard?.instantiateViewControllerWithIdentifier(storyboardId) as! SlideViewController
        controller.slideIndex = index
        return controller
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageControllers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.contentView.viewWithTag(50)?.removeFromSuperview()

        let cellBounds = cell.contentView.bounds;
        let viewBounds = view.bounds;
        
        let viewController = viewControllerAtIndex(indexPath.row)
        viewController.view.userInteractionEnabled = false
        viewController.view.frame = CGRectMake((cellBounds.size.width - viewBounds.size.width)/2.0,
                                               (cellBounds.size.height - viewBounds.size.height)/2.0,
                                               viewBounds.size.width,
                                               viewBounds.size.height)
        cell.contentView.addSubview(viewController.view)
        let scale = cellBounds.size.height/viewBounds.size.height;
        viewController.view.transform = CGAffineTransformMakeScale(scale, scale)
        viewController.view.tag = 50
        return cell
    }
 
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentIndex = indexPath.row
        let controller = viewControllerAtIndex(indexPath.row)
        pageViewController.setViewControllers([controller],
                                              direction:.Forward,
                                              animated: false,
                                              completion: nil)
        contentsCollectionViewTopGesture.constant = -CGRectGetHeight(contentsCollectionView.frame)
        view.layoutIfNeeded()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let aspect = view.frame.size.width/view.frame.size.height
        return CGSizeMake(collectionView.frame.size.height * aspect, collectionView.frame.size.height)
    }
    
    @IBAction func downSwipeGesture(sender: AnyObject) {
        let indexPath = NSIndexPath(forRow: currentIndex, inSection: 0)
        contentsCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: false)
        contentsCollectionViewTopGesture.constant = 0
        UIView.animateWithDuration(0.35) { 
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func upSwipeGesure(sender: AnyObject) {
        contentsCollectionViewTopGesture.constant = -CGRectGetHeight(contentsCollectionView.frame)
        UIView.animateWithDuration(0.35) {
            self.view.layoutIfNeeded()
        }
    }
}