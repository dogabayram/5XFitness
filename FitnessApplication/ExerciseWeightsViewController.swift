//
//  SecondViewController.swift
//  FitnessApplication
//
//  Created by Doğa Bayram on 8.11.2018.
//  Copyright © 2018 Doğa Bayram. All rights reserved.
//

import UIKit

protocol toTableView  {
    
    func exercises(sets : Int , reps : Int , weights : Int , indexPath : Int)
    
}


class ExerciseWeightsViewController: UIViewController,UIPickerViewDelegate , UIPickerViewDataSource{
   
    var setsArray = [Int]()
    var repsArray = [Int]()
    var weightstArray = [Int]()
    var indexPath = 0
    var delegate :toTableView?
    var rowForSets  = 0
    var rowForReps = 0
    var rowForWeights = 0
    var newSegue = ""
    
    
    var editedSets = Int()
    var editedReps = Int()
    var editedWeights = Int()
    
    
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var weightsLabel: UILabel!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      secondImageView.image = UIImage(named: String(indexPath) + ".jpg")
     
        
        
        
        for set in 1...20 {
            setsArray.append(set)
        }
        for rep in 1...20 {
            repsArray.append(rep)
        }
        for weight in 1...300 {
            weightstArray.append(weight)
        }
        
        setsLabel.text = String(editedSets)
        repsLabel.text = String(editedReps)
        weightsLabel.text = String(editedWeights)
        
        
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        

       // print(setsArray[rowForSets])
       //print(setsArray[row],repsArray[row],weightstArray[row],indexPath)
        
        delegate?.exercises(sets: setsArray[rowForSets], reps: repsArray[rowForReps], weights: weightstArray[rowForWeights], indexPath: indexPath)
        
        if newSegue == "newExercise" {
              let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
              self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        
        } else {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
            
        }
//
//        performSegue(withIdentifier: "toBackToTable", sender: self)
        
        setsLabel.text = "SETS"
        repsLabel.text = "REPS"
        weightsLabel.text = "WEIGHTS"
        
     
//        let main = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let tableView = main.instantiateViewController(withIdentifier: "tabBar" ) as? UITabBarController
//        present(tableView!, animated: true, completion: nil)

//        let vc = self.tabBarController?.navigationController
//        self.show(vc!, sender: self)
   
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let thirdVC: ExerciseTableViewController = storyBoard.instantiateViewController(withIdentifier: "ExerciseTableViewController") as! ExerciseTableViewController
//        storyBoard.instantiateViewController(withIdentifier: "ExerciseTableViewController")
//        thirdVC.setsArray.append("1")
//        thirdVC.exerciseArray.append("1")
//        thirdVC.repititionArray.append("1")
//        thirdVC.weightsArray.append("1")
        
 //       self.present(thirdVC, animated: true, completion: nil)


    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       // var row = pickerView.selectedRow(inComponent: 0)
        
        if component == 0{
            return setsArray.count
        } else if component == 1{
            return repsArray.count
        }else if component == 2{
            return weightstArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
         return String(setsArray[row])
        } else if component == 1{
            return String(repsArray[row])
        }else if component == 2{
            return String(weightstArray[row])
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            self.rowForSets = row
            setsLabel.text = String(setsArray[row])
        } else if component == 1{
            self.rowForReps = row
            repsLabel.text = String(repsArray[row])
        }else if component == 2{
            self.rowForWeights = row
            weightsLabel.text = "\(String(weightstArray[row]))kg"
        
    }

        
    
}
}

