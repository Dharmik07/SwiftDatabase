//
//  ViewController.swift
//  LatestDatabase
//
//  Created by Mac User5 on 8/30/17.
//  Copyright © 2017 Mac04. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet var tblView: UITableView!
    
    var devices = [Any]()

    func managedObjectContext() -> NSManagedObjectContext
    {
        var context: NSManagedObjectContext? = nil
        let delegate: AppDelegate? = (UIApplication.shared.delegate as? AppDelegate)
        if ((delegate?.perform(#selector(delegate?.managedObjectContext))) != nil)
        {
            context = delegate?.managedObjectContext()
        }
        return context!
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let footerview = UIView (frame:CGRect.zero)
        self.tblView.tableFooterView = footerview
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let managedObjectContext: NSManagedObjectContext? = self.managedObjectContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
        devices = try! managedObjectContext?.fetch(fetchRequest) as! NSMutableArray as! [Any]
        tblView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (devices.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let acell = tableView.dequeueReusableCell(withIdentifier: "cell")as! customecell
        let device = devices[indexPath.row]
        //    Print in label
        acell.lblID.text = (device as AnyObject).value(forKey: "studid") as? String
        acell.lblName.text = (device as AnyObject).value(forKey: "name") as? String

        return acell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
       let context: NSManagedObjectContext? = managedObjectContext()
        if editingStyle == .delete
        {
            context?.delete(devices[indexPath.row] as! NSManagedObject)
        }
        let error: Error? = nil
        if !(((try? context!.save()) != nil))
        {
            print("Can't delete! \(String(describing: error)) \(String(describing: error?.localizedDescription))")
            return
        }
        devices.remove(at: indexPath.row)
        tblView.deleteRows(at: [indexPath], with: .fade)
        self.tblView.reloadData()
    }
    
    @IBAction func Add(_ sender: Any)
    {
        let data = self.storyboard?.instantiateViewController(withIdentifier: "DataShow")as! DataShow
        navigationController?.pushViewController(data, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if (segue.identifier! == "UpdateDevice") {
//            var selectdevice = self.devices![tblView.indexPathForSelectedRow!.row]
//            var destinationVC = segue.destination
//            destinationVC.device = selectdevice
//        }
//    }
}

