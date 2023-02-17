//
//  ApiCall.swift
//  testapp
//
//  Created by Mnatsakan Zurnadzhian on 20.01.23.
//

import Foundation

class apiCall {
    func getUsers(url: String, completion:@escaping ([User]) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try! JSONDecoder().decode([User].self, from: data!)
            //print(users)
             
            DispatchQueue.main.async {
                completion(users)
            }
        }
        .resume()
    }
    
    func getPostText(url: String , completion: @escaping (String) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            var postText = try! String(contentsOf: url)
            postText.removeFirst(2)
            postText.removeLast(2)
            
            DispatchQueue.main.async {
                completion(postText)
            }
        }
        .resume()
    }
}
