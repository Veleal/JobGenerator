//
//  Job.swift
//  JobGenerator
//
//  Created by Illya Kyznetsov on 10.07.2023.
//

import Foundation

protocol Job {
    typealias Finish = () -> Void
    typealias Tick = (Double) -> Void
    
    var id: String { get }
    var size: Double { get }
    var progress: Double { get }
    var onTick: Tick? { get set }
    var onFinish: Finish { get }
    
    func execute()
    func cancel()
}
