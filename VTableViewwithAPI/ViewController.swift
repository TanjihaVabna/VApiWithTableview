

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //variable
    var modeldata = [MyModel]()
    var titleName = [String]()
    var imageName = [String]()
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
                   let url = URL(string: imageName[indexPath.row])
                   DispatchQueue.global().async {
                       let data = try? Data(contentsOf: url!)
                       DispatchQueue.main.async {
                           cell.img.image = UIImage(data: data!)
                       }
                   }
                 
        
                   return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
          //API
    func loadData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos" )
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if  error == nil {
                
                do{
                    
                    let myData = try! JSONDecoder().decode([MyModel].self, from: data!)
                    
                    //printdata
                    
                    DispatchQueue.main.async {
                        
                        for n in myData {
                            
                           
                            
                            self.imageName.append(n.url)
                        }
                      
                        self.tableView.reloadData()
                        
                    }
                } catch{
                    print(":( Nothing Found")
                }
            }
        } .resume()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
        
    }
}

