
class Question{
   String _indexNo = "";
   String _question = "";
   bool _answer = false;

   Question( this._indexNo,  this._question,  this._answer);

   Question.fromJson(var json){
     indexNo = json['_indexNo'];
     question = json['_question'];
     answer = json['_answer'];
   }

   bool get answer => _answer;

  set answer(bool value) {
    _answer = value;
  }

  String get question => _question;

  set question(String value) {
    _question = value;
  }

  String get indexNo => _indexNo;

  set indexNo(String value) {
    _indexNo = value;
  }
}