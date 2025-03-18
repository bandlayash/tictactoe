//
//  ViewController.swift
//  TicTacToe
//
//  Created by Yash Bandla on 3/16/25.
//

import UIKit

class ViewController: UIViewController
{
    enum Turn
    {
        case circleSymbol
        case crossSymbol
    }
    

    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var crossesScoreCard: UILabel!
    @IBOutlet weak var circlesScoreCard: UILabel!
    @IBOutlet weak var endGameBlur: UIVisualEffectView!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.crossSymbol
    var currentTurn = Turn.crossSymbol
    
    var circle = "O"
    var cross = "X"
    var board = [UIButton]()
    
    var circleScore = 0
    var crossScore = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard()
    {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
        crossesScoreCard.text = String(crossScore)
        circlesScoreCard.text = String(circleScore)
        endGameBlur.alpha = 0.0
    }
    
    @IBAction func boardTapAction(_ sender: UIButton)
    {
        addToBoard(sender)
        
        if checkWin(cross)
        {
            crossScore += 1
            resultAlert(title: "Crosses Win!")
            crossesScoreCard.text = String(crossScore)
        }
        
        if checkWin(circle)
        {
            circleScore += 1
            resultAlert(title: "Circles Win!")
            circlesScoreCard.text = String(circleScore)
        }
        
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
    
    func checkWin(_ s :String) -> Bool
    {
        //Horizontal
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
        {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
        {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        //Vertical
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
        {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        //Diagonal
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
        {
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    
    func resultAlert(title: String) {
        
        // Use tags to easily remove the views later
        endGameBlur.tag = 100
        view.addSubview(endGameBlur)

        // Create a container view for the alert contents
        let alertView = UIView()
        alertView.backgroundColor = UIColor.white
        alertView.layer.cornerRadius = 10
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.tag = 101
        view.addSubview(alertView)
        
        // Center the alertView in the parent view
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 250),
            alertView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // Create and configure the title label to display the result
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(titleLabel)
        
        // Create and configure the reset button
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.addTarget(self, action: #selector(handleResetButton(_:)), for: .touchUpInside)
        alertView.addSubview(resetButton)
        
        // Layout the title label and reset button within the alert view
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            resetButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            resetButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Animate in the blur effect
        UIView.animate(withDuration: 0.3) {
            self.endGameBlur.alpha = 1.0
        }
    }

    @objc func handleResetButton(_ sender: UIButton) {
        // Remove the blur and alert overlay views using their tags
        if let endGameBlur = view.viewWithTag(100) {
            endGameBlur.removeFromSuperview()
        }
        if let alertView = view.viewWithTag(101) {
            alertView.removeFromSuperview()
        }
        // Reset the board as before
        resetBoard()
    }

    func resetBoard()
    {
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(firstTurn == Turn.circleSymbol)
        {
            firstTurn = Turn.crossSymbol
            turnLabel.text = cross
        }
        else if firstTurn == Turn.crossSymbol
        {
            firstTurn = Turn.circleSymbol
            turnLabel.text = circle
        }
        currentTurn = firstTurn
    }
    
    
    func fullBoard() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.circleSymbol)
            {
                sender.setTitle(circle, for: .normal)
                currentTurn = Turn.crossSymbol
                turnLabel.text = cross
            }
            
            else if(currentTurn == Turn.crossSymbol)
            {
                sender.setTitle(cross, for: .normal)
                currentTurn = Turn.circleSymbol
                turnLabel.text = circle
            }
        }
    }
    

}

