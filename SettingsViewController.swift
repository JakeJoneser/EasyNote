//
//  SettingsViewController.swift
//  EasyNotes
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingsListView : UITableView!
    
    var datasource = [Setting]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingsListView.tableFooterView = UIView.init()
        datasource.append(Setting(title: "About", image: UIImage(named: "info")!))
        datasource.append(Setting(title: "Change Password", image: UIImage(named: "password")!))
        datasource.append(Setting(title: "Change Color", image: UIImage(named: "paint")!))
     //   datasource.append(Setting(title: "Notifications", image: UIImage(named: "notifications")!))
        datasource.append(Setting(title: "Refer EasyNote", image: UIImage(named: "link")!))
    }
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingsListView.reloadData()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsCell{
            let setting = datasource[indexPath.row]
            cell.settingsIcon.image = setting.image
            cell.settingsLabel.text = setting.title
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "about", sender: nil)
        }
        if indexPath.row == 1{
            showPasswordView()
        }
        if indexPath.row == 2{
            performSegue(withIdentifier: "showColorPicker", sender: nil)
        }
        if indexPath.row == 3{
            let urlString = "https://github.com/JakeJoneser/EasyNote"
            if let url = URL(string: urlString) {
                UIApplication.shared.open((url), options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                        }
        }
//        if indexPath.row == 4{
//
//        }
    }
    
    func showPasswordView(){
        let nextViewController = NoteManager.shared.getPersonalPasscodeVc()
        NoteManager.shared.changePasswordMode = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func showAbout(){
        
    }

}

class SettingsCell: UITableViewCell {
    @IBOutlet weak var settingsIcon : UIImageView!
    @IBOutlet weak var settingsLabel : UILabel!
}


struct Setting{
    let title : String
    let image : UIImage
}
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
