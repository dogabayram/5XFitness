//
//  ExerciseTableViewController.swift
//  FitnessApplication
//
//  Created by Doğa Bayram on 11.11.2018.
//  Copyright © 2018 Doğa Bayram. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds

class ExerciseTableViewController: UITableViewController,toTableView,newProtocol,GADBannerViewDelegate{
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    var exerciseArray = [Int]()
    var weightsArray = [Int]()
    var repititionArray = [Int]()
    var setsArray = [Int]()
    var row = 0
    var interstitial: GADInterstitial!

   
    
   var exerciseArrayClass = [Exercises]()
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
  
    
    func newPro(sets: Int, reps: Int, weights: Int, indexPath: Int) {
        
        self.exerciseArray.append(indexPath)
        self.weightsArray.append(weights)
        self.repititionArray.append(reps)
        self.setsArray.append(sets)
//        print("DOGA BAYRAM")
//        print("weight : " + String(weights))
//        print(sets)
//        print(reps)
        //set = String(sets)
        
    let newExercise = Exercises(context: context)
        newExercise.exerciseNames = Int16(indexPath)
        newExercise.reps = Int32(reps)
        newExercise.sets = Int32(sets)
        newExercise.weights = Int32(weights)
        
        exerciseArrayClass.append(newExercise)
        save()
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
        
        interstitial = GADInterstitial(adUnitID: "")
        let request = GADRequest()
        interstitial.load(request)
        
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
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
        
        
        interstitial = GADInterstitial(adUnitID: "")
        let request = GADRequest()
        interstitial.load(request)
        
        self.tableView.reloadData()
        

        
      //  print(sets)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
       // let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
       // print(filePath)
        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(ExerciseTableViewController().longPressGestureRecognized(_:)))
        tableView.addGestureRecognizer(longpress)
       // print(weightsArray)
        
        load()
        
        interstitial = GADInterstitial(adUnitID: "")
        let request = GADRequest()
        interstitial.load(request)
        
        

        bannerView.adUnitID = ""
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self


        
   
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
    
    
    
    @objc func longPressGestureRecognized(_ gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: locationInView)
        struct My {
            static var cellSnapshot : UIView? = nil
            static var cellIsAnimating : Bool = false
            static var cellNeedToShow : Bool = false
        }
        struct Path {
            static var initialIndexPath : IndexPath? = nil
        }
        switch state {
        case UIGestureRecognizer.State.began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = tableView.cellForRow(at: indexPath!) as UITableViewCell!
                My.cellSnapshot  = snapshotOfCell(cell!)
                var center = cell?.center
                My.cellSnapshot!.center = center!
                My.cellSnapshot!.alpha = 0.0
                tableView.addSubview(My.cellSnapshot!)
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    center?.y = locationInView.y
                    My.cellIsAnimating = true
                    My.cellSnapshot!.center = center!
                    My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    cell?.alpha = 0.0
                }, completion: { (finished) -> Void in
                    if finished {
                        My.cellIsAnimating = false
                        if My.cellNeedToShow {
                            My.cellNeedToShow = false
                            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                                cell?.alpha = 1
                            })
                        } else {
                            cell?.isHidden = true
                        }
                    }
                })
            }
        case UIGestureRecognizer.State.changed:
            if My.cellSnapshot != nil {
                var center = My.cellSnapshot!.center
                center.y = locationInView.y
                My.cellSnapshot!.center = center
                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                    exerciseArrayClass.insert(exerciseArrayClass.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    tableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                    Path.initialIndexPath = indexPath
                }
            }
        default:
            if Path.initialIndexPath != nil {
                let cell = tableView.cellForRow(at: Path.initialIndexPath!) as! TableViewCell
                if My.cellIsAnimating {
                    My.cellNeedToShow = true
                } else {
                    cell.isHidden = false
                    cell.alpha = 0.0
                }
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = (cell.center)
                    My.cellSnapshot!.transform = CGAffineTransform.identity
                    My.cellSnapshot!.alpha = 0.0
                    cell.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                    }
                })
            }
        }
        save()
    }
    
    func snapshotOfCell(_ inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
            cellSnapshot.layer.shadowRadius = 5.0
            cellSnapshot.layer.shadowOpacity = 0.4
            return cellSnapshot
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
    
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    
    }





