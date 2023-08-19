//
//  ViewController.swift
//  EsteeLauderTakeFour
//
//  Created by scholar on 8/18/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func startGame(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
}

