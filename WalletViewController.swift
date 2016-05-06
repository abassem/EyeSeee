//
//  WalletViewController.swift
//  EyeSee
//
//  Created by Abdo Assem on 4/29/16.

import UIKit

class WalletViewController: UIViewController {

  @IBOutlet weak var walletMainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
let swipeGest = UISwipeGestureRecognizer(target: self, action: #selector(WalletViewController.hanldSwipe(_:)))
      swipeGest.direction = UISwipeGestureRecognizerDirection.Up
      self.walletMainLabel.addGestureRecognizer(swipeGest)

  }

  func hanldSwipe(swiprGest: UIGestureRecognizer){
    if let swipeGesture = swiprGest as? UISwipeGestureRecognizer{
      switch swipeGesture.direction {
      case UISwipeGestureRecognizerDirection.Right:
        print ("Right")
        
      case UISwipeGestureRecognizerDirection.Down:
        print ("Down")
       
      case UISwipeGestureRecognizerDirection.Up:
        print ("Up")
//        self.performSegueWithIdentifier("unWindfromWalletToSnapPhoto", sender: self)

      default:
        break
      }
      
    }
    
  }
  
//  @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
//    
//  {
//    
////    let sourceViewController = sender.sourceViewController
////    
////    // Pull any data from the view controller which initiated the unwind segue.
////    
// }

}
