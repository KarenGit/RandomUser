//
//  HTTPClient.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import Foundation

class HTTPClient {
    
    static func getRequest<T: Codable>(endpoint: String, completion: @escaping (Result<T, Error>) -> ()) {
        let session = URLSession.shared
        guard let url = URL(string: endpoint) else { return }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
        urlRequest.httpMethod = "GET"
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "error?.localizedDescription is null")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(T.self, from: data)
                completion(.success(user))
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
