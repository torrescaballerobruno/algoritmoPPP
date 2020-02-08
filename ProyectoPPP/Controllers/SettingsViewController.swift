//
//  SettingsViewController.swift
//  ProyectoPPP
//
//  Created by Bruno Torres on 06/02/20.
//  Copyright © 2020 Bruno Torres. All rights reserved.
//

import UIKit
import CryptoKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var keyTF: UITextField!
    @IBOutlet weak var columnasL: UILabel!
    @IBOutlet weak var filasL: UILabel!
    public var viewController: ViewController!
    private var cardGenerator: CardGenerator = CardGenerator()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        columnasL.text = "1"
        filasL.text = "1"
        
        if let key = defaults.string(forKey: "key") {
            keyTF.text = key
        }
    }
    
    @IBAction func keyGenerator(_ sender: UIButton){
        let simkey = SymmetricKey(size: .bits256)
        keyTF.text = simkey.withUnsafeBytes{
           return Data(Array($0)).base64EncodedString()
        }
    }

    @IBAction func aceptar(_ sender: UIButton) {
        if let texto = keyTF.text {
            viewController?.tarjetas = cardGenerator.createCards(key: texto)
            viewController?.rows = Int(filasL.text!)!
            viewController?.columns = Int(columnasL.text!)!
            viewController.collectionView.reloadData()
            viewController.cont = 0
            viewController.cardCounter = 0
            defaults.set(texto, forKey: "key")
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func ColumnasS(_ sender: UIStepper) {
        columnasL.text = Int(sender.value).description
    }

    @IBAction func filasS(_ sender: UIStepper) {
        filasL.text = Int(sender.value).description
    }
}
