//
//  ExerciseCollectionViewController.swift
//  FitnessApplication
//
//  Created by Doğa Bayram on 11.11.2018.
//  Copyright © 2018 Doğa Bayram. All rights reserved.
//

import UIKit

private let reuseIdentifier = "exerciseType"

protocol newProtocol {
    func newPro(sets: Int, reps: Int, weights: Int, indexPath: Int)
    
}


class ExerciseCollectionViewController: UICollectionViewController,toTableView {
    func exercises(sets: Int, reps: Int, weights: Int, indexPath: Int) {
        delegate?.newPro(sets: sets, reps: reps, weights: weights, indexPath: indexPath)
    }
    

    
    var sets = 0
    var reps = 0
    var weights = 0
    var indexPath = 0
    var newSegueName = "newExercise"
    
    
    let exerciseImageArray = ["1","2","3","4","5","6","7"]
    var newIndexPath = Int()
    var delegate : newProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return exerciseImageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        newIndexPath = indexPath.row
        cell.imageView.image = UIImage(named: exerciseImageArray[indexPath.row] + ".jpg")
        
    
        // Configure the cell
    
        return cell
    }
    
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        newIndexPath = indexPath.row + 1

    performSegue(withIdentifier: "newWeight", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ExerciseWeightsViewController
        //destination.image = UIImage(named: exerciseImageArray[newIndexPath] + ".jpg")
        destination.indexPath = newIndexPath
        destination.newSegue = newSegueName
        destination.delegate = self
    }


}
