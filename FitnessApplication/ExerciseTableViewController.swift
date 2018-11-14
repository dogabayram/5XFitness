//
//  ExerciseTableViewController.swift
//  FitnessApplication
//
//  Created by Doğa Bayram on 11.11.2018.
//  Copyright © 2018 Doğa Bayram. All rights reserved.
//

import UIKit
import CoreData

class ExerciseTableViewController: UITableViewController,toTableView,newProtocol{
    
    
    var exerciseArray = [Int]()
    var weightsArray = [Int]()
    var repititionArray = [Int]()
    var setsArray = [Int]()
    var row = 0
   
    
   var exerciseArrayClass = [Exercises]()
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
  
    
    func newPro(sets: Int, reps: Int, weights: Int, indexPath: Int) {
        
        self.exerciseArray.append(indexPath)
        self.weightsArray.append(weights)
        self.repititionArray.append(reps)
        self.setsArray.append(sets)
        print("DOGA BAYRAM")
        print("weight : " + String(weights))
        print(sets)
        print(reps)
        //set = String(sets)
        
    let newExercise = Exercises(context: context)
        newExercise.exerciseNames = Int16(indexPath)
        newExercise.reps = Int32(reps)
        newExercise.sets = Int32(sets)
        newExercise.weights = Int32(weights)
        
        exerciseArrayClass.append(newExercise)
        save()
        
        
        
    self.tableView.reloadData()
        
        
    }
    
    func exercises(sets: Int, reps: Int, weights: Int, indexPath: Int) {
        
//        self.exerciseArrayClass[row].exerciseNames = Int16(indexPath)
//        self.exerciseArrayClass[row].weights = Int32(weights)
//        self.exerciseArrayClass[row].reps = Int32(reps)
//        self.exerciseArrayClass[row].sets = Int32(sets)
//        print("BAYRAM")
        
//        let newExercise = Exercises(context: context)
//        newExercise.exerciseNames = Int16(indexPath)
//        newExercise.reps = Int32(reps)
//        newExercise.sets = Int32(sets)
//        newExercise.weights = Int32(weights)
//
//        exerciseArrayClass[row] = newExercise
        
                self.exerciseArrayClass[row].exerciseNames = Int16(indexPath)
                self.exerciseArrayClass[row].weights = Int32(weights)
                self.exerciseArrayClass[row].reps = Int32(reps)
                self.exerciseArrayClass[row].sets = Int32(sets)
        
        
        
        

        save()
        
        self.tableView.reloadData()
        

        
      //  print(sets)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(filePath)
        
        
       // print(weightsArray)
        
        load()
   
        tableView.reloadData()

       
        
      //  self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "exerciseCell")
    
    }
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func newExerciseButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newExercise", sender: self)
        tableView.reloadData()
        
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exerciseArrayClass.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell") as! TableViewCell
        
        cell.exerciseImage.image = UIImage(named: String(exerciseArrayClass[indexPath.row].exerciseNames) + ".jpg")
        cell.exerciseSets.text = String(exerciseArrayClass[indexPath.row].sets)
        cell.exerciseRep.text = String(exerciseArrayClass[indexPath.row].reps)
        cell.exerciseWeight.text = String(exerciseArrayClass[indexPath.row].weights) + "kg"
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.row = indexPath.row
        performSegue(withIdentifier: "editExercise", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
//            self.exerciseArray.remove(at: indexPath.row)
//            self.weightsArray.remove(at: indexPath.row)
//            self.repititionArray.remove(at: indexPath.row)
//            self.setsArray.remove  (at: indexPath.row),
            context.delete(exerciseArrayClass[indexPath.row])
            exerciseArrayClass.remove(at: indexPath.row)
            save()
            
            
            tableView.reloadData()
        
            }
            
        }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editExercise" {
        let dest = segue.destination as! ExerciseWeightsViewController
        dest.delegate = self
            dest.indexPath = Int(exerciseArrayClass[row].exerciseNames)
        dest.editedSets = Int(exerciseArrayClass[row].sets)
        dest.editedReps = Int(exerciseArrayClass[row].reps)
        dest.editedWeights = Int(exerciseArrayClass[row].weights)
            
            
        } else if segue.identifier == "newExercise" {
            let dest = segue.destination as! ExerciseCollectionViewController
            dest.delegate = self
        
        }
    }
    
    func save() {
        
        do {
           try context.save()
        } catch {
            print("Error")
        }

    }
    
    func load(){
        
        let request : NSFetchRequest<Exercises> = Exercises.fetchRequest()
        do {
        exerciseArrayClass = try context.fetch(request)
        } catch {
            print("Error")
        }
        
    }
    
    
    
    }





