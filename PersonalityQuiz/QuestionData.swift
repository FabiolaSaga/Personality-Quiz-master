//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Fabiola Saga on 3/2/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import Foundation

// Models are often simple compared to the other kinds of code we write. But the names we choose are, comparatively, much much more important. And we sometimes don't appreciate how difficult it is to name things well.
// Is "Question" the best name for a thing that contains the question, its variation or kind, and all its possible answers? I'll be honest, I can't think of a better one.
struct Question {
  // "text" feels pretty generic. In this case, it holds the actual question being asked, i.e. "Which season do you prefer?" Maybe we call it "prompt"? Or even "question" (though having a "Question" and "question" will probably lead to confusion).
    var text: String
  // "type" isn't a bad name for this, but it already has a pretty strict meaning in Swift. "kind", "variety", "format", or "mode" might be better descriptors? Also, is this talking about the format of the response or the format of the whole question? I could see arguments in both directions.
    var type: ResponseType
  // Are these answers? Or are they options that may or may not be selected as an answer?
    var answers: [Answer]
    
    init(text: String, type: ResponseType, answers: [Answer]) {
        self.text = text
        self.type = type
        self.answers = answers
    }
}


// See above re: type. This isn't the "type" of the response in the swift sense of "type". This is the mode/variety/format/kind of question being asked.
enum ResponseType {
  // What does single mean here? A "ranged" question also only has a single answer, right? "mutuallyExclusive" might better explain the traits that set this sort of response apart. Though ultimately it seems like we're describing the presentation of the response, not its qualities. So maybe "radioSelection" or "buttonList" is a better choice?
    case single
  // Same arguments here. "independent" might work, but "checkboxSelection"  or "toggleList" is probably more descriptive of the actual purpose.
    case multiple
  // This is the option really suggests we're talking about the presentation of the responses and not their qualities. Both a "ranged" and a "single" response take a list of options and lets the user choose exactly one of them. The only differenc is in their presentation to the user.
    case ranged
}


// Is it an answer? Or is it an option that may become an answer by being chosen?
struct Answer{
  // "text" feels pretty generic. Maybe "description"? Or even "label" or "title"?
    var text: String
  // This feels more like the "value" of the answer than it does its type of answer that it is.
    var type: AnimalType
    
    init( text: String, type: AnimalType) {
        self.text = text
        self.type = type
    }
}


// Not really a type. More a collection values options can have.
// Also, these aren't animals ;-)
enum AnimalType: String {
  // Good use of raw types!
    case lager = "a LAGER"
    case ipa = "an IPA"
    case saison = "a SAISON"
    case stout = "a STOUT"
  
  // "definition" is perfect name for this!
    var definition: String {
        switch self {
        case .lager:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .ipa:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms"
        case .saison:
            return "You love everything that's soft. You are healthy and full of energy."
        case .stout:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
}
