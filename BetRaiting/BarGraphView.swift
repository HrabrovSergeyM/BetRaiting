//
//  BarGraphView.swift
//  BetRaiting
//
//  Created by Sergey Hrabrov on 27.01.2024.
//

import SwiftUI

struct BarGraphView: View {
    var progress: Double
    var outcome: BarView.Outcome
    var coefficient: Double
    
    var body: some View {
        HStack {
            progressBar
            description
           
            Spacer()
            
            coefficientText
        }
        .padding()
    }
    
    
}

extension BarGraphView {
    
    // MARK: - Views
    
    private var progressBar: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: 200, height: 10)
                .foregroundColor(.gray.opacity(0.3))
            
            Rectangle()
                .frame(width: calculateWidth(), height: 10)
                .foregroundColor(barColor())
        }
    }
    
    private var description: some View {
        Text(outcomeText())
            .fontWeight(.thin)
    }
    
    private var coefficientText: some View {
        Text(String(coefficient))
            .fontWeight(.bold)
    }
    
    // MARK: - Functions
    
    private func calculateWidth() -> CGFloat {
        let maxWidth: CGFloat = 200
        return CGFloat(progress) * maxWidth
    }
    
    private func barColor() -> Color {
        switch outcome {
        case .win:
            return .green
        case .loss:
            return .red
        case .refund:
            return .gray
        }
    }
    
    private func outcomeText() -> String {
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
    BarGraphView(progress: 0.1, outcome: .win, coefficient: 0.1)
}
