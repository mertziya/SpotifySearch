# Using node.js as a backend service for IOS App

## Features:

* Node.js api that i was working with was only able to do the REST operations if you are using `JWT Token`. For that reason, the user needs
  to authenticate in the Application either by signing in or signing up. I made a basic LoginService for having the 'JWT Token' to work with
  the main API i want to work with
* 'JWT Token' is stored inside the UserDeffaults with the keyvalue:"Token".
* 'JWT Token' is later used in the Service (searchSongsWith) function that i was working on the service i was working on like below:
  ```swift
  guard let token = UserDefaults.standard.string(forKey: "Token") else{
      completion(.failure(ErrorType.tokenError))
      return
  }
  var request = URLRequest(url: url)
  request.httpMethod = "GET"
  request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
  ```
* The result that is coming from the service which i wanted to work on was coming inside an array. So i needeed to use the DataContainer model
  which add an extra step to the 'GET' request.
* Then, i used the 'searchSongsWith' Service function inside the ViewModel of my app and then i binded the result to my UI by using the `Delegate Patterns` and `async operations`
* Remaining Operations are mostly related with the UI and Communation. If you are currious about the project, you can inspect it by downloading this project into your local repository 


## Demo:
![trim B8A6B29E-E310-4271-85A8-F07B63BFA5AE](https://github.com/user-attachments/assets/6648720b-545c-4c2f-bdea-10d0d9d7d488)

## Credits to:
In order to learn how to write services for the IOS Applications that is working in-tune with the node.js backend
framework, i used [SRS-Project](https://github.com/CS308-Proje/Backend) repository. I worked on this project as part of a team back in university. For this specific IOS App, I mainly used the Spotify Search API, but there’s so much more in this admirable Node.js project.

## How to run the app?

1. Clone the Node.js app into your local directory:
   ```bash
   git clone https://github.com/CS308-Proje/Backend.git
   ```
2. Install the the node dependencies and start the node.js:
   ```bash
   npm install
   npm start
   ```
3. Run the app on XCode Simulator:
4. Run the app on Physical IOS device (optional)
   You can simply use this app on your physical phone by changing the 'localhost' on the RESTfulService folder with you shared IP Adress of you Iphone and Desktop Device
   You can learn your IP Adress on mac by following th steps : `System Settings > Network > Connected wifi > Details`
