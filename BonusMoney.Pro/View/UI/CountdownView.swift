//
//  CountdownView.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 05.05.2023.
//

import SwiftUI

struct CountdownTimerView: View {
    let seconds: Int
    let text: String
    @State private var timeRemaining: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(seconds: Int, text: String) {
        self.seconds = seconds
        self.text = text
        self._timeRemaining = State(initialValue: seconds)
    }
    
    var body: some View {
        Text("\(text) \(timeString(time: timeRemaining))")
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
    }
    
    func timeString(time: Int) -> String {
        let minutes = (time / 60) % 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
