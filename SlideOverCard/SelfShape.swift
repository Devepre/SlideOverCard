//
//  SelfShape.swift
//  SlideOverCard
//
//  Created by Serhii Kyrylenko on 22.03.2020.
//  Copyright © 2020 Opensource. All rights reserved.
//

import SwiftUI

internal struct SelfShape: Shape {
    
    internal func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(rect: rect)
        return Path(path.cgPath)
    }
}
