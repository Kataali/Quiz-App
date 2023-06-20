import 'question.dart';

// Moving the logic of the quiz to a separate folder away from main.dart(Abstraction)
class QuizLogic{
  // The leading underscore makes properties and methods private so that they can accessed only by the class(Encapsulation)
  int _currentQuestionNumber = 0;

  final List<Question> _questions = [
    Question("Ghana is country in western Africa", true),
    Question("The capital of Ghana is Tamale", false),
    Question("KNUST is a university in Accra", false),
    Question("Ghana was originally known as Gold Coast", true),
    Question("Ghana gained Independence in the year 1958", false),
    Question("The speed of light is 3 times 10 to the 8th power", true),
    Question("There are only two genders", true),
    Question("The bat and the whale are mammals", true),
  ];
  // Get length of questions
  int lengthOfQuestions(){
    return _questions.length;
  }

  // Encapsulation of getting to the next question
  void nextQuestion(){
    if(_currentQuestionNumber < _questions.length - 1){
      _currentQuestionNumber++;
    }
  }

  // Encapsulation of question content
  String getQuestionContent(){
    return _questions[_currentQuestionNumber].questionContent;
  }
  // Encapsulation of the answers
  bool getAnswer(){
    return _questions[_currentQuestionNumber].answer;
  }
  // Check to see if the user has exhausted all our questions
  bool isFinished(){
    if(_currentQuestionNumber == _questions.length - 1){
      return true;
    }
    return false;
  }
  // Method to reset the quiz
  void reset(){
    _currentQuestionNumber = 0;
  }

}