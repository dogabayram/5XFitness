//
//  ExerciseTableViewController.swift
//  FitnessApplication
//
//  Created by Doğa Bayram on 11.11.2018.
//  Copyright © 2018 Doğa Bayram. All rights reserved.
//

import UIKit
import CoreData

class ExerciseTableViewController: UITableViewController{

    
    
    
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    
    
    
    @IBAction func newExerciseButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newExercise", sender: self)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "exerciseCell")
        cell.textLabel?.text = "DOGA"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "editExercise", sender: self)
        
    }


}
