//
//  AlamofireManager.swift
//  port
//
//  Created by Андрей Orlov on 4/1/22.
//

import Foundation
import Alamofire
import SwiftyJSON


enum HttpError:Error{
    case badUrl,badresponse,errordecodingData,invalidUrl
}
enum HttpMethod: String{
    case POST, GET, PUT, DELETE
}
enum MIMEType: String{
    case JSONUTF8 = "application/json; charset =UTF-8"
}

enum HttpHeader: String{
    case contentType = "Content-type"
}
class AlamofireManager{
    
    static let shared = AlamofireManager()
    
    let urlString = "https://jsonplaceholder.typicode.com/posts"
    func getrequest(completion:@escaping ([ToDo]) ->()){
        
        guard let url = URL(string: urlString) else {
            print("Bad URL")
            return
        }
        AF.request(url).responseJSON {response in
            switch response.result{
            
            case .success(let data):
                let doDos = ParsingManager.shared.toDosParser(data: data)
                completion(doDos)
                
                
              let json = JSON(data)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
  }
    
    func sendRequest(to url: URL,
                     object:ToDo,
                     httpMethod:HTTPMethod, completion:@escaping  (ToDo) ->()) {
        let params:Parameters = ["title": object.title,"userId":object.userId,
                                   "body": object.body!]
        let headers: HTTPHeaders = []
        AF.request(url,
                   method: .post,
                   parameters: params,
                   headers: headers).responseJSON{response in
            print(response.response)
            
            switch response.result{
                
            case .success(let toDo):
                 let task = ParsingManager.shared.toDoParser(data: toDo)
                completion(task)
                
                
                
                
               // completion(ToDo)
            case .failure(let error):
                print("error bad req")
                print(error.localizedDescription)
            }
        }
                   
        
        
    }
    
}
