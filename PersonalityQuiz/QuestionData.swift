//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by student12 on 3/9/19.
//  Copyright © 2019 pedro. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: GotCharacter
}

enum GotCharacter {
    case cersei, jon, daenerys, tyrion
    
    var name: String {
        switch self {
        case .cersei:
            return "Cersei Lannister"
        case .jon:
            return "Jon Snow"
        case .daenerys:
            return "Daenerys Targaryen"
        case .tyrion:
            return "Tyrion Lannister"
        }
    }
    
    var definition: String {
        switch self {
        case .cersei:
            return "Cersei is a complex character; she can be cold, conniving and smug. At times she may even make you feel sorry for her. But more often than not, she makes you mad beyond belief."
        case .jon:
            return "Jon is inherently good. He is honorable to a fault, always looking to do what is best, which is the very thing that led to his demise. He is a man of his word who always keeps his promises."
        case .daenerys:
            return "Daenerys has come a long way: from a timid, naïve girl controlled by her brother, to becoming the mother of dragons and breaker of chains. She is strong and knows how to make the tough decisions, and isn’t afraid to ask those around her for help."
        case .tyrion:
            return "Tyrion has been persecuted for the way he looks since his birth. Being a little person, he is constantly being mocked by those around him. People feel that because of his size, he is incompetent and of little use, despite constantly being ridiculed he preservers and proves his usefulness time and time again."
        }
    }
}
