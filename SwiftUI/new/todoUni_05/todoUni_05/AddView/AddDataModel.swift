
import Foundation


class AddDataModel:ObservableObject{
    @Published var userSetting:userSettings
    init(user:userSettings){
        self.userSetting = user
    }
    func addItemToData(me: userData, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "\(link)/add_data"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "com.yourapp", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(me) else {
            print("Failed to encode user data")
            completion(.failure(NSError(domain: "com.yourapp", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to encode user data"])))
            return
        }
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("Invalid response or no data received")
                completion(.failure(NSError(domain: "com.yourapp", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid response or no data received"])))
                return
            }
            if response.statusCode == 200 {
                completion(.success("Data added successfully"))
            } else if response.statusCode == 401 {
                completion(.failure(NSError(domain: "com.yourapp", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid username or password"])))
            } else {
                completion(.failure(NSError(domain: "com.yourapp", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Error adding data"])))
            }
        }
        task.resume()
    }
}
