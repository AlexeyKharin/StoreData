
import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
 
    var jsonSerializationToObject: JsonSerializationToObject?
    
    var arrayNames: [String] = []
    
    @IBOutlet weak var tittle: UILabel! {
        didSet {
            tittle.layer.cornerRadius = 8
            tittle.clipsToBounds = true
            tittle.textAlignment = .center
            tittle.backgroundColor = .cyan
        }
    }
    
    @IBOutlet weak var orbitalPeriod: UILabel! {
        didSet {
            orbitalPeriod.layer.cornerRadius = 8
            orbitalPeriod.clipsToBounds = true
            orbitalPeriod.textAlignment = .center
        }
    }
    
    func jsonDecode(){
        guard let url = URL(string: "https://swapi.dev/api/planets/1/") else { return }
        
        NetworkManager.dataTaskJsonDecoder(url: url) { (result) in
            DispatchQueue.main.async {
                self.orbitalPeriod.text = result.orbitalPeriod
                self.namesTatooine(tatooine: result)
            }
        }
    }
    
    func jsonSerialization() {
        NetworkManager.dataTask(url: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!) { (data) in
            if let data = data,
               let dictionary = try? NetworkManager.toObject(json: data) {
                self.jsonSerializationToObject = JsonSerializationToObject(
                    userId: dictionary["userId"] as! Int,
                    id: dictionary["id"] as! Int,
                    title: dictionary["title"] as! String,
                    completed: dictionary["completed"] as! Bool)
                DispatchQueue.main.async {
                    self.tittle.text = self.jsonSerializationToObject?.title
                }
            } else {
                print("Не конвертировал данные")
            }
        }
    }
    
    func namesTatooine(tatooine: Tatooine)  {
        for i in tatooine.residents {
                if let url = URL(string: i) {
                    NetworkManager.dataTask(url: url) { (data) in
                        if let data = data {
                            do {
                                let name = try JSONDecoder().decode(NameResidents.self, from: data)
                                self.arrayNames.append(name.name)
                                print(name)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        } }
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonSerialization()
        jsonDecode()
        tableView.dataSource = self
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
//    MARK: - UITableViewDataSource
extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        let post = arrayNames[indexPath.row]
        cell.textLabel?.text = post
        return cell
    }
}
