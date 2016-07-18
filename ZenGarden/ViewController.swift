//
//  ViewController.swift
//  ZenGarden
//
//  Created by Flatiron School on 6/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    enum Item: Int {
        case Rake = 1
        case Sword
        case Rock
        case Bush
    }
    
    @IBOutlet var gardenItems: [UIImageView]!
    
    var matches: [Bool] = []
    let moveItem: Selector = #selector(ViewController.moveItem(_:))
    
    func moveItem(gestureRecognizer: UIPanGestureRecognizer) {
        if (gestureRecognizer.state == .Began || gestureRecognizer.state == .Changed) {
            let translation = gestureRecognizer.translationInView(view)
            let newCenter = CGPointMake(gestureRecognizer.view!.center.x + translation.x, gestureRecognizer.view!.center.y + translation.y)
            
            gestureRecognizer.view!.center = newCenter
            gestureRecognizer.setTranslation(CGPointMake(0, 0), inView: view)
            
            if let image = gestureRecognizer.view {
                checkPosition(image as! UIImageView)
            }
        }
    }
    
    func checkPosition(image: UIImageView) {
        let currentItem = Item.init(rawValue: image.tag)
        
        if (currentItem == .Sword) {
            if (image.center.y < 300 && image.center.x < 130 ||
                image.center.y > 300 && image.center.x < 130) {
                
                matches[0] = true
            } else {
                matches[0] = false
            }
        }
        
        else if (currentItem == .Rake) {
            if (image.nearby(gardenItems[3])) {
                matches[1] = true
                matches[2] = true
            } else {
                matches[1] = false
                matches[2] = false
            }
        }
        
        else if (currentItem == .Rock) {
            if (gardenItems[1].center.y < 300) {
                if (image.center.y > 300 && image.center.x < 130) {
                    matches[3] = true
                } else {
                    matches[3] = false
                }
                
            } else {
                if (image.center.y < 300 && image.center.x < 130) {
                    matches[3] = true
                } else {
                    matches[3] = false
                }
            }
        }
        
        for i in 1...matches.count {
            if (matches[i-1].boolValue == false) {
                break
            }
            
            if (i == matches.endIndex.predecessor()) {
                let alertController = UIAlertController(title: "ZenGarden", message: "You won the zen garden!", preferredStyle: .Alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                    
                    self.scatterItems()
                }
                
                alertController.addAction(dismissAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func scatterItems() {
        matches.removeAll()
        
        for item in gardenItems {
            let randomX = Int(arc4random_uniform(UInt32(self.view.frame.size.width)))
            let randomY = Int(arc4random_uniform(UInt32(self.view.frame.size.height)))
            
            item.center = CGPointMake(CGFloat(randomX), CGFloat(randomY))
        }
        
        for _ in 1...4 {
            matches.append(false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in gardenItems {
            let recognizer = UIPanGestureRecognizer(target: self, action: moveItem)
            recognizer.delegate = self
            item.addGestureRecognizer(recognizer)
        }
        
        for _ in 1...4 {
            matches.append(false)
        }
    }
}