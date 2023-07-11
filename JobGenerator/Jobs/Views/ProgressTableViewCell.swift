//
//  ProgressTableViewCell.swift
//  JobGenerator
//
//  Created by Illya Kyznetsov on 10.07.2023.
//

import UIKit

class ProgressTableCell: UITableViewCell {
    static let cellId = "progressCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setJob(_ job: inout Job) {
        titleLabel.text = job.id
        progressView.progress = Float(job.progress)
        job.onTick = { [weak self] progress in
            self?.updateProgress(progress)
        }
    }
    
    func updateProgress(_ progress: Double) {
        progressView.progress = Float(progress)
    }
}
