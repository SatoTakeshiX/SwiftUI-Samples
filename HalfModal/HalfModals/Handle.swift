//
//  Handle.swift
//  HalfModals
//
//  Created by satoutakeshi on 2020/03/20.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct Handle : View {
    private let handleThickness = CGFloat(5.0)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 40, height: handleThickness)
            .foregroundColor(Color.secondary)
            .padding(5)
    }
}
struct Handle_Previews: PreviewProvider {
    static var previews: some View {
        Handle()
    }
}
