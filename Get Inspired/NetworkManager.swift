//
//  NetworkManager.swift
//  Get Inspired
//
//  Created by Darragh Blake on 21/01/2020.
//  Copyright © 2020 Darragh Blake. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://quotes.rest/"
    
    func getQuoteOfTheDay(completed: @escaping(QuoteOfTheDay?, String?) -> Void) {
        let endpoint = baseUrl + "qod.json"
        
        guard let url = URL(string: endpoint) else {
            print("Failed to complete requested task.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(nil, "An error was returned.")
                return
            }
            
            // Checking to see if the Response code is 200 (Success)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server.")
                return
            }
            
            // Checking that there is data in the payload returned
            guard let data = data else {
                completed(nil, "The Data is empty.")
                return
            }
            
            // Gather the data returned and assigning it to the quoteOfTheDay object
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let quoteOfTheDay = try decoder.decode(QuoteOfTheDay.self, from: data)
                completed(quoteOfTheDay, nil)
            } catch {
                completed(nil, "The Data is empty. 2")
            }
        }
        
        task.resume()
    }
}
