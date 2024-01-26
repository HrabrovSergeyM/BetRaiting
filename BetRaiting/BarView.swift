//
//  BarView.swift
//  BetRaiting
//
//  Created by Sergey Hrabrov on 23.01.2024.
//

import SwiftUI

struct BarView: View {
    var progress: Double
    var outcome: Outcome
    var coefficient: String
    
    enum Outcome {
        case win, loss, refund
    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 200, height: 10)
                    .foregroundColor(.gray.opacity(0.3))
                
                Rectangle()
                    .frame(width: min(200 * CGFloat(progress), 200), height: 10)
                    .foregroundColor(barColor())
            }
            
            Text(outcomeText())
                .fontWeight(.thin)
            
            Spacer()
            
            Text(coefficient)
                .fontWeight(.bold)
        }
        .padding()
    }
    
    func barColor() -> Color {
        switch outcome {
        case .win:
            return .green
        case .loss:
            return .red
        case .refund:
            return .gray
        }
    }
    
    func outcomeText() -> String {
        switch outcome {
        case .win:
            return "Выигрыш"
        case .loss:
            return "Проигрыш"
        case .refund:
            return "Возврат"
        }
    }
}

#Preview {
    VStack {
        BarView(progress: 0.5, outcome: .win, coefficient: "1.94")
        BarView(progress: 0.7, outcome: .loss, coefficient: "2.17")
        BarView(progress: 0.3, outcome: .refund, coefficient: "1.26")
    }
}
