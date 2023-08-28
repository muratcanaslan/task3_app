//
//  TimerManager.swift
//  task3_app
//
//  Created by Murat Can ASLAN on 29.08.2023.
//

import Foundation

final class TimerManager {
    
    static let shared = TimerManager()
    
    private var timer: Timer?
    var remainingTime: TimeInterval = 0
    var isTimerRunning = false
    var timerDidUpdate: ((String) -> Void)?
    var timerDidFinish: (() -> Void)?
    
    func startTimer(duration: TimeInterval) {
        if !isTimerRunning {
            if remainingTime > 0 {
                startTimerWithRemainingTime()
            } else {
                startTimerWithNewDuration(duration)
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    func resetTimer() {
        pauseTimer()
        timerDidUpdate?("00:00")
        remainingTime = 0
    }
    
    private func startTimerWithRemainingTime() {
        updateTimerLabel()
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func startTimerWithNewDuration(_ duration: TimeInterval) {
        remainingTime = duration
        startTimerWithRemainingTime()
    }
    
    @objc private func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            updateTimerLabel()
        } else {
            pauseTimer()
            timerDidFinish?()
        }
    }
    
    private func updateTimerLabel() {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        timerDidUpdate?(timeString)
    }
}
