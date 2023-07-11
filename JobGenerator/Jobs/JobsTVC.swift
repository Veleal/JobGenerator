//
//  JobsTVC.swift
//  JobGenerator
//
//  Created by Illya Kyznetsov on 10.07.2023.
//

import UIKit

class JobsTVC: UITableViewController {
    lazy var presenter = JobsPresenter() { [weak self] rows in
        self?.tableView.reloadRows(at: rows.map{ IndexPath(row: $0, section: 0) }, with: .fade)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.jobs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard var job = presenter.jobs[indexPath.row] else {
            // Reusing BlankTableViewCell instead of creating new instance of UITableViewCell to prevent memmory loss
            return tableView.dequeueReusableCell(withIdentifier: BlankTableViewCell.cellId, for: indexPath) as! BlankTableViewCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgressTableCell.cellId, for: indexPath) as! ProgressTableCell
        
        cell.setJob(&job)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return presenter.jobs[indexPath.row] != nil
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.clearRow(index: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
