import 'package:farm_buddy/model/plant/ProjectInitialization.dart';
import 'package:farm_buddy/utils/utility.dart';

class Project{
  String _projectID = "";
  String _projectName = "";
  String _cropID = "";
  String _cropName = "";
  String _cropImageURL = "";
  String _cropDescription = "";
  String _cropLifeSpan = "";
  late ProjectInitialization _projectInitialization;
  String _projectStartDate = "";
  String _projectEndDate = "";
  String _projectLastUpdateDate = "";
  String _status = "";
  String _currentStage = "";
  double _completionPercentage = 0;
  double _currentStageCompletionPercentage = 0;

  Project(
      this._projectID,
      this._projectName,
      this._cropID,
      this._cropName,
      this._cropImageURL,
      this._cropDescription,
      this._cropLifeSpan,
      this._projectInitialization,
      this._projectStartDate,
      this._projectEndDate,
      this._projectLastUpdateDate,
      this._status,
      this._currentStage,
      this._completionPercentage,
      this._currentStageCompletionPercentage);

  Project.fromJson(var json){
    print(json['projectID'].toString());
    _projectID = json['projectID'];
    _projectName = json['projectName'];
    _cropID = json['cropInfo']['cropID'];
    _cropName = json['cropInfo']['name'];
    _cropImageURL = json['cropInfo']['imageURL'];
    _cropDescription = json['cropInfo']['description'];

    _cropLifeSpan = json['cropInfo']['lifeSpan'];

    //_projectStartDate = DateTime.fromMicrosecondsSinceEpoch(json['projectStatus']['startDate']).toLocal() as String;
    print("initialization : "+json['projectID']);
    _projectInitialization = ProjectInitialization.fromJson(json['initialization']);
    // print("Project Status purchaseStatus : "+projectInitialization.purchaseStatus.toString());
    // print("Project Status placeSelectionStatus : "+projectInitialization.placeSelectionStatus.toString());

    _projectStartDate = Utility.convertTimeStampToDate(json['projectStatus']['startDate']);
    print(_projectStartDate);
    _projectEndDate = Utility.convertTimeStampToDate(json['projectStatus']['endDate']);
    // _projectLastUpdateDate = new DateTime.fromMicrosecondsSinceEpoch(json['projectStatus']['lastUpdatedOn']['seconds'] *1000).toString();
    _projectLastUpdateDate = Utility.convertTimeStampToDate(json['projectStatus']['lastUpdatedOn']);
    _status = json['projectStatus']['status'];
    _currentStage = json['projectStatus']['currentStage'];
    _completionPercentage = json['projectStatus']['completionLevel'].toDouble();
    _currentStageCompletionPercentage = json['projectStatus']['currentStageCompletion'].toDouble();


  }


  ProjectInitialization get projectInitialization => _projectInitialization;

  set projectInitialization(ProjectInitialization value) {
    _projectInitialization = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get projectLastUpdateDate => _projectLastUpdateDate;

  set projectLastUpdateDate(String value) {
    _projectLastUpdateDate = value;
  }

  String get projectEndDate => _projectEndDate;

  set projectEndDate(String value) {
    _projectEndDate = value;
  }

  String get projectStartDate => _projectStartDate;

  set projectStartDate(String value) {
    _projectStartDate = value;
  }

  String get cropLifeSpan => _cropLifeSpan;

  set cropLifeSpan(String value) {
    _cropLifeSpan = value;
  }

  String get cropDescription => _cropDescription;

  set cropDescription(String value) {
    _cropDescription = value;
  }

  String get cropImageURL => _cropImageURL;

  set cropImageURL(String value) {
    _cropImageURL = value;
  }

  String get cropName => _cropName;

  set cropName(String value) {
    _cropName = value;
  }

  String get cropID => _cropID;

  set cropID(String value) {
    _cropID = value;
  }

  String get projectName => _projectName;

  set projectName(String value) {
    _projectName = value;
  }

  String get projectID => _projectID;

  set projectID(String value) {
    _projectID = value;
  }


  String get currentStage => _currentStage;

  set currentStage(String value) {
    _currentStage = value;
  }

  double get completionPercentage => _completionPercentage;

  set completionPercentage(double value) {
    _completionPercentage = value;
  }

  double get currentStageCompletion => _currentStageCompletionPercentage;

  set currentStageCompletion(double value) {
    _currentStageCompletionPercentage = value;
  }

  double get currentStageCompletionPercentage =>
      _currentStageCompletionPercentage;

  set currentStageCompletionPercentage(double value) {
    _currentStageCompletionPercentage = value;
  }
}