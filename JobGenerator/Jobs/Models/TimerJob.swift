//
//  TimerJob.swift
//  JobGenerator
//
//  Created by Illya Kyznetsov on 10.07.2023.
//

import Foundation

class TimerJob: Job {
    let id: String
    let size: Double
    let timeInterval: Double
    var progress: Double
    let onFinish: Finish
    var onTick: Tick?
    private var timer: Timer?
    
    init(id: String, size: Double, timeInterval: Double = 0.01, onFinish: @escaping Finish) {
        self.id = id
        self.size = size
        self.timeInterval = timeInterval
        self.progress = 0
        self.onFinish = onFinish
    }
    
    func execute() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timeInterval),
                                     repeats: true,
                                     block: { [weak self] timer in
            guard let self else { return }
            self.progress += self.timeInterval / self.size
            self.onTick?(self.progress)
            if self.progress >= 1 {
                self.cancel()
            }
        })
    }
    
    func cancel() {
        timer?.invalidate()
        onFinish()
    }
}
