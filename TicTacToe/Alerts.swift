//
//  Alerts.swift
//  List-starter
//
//  Created by Anshika Jain on 18/07/23.
//

import Foundation
import SwiftUI

struct AlertItem:Identifiable{
    let id=UUID()
    let title:String
    let message:String
    let buttonTitle:String
}

struct AlertContext{
    static let player1Win=AlertItem(title: "Player 1 WIN", message: "Play more matches!", buttonTitle: "Rematch")
    static let player2Win=AlertItem(title: "player 2 WIN", message: "Play more matches!", buttonTitle: "Rematch")
    static let draw=AlertItem(title: "DRAW", message: "IT's a draw!", buttonTitle: "Try Again")
}
