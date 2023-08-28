//
//  HomeViewController.swift
//  task3_app
//
//  Created by Murat Can ASLAN on 29.08.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var setResetButton: UIButton!
    @IBOutlet private weak var playPauseButton: UIButton!
    @IBOutlet private weak var timePicker: UIDatePicker!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playPauseButton.setTitle("Play", for: .normal) // Change button text
        viewModel.requestNotification()
        timePicker.datePickerMode = .countDownTimer
        timePicker.locale = Locale.current
        setBlocks()
    }
    
    private func setBlocks() {
        TimerManager.shared.timerDidFinish = { [weak self] in
            SoundManager.shared.playSound()
        }
        
        TimerManager.shared.timerDidUpdate = { [weak self] time in
            DispatchQueue.main.async {
                self?.timeLabel.text = time
            }
        }
    }
    @IBAction private func didTapPlayPause(_ sender: UIButton) {
        timePicker.isEnabled = TimerManager.shared.isTimerRunning
        playPauseButton.setTitle(TimerManager.shared.isTimerRunning ? "Play" : "Pause", for: .normal)
        TimerManager.shared.isTimerRunning ? TimerManager.shared.pauseTimer() : TimerManager.shared.startTimer(duration: timePicker.countDownDuration)
    }
    
    @IBAction private func didTapSetReset(_ sender: UIButton) {
        TimerManager.shared.resetTimer()
        timePicker.isEnabled = true
        playPauseButton.setTitle("Play", for: .normal) // Change button text
    }
}
