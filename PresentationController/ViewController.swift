//
//  ViewController.swift
//  PresentationController
//
//  Created by muukii on 7/1/18.
//  Copyright © 2018 eure. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func didTapPresentButton(_ sender: Any) {

    let controller = ModalViewController.makeFromStoryboard()

    present(controller, animated: true) {
      print("Did complete present")
    }
    
  }
}
