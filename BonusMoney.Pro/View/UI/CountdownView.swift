//
//  CountdownView.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 05.05.2023.
//

import SwiftUI

struct CountdownTimerView: View {
    let duration: Int // длительность таймера в миллисекундах
    let text: String
    @State private var timeRemaining: Int // время обратного отсчета в миллисекундах
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect() // публикация таймера каждые 0.01 секунды (10 миллисекунд)

    init(duration: Int, text: String) {
        self.duration = duration
        self.text = text
        self._timeRemaining = State(initialValue: duration)
    }

    var body: some View {
        Text("\(text) \(timeString(time: timeRemaining))")
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 10 // уменьшаем время обратного отсчета на 10 миллисекунд каждый раз
                }
            }
    }

    func timeString(time: Int) -> String {
        let seconds = (time / 1000) % 60
        let minutes = (time / (1000 * 60)) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
