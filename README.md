# kpm-ios
Application example for consumpition REST Services and offline work app

# Libraries 3RD
  
  ## AFNEtworking
  
  For Request and Response management of REST Services
  
  ## RNCryptor
  
  For encrypt and decrpyt data saved locally 
  
  ## RJImageLoader & SDWebImage
  
  For animation at downloas of image, and set in cahce for UITableView
  
  
# Structure Project


      /Core                       ** Contain all bussiness rules need for work the app
      /Controllers                ** All ViewControllers used for the UI/UX App
      /Models                     ** Contains de Class Model of objects data given by rest services and used to all the app
      /UIControls                 ** Extensions and UIView Customized for a stilized UX/UI
      

# Initialize the project

The project use CocoaPods for the library so before open the project and run at an emulator code

      cd kpm/
      pod install
      

Once installed all libraries just open xcorkspace structure for the project recognize the Pod Files 

      open kpm.xcworkspace
      

Run the app and ejoy it
