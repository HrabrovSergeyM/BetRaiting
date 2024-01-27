//
//  BarView.swift
//  BetRaiting
//
//  Created by Sergey Hrabrov on 23.01.2024.
//

import SwiftUI

struct BarView: View {
    var stackSpacing: CGFloat = 8
    
    var coefficients: [Double]

    enum Outcome {
        case win, loss, refund
    }

    var body: some View {
        VStack(spacing: stackSpacing) {
            ForEach(0..<coefficients.count) { index in
                BarGraphView(progress: self.calculateProgress(index),
                             outcome: self.outcomeForIndex(index),
                             coefficient: self.coefficients[index])
            }
        }
    }

  
}

extension BarView {
    
    // MARK: - Functions
    
    private func calculateProgress(_ index: Int) -> Double {
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

    private func outcomeForIndex(_ index: Int) -> Outcome {
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



#Preview {
    BarView(coefficients: [1.94, 2.17, 1.26])
}
