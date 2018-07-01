//
//  ModalViewController.swift
//  PresentationController
//
//  Created by muukii on 7/1/18.
//  Copyright © 2018 eure. All rights reserved.
//

import UIKit

final class ModalViewController : UIViewController {

  static func makeFromStoryboard() -> ModalViewController {

    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController

    return controller
  }

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var bodyLabel: UILabel!
  @IBOutlet private weak var button: UIButton!

  override var presentationController: UIPresentationController? {
    return super.presentationController
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.transitioningDelegate = self
    self.modalPresentationStyle = .custom
  }

  @IBAction func didTapButton(_ sender: Any) {

    dismiss(animated: true) {
      print("Did complete dismiss")
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    print(self.presentationController)
    print(self.transitionCoordinator)
  }
}

extension ModalViewController : UIViewControllerTransitioningDelegate {

  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {

    return ReachableSheetPresentationController.init(
      presentedViewController: presented,
      presenting: presenting
    )
  }

}

