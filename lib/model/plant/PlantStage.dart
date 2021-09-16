import 'package:farm_buddy/model/common/Question.dart';
import 'package:farm_buddy/utils/utility.dart';

class PlantStage{
  String _stageID = "";
  String _stageName = "";
  String _stageStartDate = "";
  bool _completed = false;
  String _dailyWater = "";
  String _stageWater = "";
  int _stageLifeSpan = 0;
  int _stageDayCounter = 0;
 List <Question> _growthQuestionList = [];
  List <Question> _diseaseQuestionList = [];

  PlantStage(
      this._stageID,
      this._stageName,
      this._stageStartDate,
      this._completed,
      this._stageWater,
      this._dailyWater,
      this._stageLifeSpan,
      this._stageDayCounter,
      this._growthQuestionList,
      this._diseaseQuestionList);


  PlantStage.fromJson(Map<String, dynamic> json){
    _stageID = json['stageID'];
    _stageName = json['stageName'];
   // _stageStartDate = Utility.convertTimeStampToDate(json['stageStartDate']);
    _completed = json['completed'];
    _stageWater = json['stageWater'];
    _dailyWater = json['dailyWater'];
    _stageLifeSpan = json['stageLifeSpan'];
    _stageDayCounter = json['stageDayCounter'] == null? 0 : json['stageDayCounter'].toInt();
    _growthQuestionList = jsonListToQuestionList(json['growthQuestionList']);
    _diseaseQuestionList = jsonListToQuestionList(json['diseaseQuestionList']);

  }
  List<Question> jsonListToQuestionList(jsonList){
    List<Question> questionList = [];
    for (var jsonObject in jsonList){
      questionList.add(Question.fromJson(jsonObject));}
    return questionList;
  }

  String get stageName => _stageName;

  set stageName(String value) {
    _stageName = value;
  }

  List<Question> get diseaseQuestionList => _diseaseQuestionList;

  set diseaseQuestionList(List<Question> value) {
    _diseaseQuestionList = value;
  }

  List<Question> get growthQuestionList => _growthQuestionList;

  set growthQuestionList(List<Question> value) {
    _growthQuestionList = value;
  }

  int get stageDayCounter => _stageDayCounter;

  set stageDayCounter(int value) {
    _stageDayCounter = value;
  }

  int get stageLifeSpan => _stageLifeSpan;

  set stageLifeSpan(int value) {
    _stageLifeSpan = value;
  }


  String get stageWater => _stageWater;

  set stageWater(String value) {
    _stageWater = value;
  }

  String get dailyWater => _dailyWater;

  set dailyWater(String value) {
    _dailyWater = value;
  }

  bool get completed => _completed;

  set completed(bool value) {
    _completed = value;
  }

  String get stageStartDate => _stageStartDate;

  set stageStartDate(String value) {
    _stageStartDate = value;
  }

  String get stageID => _stageID;

  set stageID(String value) {
    _stageID = value;
  }
}