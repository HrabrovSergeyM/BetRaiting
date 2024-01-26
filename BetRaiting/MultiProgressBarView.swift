//
//  MultiProgressBarView.swift
//  BetRaiting
//
//  Created by Sergey Hrabrov on 23.01.2024.
//

import SwiftUI

struct MultiProgressBarView: View {
    var bets: [Int]
    var colors: [Color]
    var spacing: CGFloat = 4
    var logoImage: Image
    
    init(bets: [Int], logoImage: Image) {
        self.bets = bets
        self.colors = [.green, .red, .gray]
        self.logoImage = logoImage
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Выигрыши/проигрыши по букмекерым")
                .bold()
            Spacer()
            HStack(alignment: .bottom, spacing: 16) {
                logoImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
                
                Text(formatBetsCount(bets.reduce(0, +)))
                    .font(.system(size: 16, weight: .medium))
            }
            
            GeometryReader { geometry in
                HStack(spacing: self.spacing) {
                    ForEach(0..<self.bets.count) { index in
                        if self.bets[index] > 0 {
                            VStack(alignment: self.textAlignmentForIndex(index)) {
                                Rectangle()
                                    .frame(width: self.barWidth(index, geometry: geometry), height: 10)
                                    .foregroundColor(self.colors[index])
                                
                                Text("\(self.bets[index]) (\(self.percentageForIndex(index))%)")
                                    .font(.system(size: 12, weight: .medium))
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private func barWidth(_ index: Int, geometry: GeometryProxy) -> CGFloat {
        let totalSpacing = spacing * CGFloat(bets.count - 1)
        let availableWidth = geometry.size.width - totalSpacing
        
        if bets.filter({ $0 > 0 }).count == 1 {
            return availableWidth + totalSpacing
        }
        
        if bets.filter({ $0 > 0 }).count == 2 {
            return availableWidth + totalSpacing / CGFloat(bets.count - 3)
        }
        
        let totalBets = CGFloat(bets.reduce(0, +))
        
        let maxPercentage: CGFloat = 0.7
        let minPercentage: CGFloat = 0.15
        
        var percentage = CGFloat(bets[index]) / totalBets
        
        if percentage > maxPercentage {
            percentage = maxPercentage
        } else if percentage < minPercentage {
            percentage = minPercentage
        }
        
        let maxAllowedPercentage = 1.0 - CGFloat(bets.count - 1) * minPercentage
        percentage = min(percentage, maxAllowedPercentage)
        
        let width = percentage * availableWidth
        
        let minWidth: CGFloat = 45
        return max(width, minWidth)
    }
    
    private func percentageForIndex(_ index: Int) -> Int {
        let percentage = Double(bets[index]) / Double(bets.reduce(0, +)) * 100
        return Int(percentage.rounded())
    }
    
    private func textAlignmentForIndex(_ index: Int) -> HorizontalAlignment {
        switch colors[index] {
        case .green, .red:
            return .leading
        case .gray:
            return .trailing
        default:
            return .center
        }
    }
    
    private func formatBetsCount(_ count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        
        switch lastDigit {
        case 1:
            return "\(count) ставка"
        case 2...4:
            return "\(count) ставки"
        default:
            break
        }
        
        switch lastTwoDigits {
        case 5...20:
            return "\(count) ставок"
        default:
            break
        }
        
        return "\(count) ставок"
    }
}
#Preview {
    VStack {
        MultiProgressBarView(bets: [1, 0, 1], logoImage: Image("bet_logo"))
        MultiProgressBarView(bets: [1, 1, 1], logoImage: Image("bet_logo"))
        MultiProgressBarView(bets: [1, 0, 0], logoImage: Image("bet_logo"))
    }
}
