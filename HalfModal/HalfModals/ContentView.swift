//
//  ContentView.swift
//  HalfModals
//
//  Created by satoutakeshi on 2020/03/20.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MapView()
            .drawer {
                VStack {
                    Text("Maitland Bay")
                        .font(.headline)
                    Spacer()
                }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
