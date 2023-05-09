//
//  playViewController.swift
//  BlackJack
//
//  Created by Jaiman Gupta on 21/2/2023.
//

import UIKit

class playViewController: UIViewController {

    @IBOutlet weak var joinTableBTN: UIButton!
    
    @IBOutlet weak var myDeck1: UIImageView!
    @IBOutlet weak var myDeck2: UIImageView!
    @IBOutlet weak var myDeck3: UIImageView!
    @IBOutlet weak var myDeck4: UIImageView!
    @IBOutlet weak var myDeck5: UIImageView!
    
    @IBOutlet weak var dealerDeck1: UIImageView!
    @IBOutlet weak var dealerDeck2: UIImageView!
    @IBOutlet weak var dealerDeck3: UIImageView!
    @IBOutlet weak var dealerDeck4: UIImageView!
    @IBOutlet weak var dealerDeck5: UIImageView!
    
    @IBOutlet weak var hitBTN: UIButton!
    @IBOutlet weak var standBTN: UIButton!
    @IBOutlet weak var splitBTN: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var deckTotal: UILabel!
    @IBOutlet weak var dealerDeckTotal: UILabel!
    
    @IBOutlet weak var winCount: UILabel!
    @IBOutlet weak var lossCount: UILabel!
    
    @IBOutlet weak var accountBalance: UILabel!
    
    @IBOutlet weak var bettingLabel: UILabel!
    @IBOutlet weak var bettingAmountInput: UITextField!
    
    @IBOutlet weak var accountBalancefirstLabel: UILabel!
    @IBOutlet weak var accountBalncefirst: UILabel!
    
    
    var gameStarted = false
    
    var canHit = false
    var canStand = false
    
    var currentDeckPos = 0
    var currentDealerDeckPos = 0
    
    var deckTotalnum = 0
    var dealerDeckTotalnum = 0
    
    var wins = 0
    var losses = 0
    
    var bettingAmount = 0
    
    var myDeck = ["000","000","000","000","000"]
    var dealerDeck = ["000","000","000","000","000"]
    
    var allCards = ["c01", "c02", "c03", "c04", "c05", "c06", "c07", "c08", "c09", "c10", "cj10", "cq10", "ck10", "d01", "d02", "d03", "d04", "d05", "d06", "d07", "d08", "d09", "d10", "dj10", "dq10", "dk10", "h01", "h02", "h03", "h04", "h05", "h06", "h07", "h08", "h09", "h10", "hj10", "hq10", "hk10", "s01", "s02", "s03", "s04", "s05", "s06", "s07", "s08", "s09", "s10", "sj10", "sq10", "sk10"]
    
    

    
    func updateDecks(){
        
        myDeck1.image = UIImage(named: myDeck[0])
        myDeck2.image = UIImage(named: myDeck[1])
        myDeck3.image = UIImage(named: myDeck[2])
        myDeck4.image = UIImage(named: myDeck[3])
        myDeck5.image = UIImage(named: myDeck[4])
        
        dealerDeck1.image = UIImage(named: dealerDeck[0])
        dealerDeck2.image = UIImage(named: dealerDeck[1])
        dealerDeck3.image = UIImage(named: dealerDeck[2])
        dealerDeck4.image = UIImage(named: dealerDeck[3])
        dealerDeck5.image = UIImage(named: dealerDeck[4])
        
        dealerDeckTotalnum = 0
    
        for x in dealerDeck{
            dealerDeckTotalnum += Int(x.suffix(2))!
        }
        dealerDeckTotal.text = String(dealerDeckTotalnum)
        
        deckTotalnum = 0
        for x in myDeck{
            deckTotalnum += Int(x.suffix(2))!
        }
        deckTotal.text = String(deckTotalnum)
        
    }
    
    
    func StartGame(){
        
        gameStarted = true
        canHit = true
        canStand = true
        
        myDeck[0] = allCards.randomElement()!
        myDeck[1] = allCards.randomElement()!
        currentDeckPos = 2
        
        dealerDeck[0] = allCards.randomElement()!
        currentDealerDeckPos = 1

        updateDecks()

        accountBalance.text = String(money)
        
        
    }
    
