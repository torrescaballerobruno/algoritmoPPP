//
//  ViewController.swift
//  ProyectoPPP
//
//  Created by Bruno Torres on 05/02/20.
//  Copyright © 2020 Bruno Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedCard: UILabel!
    @IBOutlet weak var selectCardBtn: UIButton!
    
    var cardCounter: Int = 0
    
    var tarjetas: [String]?
    var rows: Int = 1
    var columns: Int = 1
    var cont = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settings"{
            let settingsV = segue.destination as! SettingsViewController
            settingsV.viewController = self
        }
    }
    
    @IBAction func settings(_ sender: UIButton) {
        
    }
    
    @IBAction func selectACard(_ sender: UIButton){
        if tarjetas!.count > cardCounter, cardCounter < cont , let card = tarjetas?[cardCounter]{
            cardCounter += 1
            selectedCard.text = card
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (tarjetas?.count) != nil {
            selectedCard.isHidden = false
            selectCardBtn.isHidden = false
            return columns
        }else{
            selectCardBtn.isHidden = true
            selectedCard.isHidden = true
            return 0
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 70)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for:  indexPath) as! CardCellCollectionViewCell
        if let text = tarjetas?[cont]{
            cont += 1
            cell.cardText.text = text
        }
        return cell
    }
    
}
