//
//  JobGenerator.swift
//  JobGenerator
//
//  Created by Illya Kyznetsov on 10.07.2023.
//

import Foundation

protocol JobGenerator {
    typealias JobsGenerated = (Array<Element>) -> Void
    
    associatedtype Element: Job
    
    var capacity: Int {get}
    var interval: Int {get}
    
    func generate(generateListener: @escaping JobsGenerated)
}