    @IBAction func hitBtn(_ sender: Any) {
        if(canHit && currentDeckPos != 5){
                
            myDeck[currentDeckPos] = allCards.randomElement()!
            updateDecks()
            currentDeckPos+=1
            
            var deckTotalcount = 0

            for x in myDeck{
                deckTotalcount += Int(x.suffix(2))!
            }
           // print(deckTotalcount)
                
            if(deckTotalcount > 21){

                canHit = false
                    
            }
        }
        else {
            let alert = UIAlertController(title: "You cant hit anymore!", message: "Press OK to continue", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func standBtn(_ sender: Any) {
        
        if (canStand && gameStarted == true){
            
            gameStarted = false
            canStand = false
            canHit = false

            var dealerCount = 0
            
            for x in dealerDeck{
                dealerCount += Int(x.suffix(2))!
            }
            
            while(dealerCount < 17){
                
                dealerDeck[currentDealerDeckPos] = allCards.randomElement()!
                updateDecks()
                currentDealerDeckPos+=1
                
                dealerCount = 0

                for x in dealerDeck{
                    dealerCount += Int(x.suffix(2))!
                }
                
            }
            
            dealerCount = 0
        }
        
        if(deckTotalnum < 22 && (deckTotalnum > dealerDeckTotalnum || dealerDeckTotalnum > 21)) {
            //win
            
            let alert = UIAlertController(title: "Congrats, YOU WON! $" + String(bettingAmount) + " has been added to you account.", message: "Press OK to continue", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
            alert.addAction(action)
            present(alert, animated: true)
            
            money += bettingAmount
            
            wins += 1
            winCount.text = String(wins)
            
            accountBalance.text = String(money)
            
        } else {
            //loose
            
            let alert = UIAlertController(title: "Awww, YOU LOST! $" + String(bettingAmount) + " has been deducted from your account.", message: "Press OK to continue", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
                        
            print("ran it")
            
            money -= bettingAmount
            
            losses += 1
            lossCount.text = String(losses)
            
            accountBalance.text = String(money)
            

        }
        
        
        
    }
    
    
    @IBAction func joinTable(_ sender: Any) {
        
        if(Int(bettingAmountInput.text ?? "0") ?? 0 <= 0){
            
            let alert = UIAlertController(title: "Please enter a number higher than 0", message: "Press OK to continue", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
            alert.addAction(action)
            present(alert, animated: true)
            
            
            
        }
        
        else if (Int(bettingAmountInput.text ?? "0")! > money){
            
            let alert = UIAlertController(title: "You dont have that much money in your account!", message: "Press OK to continue", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
        else {
            
            bettingAmount = Int(bettingAmountInput.text ?? "0")!
            
            mainView.isHidden = false
            joinTableBTN.isHidden = true
            bettingAmountInput.isHidden = true
            bettingLabel.isHidden = true
            accountBalncefirst.isHidden = true
            accountBalancefirstLabel.isHidden = true
            
            StartGame()
        }
        
        
    }
   
    @IBAction func Reset(_ sender: Any) {
        
        gameStarted = false
        
        canHit = false
        canStand = false
        
        currentDeckPos = 0
        currentDealerDeckPos = 0
        
        deckTotalnum = 0
        dealerDeckTotalnum = 0
        
        
        bettingAmount = 0
        
        myDeck = ["000","000","000","000","000"]
        dealerDeck = ["000","000","000","000","000"]
        
        updateDecks()
        
        deckTotal.text = "0"
        dealerDeckTotal.text = "0"
        
        mainView.isHidden = true
        
        joinTableBTN.isHidden = false
        bettingAmountInput.isHidden = false
        bettingLabel.isHidden = false
        accountBalncefirst.isHidden = false
        accountBalancefirstLabel.isHidden = false
        
        accountBalncefirst.text = String(money)

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountBalncefirst.text = String(money)
        
        

    
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
