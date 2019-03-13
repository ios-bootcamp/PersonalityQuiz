//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by student12 on 3/9/19.
//  Copyright © 2019 pedro. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    @IBOutlet weak var gotImage: UIImageView!
    
    var responses: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        calculatePersonalityResult()
    }
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [GotCharacter: Int] = [:]
        
        let responseTypes = responses.map { $0.type }
        
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: { (pair1, pair2) -> Bool in return pair1.value > pair2.value })
        
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        resultAnswerLabel.text = "You are \(mostCommonAnswer.name)"
        resultDefinitionLabel.text = mostCommonAnswer.definition
        gotImage.image = UIImage(named: mostCommonAnswer.name)
    }

}
