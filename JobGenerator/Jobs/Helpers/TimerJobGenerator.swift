//
//  TimerJobGenerator.swift
//  JobGenerator
//
//  Created by Illya Kyznetsov on 10.07.2023.
//

import Foundation

class TimerJobGenerator: JobGenerator {
    typealias Element = TimerJob
    typealias TimerJobBuilder = (String, Double) -> Element
    
    let capacity: Int
    let interval: Int
    let timerJobBuilder: TimerJobBuilder
    private var timer: Timer?
    
    init(capacity: Int, interval: Int, timerJobBuilder: @escaping TimerJobBuilder) {
        self.capacity = capacity
        self.interval = interval
        self.timerJobBuilder = timerJobBuilder
    }
    
    func generate(generateListener: @escaping JobsGenerated) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true, block: { [weak self] _ in
            guard let self else { return }
            let jobs = self.generateJobs()
            generateListener(jobs)
        })
    }
    
    private func generateJobs() -> Array<TimerJob> {
        var result: Array<TimerJob> = [];
        for _ in 0...capacity {
            result.append(timerJobBuilder(UUID().uuidString, Double.random(in: 0.1 ..< 5)));
        }
        return result
    }
}
