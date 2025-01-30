# MVVM-Base-Architectur
1. Feature First Folder structure
2. Project Flow :-  NetworkManager/PersistanceManager -> Repository -> Service -> ViewModel -> View
3. Inside Feature Folder --> View - Model - ViewModel - featureService - featureRepository - featureEndpoint
4. Global folders --> Utility - Extensions
5. Functionalities -->
   1.NetworkManager :
     1.  Generic NetworkManager + compatible with all http request
     2. We can add request body + query parameters
     3. Token Manager(if required)
   2.PersistanceManager
     1. UserDefaults to save and retrive data
     2. add flag if needed(for save the data once only)
