//
//  ViewController.swift
//  PersonalityQuiz
//
//  Created by Fabiola Saga on 2/28/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import UIKit
import FirebaseAuth


// This controller has a lot of segues on the storyboard. The “login” and “sign up” ones may have been duplicated?
class StartViewController: UIViewController {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
      // We might consider abstracting firebase behind a more general interface.
      
      // Also, having `Auth` sprinkled throughout our code means we're treating it as a singleton. This might not be avoidable given the cross-cutting nature of authentication. But it makes the code less isolated and more difficult to test.
        if Auth.auth().currentUser != nil {
          //Rather than putting this logic in the root controller of the nav, we could put it in the nav controller itself? That way we wouldn't be segueing to the "logged in" controller. We'd just start there.
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    


}

