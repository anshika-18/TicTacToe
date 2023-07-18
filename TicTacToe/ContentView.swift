
//  Created by Anshika Jain on 18/07/23.
//

import SwiftUI


struct ContentView: View {
    let columns : [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var alertItem:AlertItem?
    @State private var isPlayer1Turn=true
  
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Spacer()
                LazyVGrid(columns: columns,spacing: 5){
                    ForEach(0..<9){ i in
                        ZStack{
                            Circle()
                                .foregroundColor(.red)
                                .opacity(0.5)
                                .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                            Image(systemName: moves[i]? .indicator ?? "")
                                .resizable()
                                .frame(width: 40,height: 40)
                                .foregroundColor(.white)
                        }.onTapGesture {
                            if(isPlayer1Turn)
                            {
                                if(moves[i]==nil){
                                    moves[i]=Move(player: .player1 , boardIndex: i)
                                }
                                if(checkWinCondition(for: .player1, in: moves))
                                {
                                    alertItem=AlertContext.player1Win
                                    return
                                }
                                if(checkForDraw(in: moves)){
                                    alertItem=AlertContext.draw
                                    return
                                }
                                isPlayer1Turn.toggle()
                            }
                            else
                            {
                                if(moves[i]==nil){
                                    moves[i]=Move(player: .player2 , boardIndex: i)
                                }
                                if(checkWinCondition(for: .player2, in: moves))
                                {
                                    alertItem=AlertContext.player2Win
                                    return
                                }
                                if(checkForDraw(in: moves)){
                                    alertItem=AlertContext.draw
                                    return
                                }
                                isPlayer1Turn.toggle()
                            }
                        
                            
                        }
                        
                    }
                }
                Spacer()
            }
            //.disabled(isGameDisabled)
                .padding()
                .alert(item: $alertItem, content: { alertItem in
                    Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: .default(Text(alertItem.buttonTitle),action:{ resetBoard()}))
                })
        }
                       
    }
    func isSquareOccupied(in moves: [Move?],forIndex index:Int)->Bool{
        return moves.contains(where: {$0?.boardIndex==index})
    }
    func checkWinCondition(for player:Player,in moves:[Move?])->Bool{
        let winPatter:Set<Set<Int>>=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        let playerMoves = moves.compactMap{$0}.filter{ $0.player == player}
        let playerPositions=Set(playerMoves.map{ $0.boardIndex})
        for pattern in winPatter where pattern.isSubset(of: playerPositions){
            return true;
        }
        return false;
    }
    func checkForDraw(in moves:[Move?])->Bool{
        return moves.compactMap{$0}.count==9
    }
    func resetBoard(){
        moves=Array(repeating: nil, count: 9)
    }
}

enum Player{
    case player1,player2
}
struct Move{
    let player:Player
    let boardIndex:Int
    var indicator:String{
        return player == .player1 ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


