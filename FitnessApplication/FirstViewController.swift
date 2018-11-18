//
//  FirstViewController.swift
//  FitnessApplication
//
//  Created by Doğa Bayram on 8.11.2018.
//  Copyright © 2018 Doğa Bayram. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    
    
    var hipArray = [Int]()
    let gender = ["Male","Female"]
    var heightArray = [Int]()
    var neckArray = [Int]()
    var waistArray = [Int]()
    var height = Double()
    var neck = Double()
    var waist = Double()
    var hip = Double()
    var name = "Doga" 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    

    @IBOutlet weak var hipLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var neckLabel: UILabel!
    @IBOutlet weak var waistLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var hipPicker: UIPickerView!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var heightPicker: UIPickerView!
    @IBOutlet weak var neckPicker: UIPickerView!
    @IBOutlet weak var waistPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for hip in 70...150 {
            hipArray.append(hip)
        }
        for height in 150...200 {
            heightArray.append(height)
        }
        for neck in 30...60 {
            neckArray.append(neck)
        }
        for waist in 60...120 {
            waistArray.append(waist)
        }
        
        
        
        //let newExercise = Exercises(context: context)
        //newExercise.name = name
        
        do {
        try context.save()
            print("Saved")
        } catch {
            print("Error")
        }
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
     
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == hipPicker {
            return hipArray.count
        } else if pickerView == genderPicker{
            return gender.count
        }else if pickerView == heightPicker{
            return heightArray.count
        }else if pickerView == neckPicker{
            return neckArray.count
        }else if pickerView == waistPicker{
            return waistArray.count
        }
       return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        if pickerView == hipPicker {
            hipLabel.text = String(hipArray[row])
        } else if pickerView == genderPicker{
            genderLabel.text = gender[row]
        }else if pickerView == heightPicker{
            heightLabel.text = "\(String(heightArray[row]))cm"
        }else if pickerView == neckPicker{
            neckLabel.text = "\(String(neckArray[row]))cm"
        }else if pickerView == waistPicker{
            waistLabel.text = "\(String(waistArray[row]))cm"
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == hipPicker {
            hip = Double(hipArray[row])
            return String(hipArray[row])
        } else if pickerView == genderPicker{
            return gender[row]
        }else if pickerView == heightPicker{
            height = Double(heightArray[row])
            return String(heightArray[row])
        }else if pickerView == neckPicker{
            neck = Double(neckArray[row])
            return String(neckArray[row])
        }else if pickerView == waistPicker{
            waist = Double(waistArray[row])
            return String(waistArray[row])
        }
        
        return ""

}
    
    
    @IBAction func calculateButton(_ sender: UIButton) {
        
        
        
        
        
        if genderLabel.text == "Male" {
            
          //  46.892 - (68.678 x Log10(height)) + (76.462 x Log10 (abdominal circumference - neck circumference))
//        let result = 86.010 * log10(waist-neck) - 70.041 * log10(height) + 36.76

            let result = 495 / (1.0324 - 0.19077 * (log10(waist-neck)) + 0.15456 * (log10(height))) - 450
            let newResult = Double(round(1000*result)/1000)
            
            if newResult > 4 {
            
            resultLabel.text = "\(String(newResult))% Body Fat"
            } else {
                resultLabel.text = "Could not find information"

            }
        } else if genderLabel.text == "Female" {
//            -35.601 - (0.515 x height) + (0. 173 x hip circumference) - (1.574 x forearm circumference) - (0.533 x neck circumference) - (0.200 x wrist circumference) + (105.328 x Log10(weight))
            
//            let result = 163.205 * log10(waist+hip-neck) - 97.684 * log10(height) - 78.387
//            let newResult = Double(round(1000*result)/1000)
            
             let result = 495 / (1.29579 - 0.35004 * (log10(waist+hip-neck)) + 0.22100 * (log10(height))) - 450
             let newResult = Double(round(1000*result)/1000)
            if newResult > 4 {
            resultLabel.text = "\(String(newResult))% Body Fat"
            } else {
                resultLabel.text = "Could not find information"
            }
            
        } else {
            resultLabel.text = "Missing inputs"
        }
        
        
        
        
        
    }
    
    
    @IBAction func restartButton(_ sender: UIButton) {
        
        hipLabel.text = "Hip cm"
        genderLabel.text = "Gender"
        heightLabel.text = "Height"
        neckLabel.text = "Neck cm"
        waistLabel.text = "Waist cm"
        resultLabel.text = "Your Body Fat Percentage"
        
        
        
    }
    
}
