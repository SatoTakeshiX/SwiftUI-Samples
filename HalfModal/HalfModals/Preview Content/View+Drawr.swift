//
//  View+Drawr.swift
//  HalfModals
//
//  Created by satoutakeshi on 2020/03/21.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

extension View {
    public func drawer<SheetContent: View>(view: @escaping () -> SheetContent) -> some View {
        self.modifier(
            Drawer(view: view)
        )
    }
}
