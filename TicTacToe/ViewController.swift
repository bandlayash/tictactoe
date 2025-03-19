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
    @IBOutlet weak var winnerAlert: UILabel!
    @IBOutlet weak var resetButton: UIButton!
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
        winnerAlert.alpha = 0.0
        resetButton.alpha = 0.0
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
        
        else if checkWin(circle)
        {
            circleScore += 1
            resultAlert(title: "Circles Win!")
            circlesScoreCard.text = String(circleScore)
        }
        
        else if (fullBoard())
        {
            resultAlert(title: "Draw!")
        }
    }
    
    
    func checkWin(_ s :String) -> Bool
    {
        let winningCombos = [
        [a1, a2, a3], [b1, b2, b3], [c1, c2, c3],
        [a1, b1, c1], [a2, b2, c2], [a3, b3, c3],
        [a1, b2, c3], [c1, b2, a3]
        ]
        
        for combo in winningCombos
        {
            if combo.allSatisfy({ $0!.title(for: .normal) == s })
            {
                return true
            }
        }
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    
    func resultAlert(title: String) {
        
        winnerAlert.text = title
        
        // Animate in the blur effect
        UIView.animate(withDuration: 0.3) {
            self.endGameBlur.alpha = 1.0
            self.winnerAlert.alpha = 1.0
            self.resetButton.alpha = 1.0
        }
    }

    
    @IBAction func resetButtonTapped(_ sender: UIButton)
    {
        endGameBlur.alpha = 0.0
        winnerAlert.alpha = 0.0
        resetButton.alpha = 0.0
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

