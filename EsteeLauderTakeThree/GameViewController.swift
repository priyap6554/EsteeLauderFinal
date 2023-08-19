//
//  GameViewController.swift
//  EsteeLauderTakeThree
//
//  Created by scholar on 8/18/23.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var gameModels = [Question]()
    
    var currentQuestion: Question?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestions()
        
        configureUI(question: gameModels.first!)

        // Do any additional setup after loading the view.
    }
    
    private func configureUI(question: Question) {
        label.text = question.text
        currentQuestion = question
        table.delegate = self
        table.dataSource = self
        
    }
    
    private func checkAnswer(answers: Answers, question: Question) -> Bool{
        return question.answers.contains(where: {$0.text == answers.text}) && answers.correct == true
        
    }
    
    
    private func setupQuestions() {
        gameModels.append(Question(text: "What is your main skin care goal?", answers: [
            Answers(text: "hydration", correct: true),
            Answers(text: "pore minimization", correct: true),
            Answers(text: "glow", correct: true),
            Answers(text: "none of the above", correct: false)]))
        
        gameModels.append(Question(text: "Are you passionate about the latest trends in skincare?", answers: [
            Answers(text: "yes", correct: true),
            Answers(text: "no", correct: false)]))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "null", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return

        }
        
        let answer = question.answers[indexPath.row]
                
        if checkAnswer(answers: answer, question: question) {
            if let index  = gameModels.firstIndex(where: {$0.text == question.text}) {
                if index < (gameModels.count - 1) {
                    let nextQuestion = gameModels[index+1]
                    configureUI(question:nextQuestion)
                    table.reloadData()
                } else {
                    let alert = UIAlertController(title: "Completed", message: "It seems like the Nutritious line is right for you!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Explore now!", style: .cancel, handler: nil))
                    present(alert, animated: true)
                }
            }
        }
        
    }
    

    

}

struct Question {
    let text : String
    let answers: [Answers]
}

struct Answers {
    let text : String
    let correct : Bool
}
