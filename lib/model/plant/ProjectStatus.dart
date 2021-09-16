class ProjectStatus{
  String _status = "";
  String _startDate = "";
  String _lastUpdatedOn = "";
  String _endDate = "";
  double _completionPercentage = 0;

  ProjectStatus(this._status, this._startDate, this._lastUpdatedOn,
      this._endDate, this._completionPercentage);

  ProjectStatus.fromJson(var json){
    status = json['status'];
    startDate = json['startDate'];
    lastUpdatedOn = json['lastUpdatedOn'];
    endDate = json['endDate'];
    completionPercentage = json['completionLevel'];
  }

  double get completionPercentage => _completionPercentage;

  set completionPercentage(double value) {
    _completionPercentage = value;
  }

  String get endDate => _endDate;

  set endDate(String value) {
    _endDate = value;
  }

  String get lastUpdatedOn => _lastUpdatedOn;

  set lastUpdatedOn(String value) {
    _lastUpdatedOn = value;
  }

  String get startDate => _startDate;

  set startDate(String value) {
    _startDate = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }
}