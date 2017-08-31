//
//  DataShow.swift
//  LatestDatabase
//
//  Created by Mac User5 on 8/30/17.
//  Copyright © 2017 Mac04. All rights reserved.
//

import UIKit
import CoreData

class DataShow: UIViewController {

    @IBOutlet var studid: UITextField!
    @IBOutlet var studname: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var phoneno: UITextField!
    
    var device: NSManagedObject?

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

        if (device != nil)
        {
            studid.text = (self.device?.value(forKey: "studid") as! String)
            studname.text = (self.device?.value(forKey: "name") as! String)
            city.text = (self.device?.value(forKey: "city") as! String)
            phoneno.text = (self.device?.value(forKey: "phoneno") as! String)
        }
    }

    @IBAction func saveClick(_ sender: Any)
    {
        if (studid.text?.isEqual(""))! && (studname.text?.isEqual(""))! && (city.text?.isEqual(""))! && (phoneno.text?.isEqual(""))!
        {
            let alert = UIAlertView(title: "Notice", message: "Please enter your details", delegate: self as? UIAlertViewDelegate, cancelButtonTitle: "", otherButtonTitles: "Ok")
            alert.show()
        }
        else
        {
            let context = self.managedObjectContext
            if(device != nil)
            {
                device?.setValue(self.studid.text, forKey: "studid")
                device?.setValue(self.studname.text, forKey: "name")
                device?.setValue(self.city.text, forKey: "city")
                device?.setValue(self.phoneno.text, forKey: "phoneno")
            }
            else
            {
                let newdevice: NSManagedObject? = NSEntityDescription.insertNewObject(forEntityName: "Students", into: context())
                newdevice?.setValue(self.studid.text, forKey: "studid")
                newdevice?.setValue(self.studname.text, forKey: "name")
                newdevice?.setValue(self.city.text, forKey: "city")
                newdevice?.setValue(self.phoneno.text, forKey: "phoneno")
            }
            let error: Error? = nil
            if !(((try? context().save()) != nil))
            {
                print("Can't save! \(String(describing: error)) \(String(describing: error?.localizedDescription))")
            }
            self.dismiss(animated: true, completion: { _ in })
            studid.text = nil
            studname.text = nil
            city.text = nil
            phoneno.text = nil
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func clearClick(_ sender: Any)
    {
        studid.text = ""
        studname.text = ""
        city.text = ""
        phoneno.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
