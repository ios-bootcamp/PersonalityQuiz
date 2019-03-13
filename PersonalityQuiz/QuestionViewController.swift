//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by student12 on 3/9/19.
//  Copyright © 2019 pedro. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multiAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    var questionIndex = 0
    
    var questions: [Question] = [
        Question(text: "What word describes your personality?",
                 type: .single,
                 answers: [
                    Answer(text: "Stubborn", type: .daenerys),
                    Answer(text: "Sarcastic", type: .tyrion),
                    Answer(text: "Intimidating", type: .cersei),
                    Answer(text: "Brooding", type: .jon)
            ]),
        Question(text: "Which creature is the most fearsome?",
                 type: .single,
                 answers: [
                    Answer(text: "Dragons", type: .daenerys),
                    Answer(text: "Other people", type: .cersei),
                    Answer(text: "White Walkers", type: .jon),
                    Answer(text: "Wildlings", type: .tyrion)
            ]),
        Question(text: "What role are you are most likely to play in a theater performance?",
                 type: .single,
                 answers: [
                    Answer(text: "The loyal sidekick", type: .jon),
                    Answer(text: "The villain", type: .cersei),
                    Answer(text: "The troublemaker", type: .tyrion),
                    Answer(text: "The leader", type: .daenerys)
            ]),
        Question(text: "If a battle broke out, where would you be?",
                 type: .single,
                 answers: [
                    Answer(text: "Watching from the safety of my house", type: .cersei),
                    Answer(text: "On the front lines", type: .jon),
                    Answer(text: "Flying overhead", type: .daenerys),
                    Answer(text: "Commanding everyone", type: .tyrion)
            ]),
        Question(text: "What is more important family or power?",
                 type: .ranged,
                 answers: [
                    Answer(text: "Family", type: .jon),
                    Answer(text: "Family and Power", type: .daenerys),
                    Answer(text: "Power and Family", type: .tyrion),
                    Answer(text: "Power", type: .cersei)
            ]),
        Question(text: "What would you like the most?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Fun", type: .tyrion),
                    Answer(text: "Family", type: .jon),
                    Answer(text: "Money", type: .cersei),
                    Answer(text: "Status", type: .daenerys)
            ]),
        Question(text: "Do you have a lot of secrets?",
                 type: .single,
                 answers: [
                    Answer(text: "None", type: .jon),
                    Answer(text: "A few", type: .daenerys),
                    Answer(text: "Enough", type: .tyrion),
                    Answer(text: "Too many", type: .cersei)
            ]),
        Question(text: "Are you a nice person?",
                 type: .single,
                 answers: [
                    Answer(text: "Yes", type: .jon),
                    Answer(text: "Mostly", type: .daenerys),
                    Answer(text: "Sometimes", type: .tyrion),
                    Answer(text: "No", type: .cersei)
            ]),
        Question(text: "What personality type(s) would you identify with the most?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Debater - ENTP", type: .tyrion),
                    Answer(text: "Defender - ISFJ", type: .jon),
                    Answer(text: "Executive - ESTJ", type: .cersei),
                    Answer(text: "Advocate - INFJ", type: .daenerys)
            ])
    ]
    
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions.shuffle()
        
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }

}
