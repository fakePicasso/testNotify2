//
//  SecondaryViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/8/21.
//

import UIKit

class SecondaryViewController: UIViewController
{
    var text:String = ""

    @IBOutlet weak var textLabel:UILabel?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        textLabel?.text = text
    }
}
