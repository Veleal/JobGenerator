//
//  JobsPresenter.swift
//  JobGenerator
//
//  Created by Illya Kyznetsov on 10.07.2023.
//

import Foundation

class JobsPresenter {
    typealias ReloadRows = ([Int]) -> Void
    
    private var timerJobGenerator: TimerJobGenerator?
    var jobs: Array<Job?>
    var reloadRows: ReloadRows
    
    private let capacity = 20
    private let interval = 2
    
    init(reloadRows: @escaping ReloadRows) {
        self.reloadRows = reloadRows
        self.jobs = Array(repeating: Optional.none, count: capacity)
        self.prepareGenerator()
    }
    
    func onLoad() {
        generate()
    }
    
    func clearRow(index: Int) {
        jobs[index] = Optional.none
        reloadRows([index])
    }
    
    private func prepareGenerator() {
        timerJobGenerator = TimerJobGenerator(capacity: capacity,
                                              interval: interval,
                                              timerJobBuilder: { id, size in
            return TimerJob(id: id, size: size) { [weak self] in
                guard let self else { return }
                guard let index = self.jobs.firstIndex(where: { $0?.id == id }) else { return }
                self.jobs[index] = nil
                self.reloadRows([index])
            }
        })
    }
    
    private func generate() {
        timerJobGenerator?.generate(generateListener: { [weak self] generatedJobs in
            guard let self else { return }
            var generatedJobs = generatedJobs
            var rowsToUpdate = [Int]();
            for (i, element) in self.jobs.enumerated() {
                if element == nil {
                    self.jobs[i] = generatedJobs.removeFirst()
                    rowsToUpdate.append(i)
                }
            }
            
            self.reloadRows(rowsToUpdate)
            self.startJobs()
        })
    }
    
    private func startJobs() {
        jobs.forEach{$0?.execute()}
    }
}
