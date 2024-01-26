//
//  ContentView.swift
//  BetRaiting
//
//  Created by Sergey Hrabrov on 23.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                BarView(coefficients: [1.94, 2.17, 1.26])
                Divider()
                BarView(coefficients: [1, 2, 3])
                Divider()
                BarView(coefficients: [0.1, 0.2, 0.3])
                Divider()
                MultiProgressBarView(bets: [11, 5, 6], logoImage: Image("bet_logo"))
                Divider()
                MultiProgressBarView(bets: [16, 11, 5], logoImage: Image("bet_logo"))
                Divider()
                MultiProgressBarView(bets: [35, 5, 6], logoImage: Image("bet_logo"))
                Divider()
                MultiProgressBarView(bets: [98, 1, 1], logoImage: Image("bet_logo"))
                Divider()
                MultiProgressBarView(bets: [1, 1, 1], logoImage: Image("bet_logo"))
                Divider()
                MultiProgressBarView(bets: [1, 0, 0], logoImage: Image("bet_logo"))
                Divider()
                MultiProgressBarView(bets: [1, 0, 1], logoImage: Image("bet_logo"))
                Divider()
                MultiProgressBarView(bets: [1, 1, 2], logoImage: Image("bet_logo"))
                Divider()
                MultiProgressBarView(bets: [0, 0, 0], logoImage: Image("bet_logo"))
            }
        }
    }
}

#Preview {
    ContentView()
}
