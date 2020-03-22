//
//  CardModifier.swift
//  SlideOverCard
//
//  Created by Serhii Kyrylenko on 22.03.2020.
//  Copyright © 2020 Opensource. All rights reserved.
//

import SwiftUI
import Combine

struct CardModifier<HandlerContent: View>: ViewModifier {
    
    @ObservedObject private var cardDefinition: CardDefinition
    @Binding private var contentWidth: CGFloat
    
    @State private var startMovingPoint: CGFloat
    @State private var tweak: Bool = true
    
    private var screenSizePublisher: AnyPublisher<CGSize, Never>
    private let handler: () -> HandlerContent
    
    @State private var finishedDraging: Bool = true
    
    init(cardDefinition: ObservedObject<CardDefinition>,
         contentWidth: Binding<CGFloat>,
         screenSizePublisher: AnyPublisher<CGSize, Never>,
         startMovingPoint: CGFloat,
         handler: @escaping () -> HandlerContent) {
        
        self._cardDefinition = cardDefinition
        self._contentWidth = contentWidth
        self.screenSizePublisher = screenSizePublisher
        self._startMovingPoint = State(initialValue: startMovingPoint)
        self.handler = handler
    }
    
    func body(content: Content) -> some View {
        
        VStack(spacing: 0) {
            handler()
            content
        }
        .frame(width: contentWidth)
        .offset(x: 0, y: cardDefinition.offsetFromTop())
            .clipShape(SelfShape()) // Need to clip in order to apply shadow for all views as one view
            .shadow(color: .init(white: 0.8), radius: 20, x: 0, y: 0)
            .animation(self.finishedDraging ? self.animation : nil)
            .gesture(drag)
            .onReceive(screenSizePublisher) { size in
                self.startMovingPoint = self.cardDefinition.offsetFromTop(forNew: size.height)
        }
        .onReceive(cardDefinition.$startPosition) { _ in
            guard self.finishedDraging else {
                return
            }
            self.startMovingPoint = self.cardDefinition.offsetFromTop()
        }
    }
    
    private var drag: some Gesture {
        
        DragGesture()
            .onChanged {
                self.finishedDraging = false
                let newValue = self.startMovingPoint + $0.translation.height
                self.cardDefinition.startPosition = .custom(yPos: newValue)
        }
        .onEnded {
            self.finishedDraging = true
            let newValue = self.startMovingPoint + $0.translation.height
            self.cardDefinition.startPosition = .custom(yPos: newValue)
            
            let isAboveMiddle = newValue < self.cardDefinition.middleOffsetFromTop // CardPos.middle.offsetFromTop()
            
            self.cardDefinition.getUpdatedPosition(for: newValue, isAboveMiddle: isAboveMiddle)
            self.startMovingPoint = self.cardDefinition.offsetFromTop()
            
            self.tweakUI()
        }
    }
    
    var animation: Animation {
        Animation.default
    }
    
    // Workaround to trigger view body update "silently"
    // otherwise shown navigation bar buttons will not receive touches
    private func tweakUI() {
        
        self.contentWidth = self.tweak ? self.contentWidth + 0.5 : self.contentWidth - 0.5
        self.tweak.toggle()
    }
}
