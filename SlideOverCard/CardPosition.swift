//
//  CardPosition.swift
//  SlideOverCard
//
//  Created by Serhii Kyrylenko on 22.03.2020.
//  Copyright © 2020 Opensource. All rights reserved.
//

import SwiftUI

public class CardDefinition: ObservableObject {
    
    @Published public var startPosition: CardPosition
    
    public var topOffsetFromTop: CGFloat
    public var middleProportionFromHeight: CGFloat
    public var bottomOffsetFromBottom: CGFloat
    
    public init(startPosition: CardPosition,
                topOffsetFromTop: CGFloat,
                middleProportionFromHeight: CGFloat,
                bottomOffsetFromBottom: CGFloat) {
        
        self.startPosition = startPosition
        self.topOffsetFromTop = topOffsetFromTop
        self.middleProportionFromHeight = middleProportionFromHeight
        self.bottomOffsetFromBottom = bottomOffsetFromBottom
    }
    
    private static var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    func offsetFromTop(forNew height: CGFloat = CardDefinition.screenHeight) -> CGFloat {
        
        Self.screenHeight = height
        
        switch startPosition {
        case .top:
            return topOffsetFromTop
            
        case .middle:
            return middleOffsetFromTop
            
        case .bottom:
            return bottomOffsetFromTop
            
        case .custom(let yPos):
            return yPos
        }
    }
    
    var middleOffsetFromTop: CGFloat {
        Self.screenHeight * middleProportionFromHeight
    }
    
    var bottomOffsetFromTop: CGFloat {
        Self.screenHeight - bottomOffsetFromBottom
    }
    
    func getUpdatedPosition(for newValue: CGFloat, isAboveMiddle: Bool) {
        
        if isAboveMiddle {
            if newValue < deviatinFromMiddleToTop {
                startPosition = .top
            } else {
                startPosition = .middle
            }
        } else {
            if newValue < deviatinFromMiddleToBottom {
                startPosition = .middle
            } else {
                startPosition = .bottom
            }
        }
    }
}

public enum CardPosition {
    
    case top
    case middle
    case bottom
    case custom(yPos: CGFloat)
}

//MARK: - Private
extension CardDefinition {
    
    private var deviatinFromMiddleToTop: CGFloat {
        middleOffsetFromTop - (middleOffsetFromTop - topOffsetFromTop) / 2.5
    }
    
    private var deviatinFromMiddleToBottom: CGFloat {
        middleOffsetFromTop + (bottomOffsetFromTop - middleOffsetFromTop) / 2.5
    }
}
