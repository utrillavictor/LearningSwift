//
//  Project18
//
//  Created by Victor Cordero Utrilla on 12/7/16.
//  Copyright © 2016 utrillavictor. All rights reserved.
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("sample message")
        assert(1 == 1, "Maths failure!")
        assert(1 == 2, "Maths failure!") // This will break the app
        for i in 1 ... 100 {
            print("Got number \(i)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

