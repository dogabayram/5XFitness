//
//  ThirdViewController.swift
//  FitnessApplication
//
//  Created by Doğa Bayram on 10.11.2018.
//  Copyright © 2018 Doğa Bayram. All rights reserved.
//

import UIKit
import CoreData



class ThirdViewController: UIViewController {
    var statsArrayClass = [Stats]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    @IBOutlet weak var armTextField: UITextField!
    @IBOutlet weak var neckTextField: UITextField!
    @IBOutlet weak var chestTextField: UITextField!
    @IBOutlet weak var waistTextField: UITextField!
    @IBOutlet weak var legTextField: UITextField!

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let newStats = Stats(context: context)
        statsArrayClass.append(newStats)
        save()
  
        load()
        
        
        armTextField.text = statsArrayClass[0].arm
        neckTextField.text = statsArrayClass[0].neck
        chestTextField.text = statsArrayClass[0].chest
        waistTextField.text = statsArrayClass[0].waist
        legTextField.text = statsArrayClass[0].leg
        
    }
    
    
    @IBAction func armTextFieldEnd(_ sender: UITextField) {
        
        
       statsArrayClass[0].arm = armTextField.text
        save()
    
        
    }
    
    @IBAction func neckTextFieldEnd(_ sender: UITextField) {
        statsArrayClass[0].neck = neckTextField.text
        save()
        
    }
    @IBAction func chestTextFieldEnd(_ sender: UITextField) {
        statsArrayClass[0].chest = chestTextField.text
        save()
        
    }
    @IBAction func waistTextFieldEnd(_ sender: UITextField) {
        statsArrayClass[0].waist = waistTextField.text
        save()
        
    }
    @IBAction func legTextFieldEnd(_ sender: UITextField) {
        statsArrayClass[0].leg = legTextField.text
        save()
    }
    
    
    
    func save() {
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
        
    }
    
    func load(){
        
        let request : NSFetchRequest<Stats> = Stats.fetchRequest()
        do {
            statsArrayClass = try context.fetch(request)
        } catch {
            print("Error")
        }
        
    }
    


}
