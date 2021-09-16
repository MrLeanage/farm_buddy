class Prediction{
  String _duration = "";
  String _averageRainfall = "";
  String _predictionInfo = "";
  double _wateringLevel = 0;
  bool _isGoodToSeeding = false;
  bool _isGoodToFertilizer = false;
  bool _predictionStatus = false;

  Prediction(
      this._duration,
      this._averageRainfall,
      this._predictionInfo,
      this._wateringLevel,
      this._isGoodToSeeding,
      this._isGoodToFertilizer,
      this._predictionStatus);

  Prediction.fromJson(var json){
    _duration = json['duration'];
    _averageRainfall = json['averageRainfall'];
    _predictionInfo = json['predictionInfo'];
    _wateringLevel = double.tryParse(json['wateringLevel'].toString())!;
    _isGoodToSeeding = json['isGoodToSeeding'];
    _isGoodToFertilizer = json['isGoodToFertilizer'];
    _predictionStatus = json['predictionStatus'];
  }
  bool get predictionStatus => _predictionStatus;

  set predictionStatus(bool value) {
    _predictionStatus = value;
  }

  bool get isGoodToFertilizer => _isGoodToFertilizer;

  set isGoodToFertilizer(bool value) {
    _isGoodToFertilizer = value;
  }

  bool get isGoodToSeeding => _isGoodToSeeding;

  set isGoodToSeeding(bool value) {
    _isGoodToSeeding = value;
  }

  double get wateringLevel => _wateringLevel;

  set wateringLevel(double value) {
    _wateringLevel = value;
  }

  String get predictionInfo => _predictionInfo;

  set predictionInfo(String value) {
    _predictionInfo = value;
  }

  String get averageRainfall => _averageRainfall;

  set averageRainfall(String value) {
    _averageRainfall = value;
  }

  String get duration => _duration;

  set duration(String value) {
    _duration = value;
  }
}