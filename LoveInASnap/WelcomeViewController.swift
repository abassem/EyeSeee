//
//  WelcomeViewController.swift
//  EyeSee
//
//  Created by Abdo Assem on 4/29/16.

//

import UIKit

class WelcomeViewController: UIViewController, UIGestureRecognizerDelegate{
  @IBOutlet weak var welcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

      let swipeRightGesture = UISwipeGestureRecognizer(target: self, action:#selector(WelcomeViewController.handleSwipe(_:)))
        swipeRightGesture.direction=UISwipeGestureRecognizerDirection.Right
        self.welcomeLabel.addGestureRecognizer(swipeRightGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action:#selector(WelcomeViewController.handleSwipe(_:)))
        swipeLeftGesture.direction=UISwipeGestureRecognizerDirection.Left
        self.welcomeLabel.addGestureRecognizer(swipeLeftGesture)
      
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action:#selector(WelcomeViewController.handleSwipe(_:)))
        swipeUpGesture.direction=UISwipeGestureRecognizerDirection.Up
        self.welcomeLabel.addGestureRecognizer(swipeUpGesture)
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action:#selector(WelcomeViewController.handleSwipe(_:)))
        swipeDownGesture.direction=UISwipeGestureRecognizerDirection.Down
        self.welcomeLabel.addGestureRecognizer(swipeDownGesture)
        
        
        
        
      self.welcomeLabel.text="Swipe Towards the Right Side to Identify Currency and Downwards to access my Wallet"
      self.welcomeLabel.backgroundColor=UIColor.magentaColor()
    }


    
    func handleSwipe(gestureSent: UIGestureRecognizer){
        if let swipeGesture = gestureSent as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
              print ("Right")
              performSegueWithIdentifier("gotoSnapPhoto", sender: self)
                
            case UISwipeGestureRecognizerDirection.Down:
                print ("Down")
              performSegueWithIdentifier("gotoWallet", sender: self)
            case UISwipeGestureRecognizerDirection.Up:
                print ("Up")
            default:
                break
            }
            
        }
    }
  
  

}
