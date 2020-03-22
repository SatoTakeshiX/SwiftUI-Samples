//
//  SlideOverCard.swift
//  HalfModals
//
//  Created by satoutakeshi on 2020/03/20.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct Drawer<SheetContent>: ViewModifier where SheetContent: View {

    @GestureState private var dragState = DragState.inactive
    @State var position = CardPosition.bottom

    var view: () -> SheetContent

    func body(content: Content) -> some View {
        return ZStack {
            content
            sheet()
        }
    }

    // 覆いかぶさる部分
    private func sheet() -> some View {
        let drag = DragGesture()
            .updating($dragState) { (drag, state, transaction) in
                let threshold = CGFloat(-50)
                if !(self.position == .top && drag.translation.height < threshold) {
                    state = .dragging(translation: drag.translation)
                }
        }
        .onEnded(onDragEnded)

        return VStack {
            Handle()
            self.view()
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)
            .background(Color.white)
            .cornerRadius(10.0)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
            .offset(y: self.position.value + self.dragState.translation.height)
            .animation(self.dragState.isDragging ? nil :
                .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
        .gesture(drag)
    }

    private func onDragEnded(drag: DragGesture.Value) {
        //縦の終わる予想y座標からy座標を引く
        let verticalDirection = drag.predictedEndLocation.y - drag.location.y
        // 今の位置足す移動の高さを足すー＞カードの上部位置
        let cardTopEdgeLocation = self.position.value + drag.translation.height
        let positionAbove: CardPosition
        let positionBelow: CardPosition
        let closestPosition: CardPosition


        if cardTopEdgeLocation <= CardPosition.middle.value {
            //cardTopEdgeLocationはmiddle以下
            positionAbove = .top //上がtopで下がmiddle
            positionBelow = .middle
        } else {
            positionAbove = .middle
            positionBelow = .bottom
        }

        if (cardTopEdgeLocation - positionAbove.value) < (positionBelow.value - cardTopEdgeLocation) {
            closestPosition = positionAbove
        } else {
            closestPosition = positionBelow
        }

        //verticalDirectionはマイナスだと下に、プラスだと上に移動したということになる
        //verticalDirectionは強く引っ張ると値が変わる。それほど引っ張らないと0になる。
        if verticalDirection > 0 {
            self.position = positionBelow
        } else if verticalDirection < 0 {//上に移動した
            self.position = positionAbove
        } else {//ゼロだった。強く引っ張られなかった。
            //近いポジション
            self.position = closestPosition
        }
    }
}

enum CardPosition: CGFloat {
    case top
    case middle
    case bottom

    var value: CGFloat {
        let retio: CGFloat
        switch self {
            case .top:
            retio = 1
            case .middle:
            retio = 6
            case .bottom:
            retio = 9
        }
        return UIScreen.main.bounds.height / 10 * retio
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }

    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}
