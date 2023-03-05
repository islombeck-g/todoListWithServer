# to-doListWithServer
 

This API exposes four endpoints:

- POST /users: Create a new user
- PUT /users/{username}: Update the password of an existing user
- DELETE /users/{username}: Delete an existing user
- GET /users: Get all users

You can run this API using the command `python app.py`. It will start a local web server that listens on port 5000 by default.

In your SwiftUI app, you can make HTTP requests to this API using the URLSession class. Here's an example of how you might make a POST request to create a new user:

```swift
let url = URL(string: "http://localhost:5000/users")!
var request = URLRequest(url: url)
request.httpMethod = "POST"
request.addValue("application/json", forHTTPHeaderField: "Content-Type")

let parameters = ["username": "user3", "password": "password3"]
request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)

URLSession.shared.dataTask(with: request) { data, response, error in
    if let error = error {
        print("Error creating user: \(error)")
        return
    }

    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        print("Error creating user: unexpected response")
        return
    }

    print("User created successfully")
}.resume()
