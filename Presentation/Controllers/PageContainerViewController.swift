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
        
        pageViewController.setViewControllers([firstSlideViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        view.backgroundColor = UIColor.white
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray;
        pageControl.currentPageIndicatorTintColor = UIColor.black;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "PageViewControllerEmbedSegue") {
            pageViewController = segue.destination as! UIPageViewController;
            pageViewController.delegate = self
            pageViewController.dataSource = self
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let slideViewController = viewController as? SlideViewController
        let index = slideViewController?.slideIndex
        
        if index == nil || index == 0 {
            return nil
        }
        
        currentIndex = index! - 1

        return viewControllerAtIndex(currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let slideViewController = viewController as? SlideViewController
        let index = slideViewController?.slideIndex
        
        if index == nil  || index == pageControllers.count - 1 {
            return nil
        }
        
        currentIndex = index! + 1
        
        return viewControllerAtIndex(currentIndex)
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController {
        let storyboardId = pageControllers[index]
        let controller = storyboard?.instantiateViewController(withIdentifier: storyboardId) as! SlideViewController
        controller.slideIndex = index
        return controller
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath)
        cell.contentView.viewWithTag(50)?.removeFromSuperview()

        let cellBounds = cell.contentView.bounds;
        let viewBounds = view.bounds;
        
        let viewController = viewControllerAtIndex(indexPath.row)
        viewController.view.isUserInteractionEnabled = false
        viewController.view.frame = CGRect(x: (cellBounds.size.width - viewBounds.size.width)/2.0,
                                               y: (cellBounds.size.height - viewBounds.size.height)/2.0,
                                               width: viewBounds.size.width,
                                               height: viewBounds.size.height)
        cell.contentView.addSubview(viewController.view)
        let scale = cellBounds.size.height/viewBounds.size.height;
        viewController.view.transform = CGAffineTransform(scaleX: scale, y: scale)
        viewController.view.tag = 50
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        let controller = viewControllerAtIndex(indexPath.row)
        pageViewController.setViewControllers([controller],
                                              direction:.forward,
                                              animated: false,
                                              completion: nil)
        contentsCollectionViewTopGesture.constant = -contentsCollectionView.frame.height
        view.layoutIfNeeded()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aspect = view.frame.size.width/view.frame.size.height
        return CGSize(width: collectionView.frame.size.height * aspect, height: collectionView.frame.size.height)
    }
    
    @IBAction func downSwipeGesture(_ sender: AnyObject) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        contentsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        contentsCollectionViewTopGesture.constant = 0
        UIView.animate(withDuration: 0.35, animations: { 
            self.view.layoutIfNeeded()
        }) 
    }
    
    @IBAction func upSwipeGesure(_ sender: AnyObject) {
        contentsCollectionViewTopGesture.constant = -contentsCollectionView.frame.height
        UIView.animate(withDuration: 0.35, animations: {
            self.view.layoutIfNeeded()
        }) 
    }
}
