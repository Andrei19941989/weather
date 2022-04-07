//
//  ToDosViewController.swift
//  port
//
//  Created by Андрей Orlov on 4/4/22.
//

import UIKit

class ToDosViewController: UIViewController {
    
    @IBOutlet weak var toDosTable: UITableView!
    var todos = [ToDo]()
    
    let userID:Int = 56
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDosTable.delegate = self
        toDosTable.dataSource = self
        fetchData()
    }
    
    
    func fetchData(){
        AlamofireManager.shared.getrequest{ todos in self.todos = todos
            
            self.toDosTable.reloadData()
        }
        
        
    }
    
    @IBAction func addToDoAction(_ sender: UIButton) {
        
        let alert =  UIAlertController(title: "Новая задача", message: "Введите название и описание задачи", preferredStyle: .alert)
        
        alert.addTextField {
            tf in
            tf.placeholder = "Название задачи"
        }
        
        alert.addTextField {
            tf in
            tf.placeholder = "Описание задачи"
        }
        
        let sendAction = UIAlertAction(title: "Отправить", style: .default) {
            _ in
            
            let title = alert.textFields![0].text!
            
            let body = alert.textFields![1].text!
            
            
            let task = ToDo(id: nil, title: title, userId: self.userID, body: body, completed: false)
            
            
            let url = URL(string:"https://jsonplaceholder.typicode.com/posts")
            
            AlamofireManager.shared.sendRequest(to: url!, object: task, httpMethod: .post) { todo in
                print("New task was created. ID:\(todo.id)")
            }
        }
        alert.addAction(sendAction)
        self.present(alert,animated:true)
    }
}

extension ToDosViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for:indexPath)
        
        
        cell.textLabel!.text = todos[indexPath.row].title
        
        
        return cell
    }
    
    
}
