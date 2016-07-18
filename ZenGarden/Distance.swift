//
//  Distance.swift
//  ZenGarden
//
//  Created by Ryan Cohen on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func distanceFromView(view: UIImageView) -> Double {
        return sqrt(pow(Double(view.center.x) - Double(self.center.x), 2) + pow(Double(view.center.y) - Double(self.center.y), 2))
    }
    
    func nearby(view: UIImageView) -> Bool {
        return self.distanceFromView(view) <= 100
    }
}