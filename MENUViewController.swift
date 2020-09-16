//
//  MENUViewController.swift
//  appCoffe
//
//  Created by Say Dau on 7/23/20.
//  Copyright © 2020 Say Dau. All rights reserved.
//

import UIKit

class MENUViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {


        var mangTen:[monMenu] = []
    var searchData:[monMenu] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tbvMenu: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tbvMenu.delegate = self
        tbvMenu.dataSource = self
        searchBar.delegate = self

        var request = URLRequest(url:URL(string: Config.ServerURL + "/listswift")!)
        
       request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request){data,response,error in
              guard let data = data,
                    let response = response as? HTTPURLResponse,
                error == nil else{
                    print("error")
                    return
            }
            let jsonDecoder = JSONDecoder()
            let ListMenu = try? jsonDecoder.decode(menuList.self, from: data)
                        self.mangTen = ListMenu!.listMenu
            self.searchData = ListMenu!.listMenu

                        DispatchQueue.main.async {
                self.tbvMenu.reloadData()
            }
        }
            task.resume()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
   }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvMenu.dequeueReusableCell(withIdentifier: "CELL") as! DONGTableViewCell
        let queueLoadHinh = DispatchQueue(label: "LoadHinh");
        queueLoadHinh.async {
            let u = URL(string: Config.ServerURL + "/upload/"+self.searchData[indexPath.row].hinhAnh)
            do{
                let d = try Data(contentsOf: u!)
                DispatchQueue.main.async {
                    cell.imgHinh.image = UIImage(data: d)
                }
            }
            catch{}
        }
        cell.imgHinh.image = UIImage(named: searchData[indexPath.row].hinhAnh)
        cell.backgroundColor = #colorLiteral(red: 0.9959741235, green: 0.9445919991, blue: 0.8834062219, alpha: 1)
        cell.lbl.text = searchData[indexPath.row].tenMon
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let man = sb.instantiateViewController(withIdentifier: "Order") as! OrderViewController
        man.hinh = searchData[indexPath.row].hinhAnh
        man.Title = searchData[indexPath.row].tenMon
        man.size = indexPath.row
        man.mangTentt = searchData
        self.navigationController?.pushViewController(man, animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData = []
        if(searchText == "")
        {
            searchData = mangTen
        }
        else
        {
        for ten in mangTen {
            if (ten.tenMon.lowercased().contains(searchText.lowercased()))
            {
                searchData.append(ten)
            }
            
        }
        }
        
        self.tbvMenu.reloadData()
    }
    
       

}
