
//  ViewController.swift
//  MemeMe
//
//  Created by Khaled Kutbi on 11/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.


import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate{

    //MARK:- Properties
    
    //Outlets
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userEditButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: PhotoTextFields!
    @IBOutlet weak var bottomTextField: PhotoTextFields!
    
    let picker = UIImagePickerController()
    let barButton = UIBarButtonItem()

    var readyMeme : Meme!
    var isEdit = true
    var bottomTextFieldBeginEdite : Bool!
    
    
    enum buttonClicked:Int {case camera = 0 , library}
   

    //MARK:_ Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.runTarget()
        self.delegation()
        self.setupHideKeyboardOnTap()
        //change tinit color of imagePickerController
        UINavigationBar.appearance().tintColor = .orange
      
       
    }
  
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func delegation(){
        // compnent delegate
               self.picker.delegate = self
               self.topTextField.delegate = self
               self.bottomTextField.delegate = self
               
    }
    
    //MARK:_ Actions
    @IBAction func shareAction(_ sender: Any) {
    
        if imageView.image != nil{
        let memedImage = generateMemedImage()
        let activity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activity.completionWithItemsHandler = { activity, success, items, error in
                      self.saveMeme()

                      self.dismiss(animated: true, completion: nil)
            if success {
                self.showALert(title: "Message", message: "Your Picture shared successfully")
            }
                  }
        present(activity, animated: true)
           
        }else{
            showALert(title: "Message", message: "There is nothing to share!")
        }
    }
    
    
    @IBAction func cancelEditeAction(_ sender: Any) {
        if self.imageView.image != nil {
            configurUI()
        isEdit = !isEdit
        }else{
            self.userEditButton.title = "Edit"
            showALert(title: "messgae", message: "You have to pick an image for editing!")
        }
    }
    @IBAction func barItems(_ sender: UIBarButtonItem) {

          switch buttonClicked(rawValue: sender.tag) {
          case .camera:
              self.openCamera()
          case .library:
              self.openGallary()
          default:
              print("nothing happend")
          }
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextFieldBeginEdite {
           view.frame.origin.y -= getKeyboardHeight(notification)
        }
       }
        
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    

    //MARK:- Hndlers
    
    // I corrected this to reusable function and the code become cleaner
    func configurUI(){
        visibleTextFileds(ishidden: isEdit)
        enabledTextFields(isEnabled: !isEdit)
        topTextField.attributedPlaceholder = NSAttributedString(string:"TOP text", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        bottomTextField.attributedPlaceholder = NSAttributedString(string:"Bottom text", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        
            
    }
    func runTarget(){
        #if targetEnvironment(simulator)
                 // Simulator!
        self.cameraButton.isEnabled = false
        #endif
    }
    func saveMeme(){
        
        let memedImage = generateMemedImage()
   
        readyMeme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, orignalImage: imageView.image!, memedImage: memedImage)
        
        
    }
    func enabledTextFields(isEnabled: Bool){
        
        topTextField.isUserInteractionEnabled = !isEnabled
        bottomTextField.isUserInteractionEnabled = !isEnabled
        self.userEditButton.title = isEnabled ? "Edit":"Cancel"
    }
    func visibleTextFileds(ishidden: Bool){
        
        topTextField.isHidden = !ishidden
        bottomTextField.isHidden = !ishidden
    }
    func visablTopBottomBar(isHidden: Bool){
        
        self.navigationController?.navigationBar.isHidden = !isHidden
        self.navigationController?.toolbar.isHidden = !isHidden
        
        
    }
    //MARK: - Combining image and text
    func generateMemedImage() -> UIImage {

        visablTopBottomBar(isHidden: false)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        visablTopBottomBar(isHidden: true)

        return memedImage
    }
    
    //MARK:- TextFields
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        
        if textField == bottomTextField{
            bottomTextFieldBeginEdite = true
        }else{
            bottomTextFieldBeginEdite = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
         textField.resignFirstResponder()
         
        return false
    }
  
    //MARK:- Photo methods
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
              
               picker.sourceType = UIImagePickerController.SourceType.camera
               picker.allowsEditing = false
                
               picker.modalPresentationStyle = .fullScreen
               self.present(picker, animated: true, completion: nil)

               }
        else
        {
          showALert(title: "Message", message: "Your device not support camera")
        }
    }
    func openGallary(){
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }

    //MARK:UIImagePickerControllerDelegate
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         let tempImage:UIImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
              
        imageView.image  = tempImage
        self.topTextField.isHidden = false
        self.bottomTextField.isHidden = false
        self.dismiss(animated: true, completion: nil)
          
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Keyboard
   
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

}

