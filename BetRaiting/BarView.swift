//
//  BarView.swift
//  BetRaiting
//
//  Created by Sergey Hrabrov on 23.01.2024.
//

import SwiftUI

struct BarView: View {
    var coefficients: [Double]

    enum Outcome {
        case win, loss, refund
    }

    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<coefficients.count) { index in
                BarGraphView(progress: self.calculateProgress(index),
                             outcome: self.outcomeForIndex(index),
                             coefficient: self.coefficients[index])
            }
        }
    }

    func calculateProgress(_ index: Int) -> Double {
        var roundedMinCoefficient = floor(coefficients.min() ?? 0)
        var roundedMaxCoefficient = ceil(coefficients.max() ?? 1)
        
        if coefficients.min() == 0 {
            roundedMinCoefficient = 1
        }
        
        if let maxCoefficient = coefficients.max(), maxCoefficient.rounded(.down) == maxCoefficient {
            roundedMaxCoefficient = roundedMaxCoefficient + 1
        }
        if let minCoefficient = coefficients.min(), minCoefficient.rounded(.down) == minCoefficient {
            roundedMinCoefficient = roundedMinCoefficient - 1
        }

        let widthRange = roundedMaxCoefficient - roundedMinCoefficient
        let normalizedCoefficient = min(max(coefficients[index], roundedMinCoefficient), roundedMaxCoefficient)

        return max((normalizedCoefficient - roundedMinCoefficient) / widthRange, 0)
    }

    func outcomeForIndex(_ index: Int) -> Outcome {
        switch index {
        case 0:
            return .win
        case 1:
            return .loss
        case 2:
            return .refund
        default:
            return .win
        }
    }
}

struct BarGraphView: View {
    var progress: Double
    var outcome: BarView.Outcome
    var coefficient: Double

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 200, height: 10)
                    .foregroundColor(.gray.opacity(0.3))

                Rectangle()
                    .frame(width: calculateWidth(), height: 10)
                    .foregroundColor(barColor())
            }

            Text(outcomeText())
                .fontWeight(.thin)

            Spacer()

            Text(String(coefficient))
                .fontWeight(.bold)
        }
        .padding()
    }

    func calculateWidth() -> CGFloat {
        let maxWidth: CGFloat = 200
        return CGFloat(progress) * maxWidth
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
    BarView(coefficients: [1.94, 2.17, 1.26])
}
