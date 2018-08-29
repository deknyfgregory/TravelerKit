//
//  TranslateService.swift
//  TravelerKit
//
//  Created by Gregory De knyf on 1/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

class TranslateService {
    
    static let shared = TranslateService()
    private init() {}
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    let apiKey = valueForAPIKey(named: "API_CLIENT_GOOGLE")
    
    func getTranslation(of text: String,to language: String, callback: @escaping (Bool, TranslationDecodable?)-> ()) {
        
        var urlString = "https://translation.googleapis.com/language/translate/v2?q=\(text)&target=\(language)&key=\(apiKey)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else {
            callback(false, nil)
            return
        }
        
        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(TranslationDecodable.self, from: data)
                    callback(true, obj)
                }
                catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    callback(false, nil)
                }
            }
        }
        task?.resume()
    }
}
