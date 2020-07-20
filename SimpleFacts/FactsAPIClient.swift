//
//  FactsAPIClient.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

class FactsAPIClient: FactsAPIProtocol {
    func getFacts(completion: @escaping ((Swift.Result<FactsData, FactsAPIError>) -> Void)) {
        let session = URLSession.shared
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=ISO-8859-1", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("text/plain; charset=ISO-8859-1", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            
            if error != nil || data == nil {
                print("Client error!")
                completion(.failure(FactsAPIError.parse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                completion(.failure(FactsAPIError.server))
                return
            }
            
            guard let mime = response.mimeType, mime == "text/plain" else {
                completion(.failure(FactsAPIError.mimeType))
                print("Wrong MIME type!")
                return
            }
            
            do {
                let iso = String.init(data: data!, encoding: .isoLatin1)
                let utf8 = iso?.data(using: .utf8)
                
                
                let json = try JSONSerialization.jsonObject(with: utf8!, options: []) as? [String: Any]
                print("json: ", json as Any)

                let data = try JSONDecoder().decode(FactsData.self, from: utf8!)
                
                print("data: ", data)
                
                completion(.success(data))
            } catch {
                print(error)
                completion(.failure(FactsAPIError.parse))
            }
            
        }.resume()
    }
}
