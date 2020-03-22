//
//  SlideOverCard.swift
//  SlideOverCard
//
//  Created by Serhii Kyrylenko on 22.03.2020.
//  Copyright © 2020 Opensource. All rights reserved.
//

import SwiftUI
import Combine

public struct SlideOverCard<Content: View, HandlerContent: View>: View {
    
    private var cardDefinition: CardDefinition
    
    @Binding private var contentWidth: CGFloat
    @State private var startMovingPoint: CGFloat
    @State private var cardChangingPosition: CardDefinition
    
    private let screenSizePublisher: AnyPublisher<CGSize, Never>
    
    private var content: () -> Content
    private var handlerContent: () -> HandlerContent
    
    public init(cardDefinition: CardDefinition,
                contentWidth: Binding<CGFloat>,
                screenSizePublisher: AnyPublisher<CGSize, Never>,
                handler: @escaping () -> HandlerContent,
                content: @escaping () -> Content) {
        
        self._contentWidth = contentWidth
        self.cardDefinition = cardDefinition
        self.screenSizePublisher = screenSizePublisher
        self._startMovingPoint = State(initialValue: cardDefinition.offsetFromTop())
        self._cardChangingPosition = State(initialValue: cardDefinition)
        
        self.content = content
        self.handlerContent = handler
    }
    
    public var body: some View {
        
        ModifiedContent(
            content: content(),
            modifier: CardModifier(cardDefinition: ObservedObject(initialValue: cardDefinition),
                                   contentWidth: $contentWidth,
                                   screenSizePublisher: screenSizePublisher,
                                   startMovingPoint: startMovingPoint,
                                   handler: handlerContent
            )
        )
    }
    
}
