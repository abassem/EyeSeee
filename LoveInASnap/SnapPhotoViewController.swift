//
//  ViewController.swift

import UIKit
import Foundation
import AVFoundation

class SnapPhotoViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate, UIGestureRecognizerDelegate {
  
  @IBOutlet weak var buttonLabel: UIButton!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var findTextField: UITextField!
  @IBOutlet weak var replaceTextField: UITextField!
  @IBOutlet weak var topMarginConstraint: NSLayoutConstraint!
  
  var activityIndicator:UIActivityIndicatorView!
  var originalTopMargin:CGFloat!
  var audioPlayer: AVAudioPlayer?

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(SnapPhotoViewController.handleSwipe(_:)))
    swipeRight.direction = UISwipeGestureRecognizerDirection.Right
    self.buttonLabel.addGestureRecognizer(swipeRight)
    
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(SnapPhotoViewController.handleSwipe(_:)))
    swipeDown.direction = UISwipeGestureRecognizerDirection.Right
    self.buttonLabel.addGestureRecognizer(swipeDown)
    
  }
  
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    originalTopMargin = topMarginConstraint.constant
  }
  
  
  //UIGesture functions
  
  func handleSwipe(gesture: UIGestureRecognizer) {
    if let myGesture = gesture as? UISwipeGestureRecognizer{
        switch myGesture.direction {
        case UISwipeGestureRecognizerDirection.Left:
        print ("Left")
     
        
        case UISwipeGestureRecognizerDirection.Down:
          performSegueWithIdentifier("fromSnapPhototoWallet", sender: self)
        print ("Down")
          


        
        default:
        break
        }
    }
  }
  
  //audio functions
  

  @IBAction func takePhoto(sender: AnyObject) {
    // 1
    view.endEditing(true)
    moveViewDown()
    if UIImagePickerController.isSourceTypeAvailable(.Camera) {

                                        let imagePicker = UIImagePickerController()
                                        imagePicker.delegate = self
                                        imagePicker.sourceType = .Camera
                                        self.presentViewController(imagePicker,
                                                                   animated: true,
                                                                   completion: nil)
    }
  }
  
  @IBAction func swapText(sender: AnyObject) {
    
  }
  
  @IBAction func sharePoem(sender: AnyObject) {
    // 1
    if textView.text.isEmpty {
      print("please try again")
    }
    else{
      print("we got something here")
    }
  }
  
  func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
    
    var scaledSize = CGSize(width: maxDimension, height: maxDimension)
    var scaleFactor: CGFloat
    
    if image.size.width > image.size.height {
      scaleFactor = image.size.height / image.size.width
      scaledSize.width = maxDimension
      scaledSize.height = scaledSize.width * scaleFactor
    } else {
      scaleFactor = image.size.width / image.size.height
      scaledSize.height = maxDimension
      scaledSize.width = scaledSize.height * scaleFactor
    }
    
    UIGraphicsBeginImageContext(scaledSize)
    image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return scaledImage
  }
  
  func performImageRecognition(image: UIImage) {

    let tesseract = G8Tesseract()
    tesseract.language = "eng"     // 2 ADD Egyptian
    tesseract.engineMode = .TesseractCubeCombined
    tesseract.pageSegmentationMode = .Auto
    tesseract.maximumRecognitionTime = 60.0
    tesseract.image = image.g8_blackAndWhite()
    tesseract.recognize()
    textView.text = tesseract.recognizedText
    textView.editable = true
    removeActivityIndicator()
  }
  
  func addActivityIndicator() {
    activityIndicator = UIActivityIndicatorView(frame: view.bounds)
    activityIndicator.activityIndicatorViewStyle = .WhiteLarge
    activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
    activityIndicator.startAnimating()
    view.addSubview(activityIndicator)
  }
  
  func removeActivityIndicator() {
    activityIndicator.removeFromSuperview()
    activityIndicator = nil
  }
  
  

  
  func moveViewUp() {
    if topMarginConstraint.constant != originalTopMargin {
      return
    }
    
    topMarginConstraint.constant -= 135
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
  }
  
  func moveViewDown() {
    if topMarginConstraint.constant == originalTopMargin {
      return
    }

    topMarginConstraint.constant = originalTopMargin
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })

  }
  
  @IBAction func backgroundTapped(sender: AnyObject) {
    view.endEditing(true)
    moveViewDown()
  }
}

extension SnapPhotoViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(textField: UITextField) {
    moveViewUp()
  }
  
  @IBAction func textFieldEndEditing(sender: AnyObject) {
    view.endEditing(true)
    moveViewDown()
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
    moveViewDown()
  }
}

extension SnapPhotoViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
    let scaledImage = scaleImage(selectedPhoto, maxDimension: 640)
    
    addActivityIndicator()
    
    dismissViewControllerAnimated(true, completion: {
      self.performImageRecognition(scaledImage)
    })
  }

}
