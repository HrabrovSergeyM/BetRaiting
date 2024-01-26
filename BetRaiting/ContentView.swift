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
                BarView(progress: 0.4, outcome: .win, coefficient: 1.1)
                BarView(progress: 0.5, outcome: .loss, coefficient: 1.9)
                BarView(progress: 0.1, outcome: .refund, coefficient: 1.0)
                MultiProgressBarView(bets: [11, 5, 6], logoImage: Image("bet_logo"))
                MultiProgressBarView(bets: [16, 11, 5], logoImage: Image("bet_logo"))
                MultiProgressBarView(bets: [35, 5, 6], logoImage: Image("bet_logo"))
                MultiProgressBarView(bets: [98, 1, 1], logoImage: Image("bet_logo"))
                MultiProgressBarView(bets: [1, 1, 1], logoImage: Image("bet_logo"))
                MultiProgressBarView(bets: [1, 0, 0], logoImage: Image("bet_logo"))
                
                    MultiProgressBarView(bets: [1, 0, 1], logoImage: Image("bet_logo"))
                    MultiProgressBarView(bets: [1, 1, 2], logoImage: Image("bet_logo"))
                    
                
                MultiProgressBarView(bets: [0, 0, 0], logoImage: Image("bet_logo"))
            }
        }
    }
}

#Preview {
    ContentView()
}
