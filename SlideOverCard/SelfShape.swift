//
//  SelfShape.swift
//  SlideOverCard
//
//  Created by Serhii Kyrylenko on 22.03.2020.
//  Copyright © 2020 Opensource. All rights reserved.
//

import SwiftUI

internal struct SelfShape: Shape {
    
    let additionalMargin: CGFloat
    
    public init(additionalMargin: CGFloat = 0) {
        self.additionalMargin = additionalMargin
    }
    
    internal func path(in rect: CGRect) -> Path {
        
        let origin = CGPoint(x: rect.origin.x - additionalMargin, y: rect.origin.y)
        let newRect = CGRect(origin: origin, size: CGSize(width: rect.width + additionalMargin * 2, height: rect.height))
        
        let path = UIBezierPath(rect: newRect)
        return Path(path.cgPath)
    }
}
