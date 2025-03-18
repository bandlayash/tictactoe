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
    
    
    func resultAlert(title: String)
    {
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
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

