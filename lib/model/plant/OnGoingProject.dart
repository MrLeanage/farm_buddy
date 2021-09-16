import 'package:farm_buddy/model/plant/PlantStage.dart';
import 'package:farm_buddy/model/plant/ProjectInitialization.dart';
import 'package:farm_buddy/utils/utility.dart';

import 'Crop.dart';

class OngoingProject{
  String _projectID = "";
  String _projectName = "";
  late Crop _crop;
  late ProjectInitialization _initialization;
  late PlantStage _plantStage;
  String _status = "";
  String _projectStartDate = "";
  String _projectEndDate = "";
  String _projectLastUpdateDate = "";
  double _completionPercentage = 0;
  String _currentStage = "";
  double _currentStageCompletionPercentage = 0;

  OngoingProject(
      this._projectID,
      this._projectName,
      this._crop,
      this._initialization,
      this._plantStage,
      this._projectStartDate,
      this._projectEndDate,
      this._projectLastUpdateDate,
      this._status,
      this._completionPercentage,
      this._currentStage,
      this._currentStageCompletionPercentage);

  OngoingProject.fromJson(var json){
    projectID = json['projectID'];
    projectName = json['projectName'];
    crop = Crop.fromJson(json['cropInfo']);
    initialization = ProjectInitialization.fromJson(json['initialization']);
    plantStage = PlantStage.fromJson(json['plantStage']);
    projectStartDate =  Utility.convertTimeStampToDate(json['projectStatus']['startDate']);
    projectEndDate =  Utility.convertTimeStampToDate(json['projectStatus']['endDate']) ;
    projectLastUpdateDate =  Utility.convertTimeStampToDate(json['projectStatus']['lastUpdatedOn']);
    status = json['projectStatus']['status'];
    completionPercentage = json['projectStatus']['completionLevel'].toDouble();
    currentStage = json['projectStatus']['currentStage'];
    print("currentStageCompletion :"+json['projectStatus']['currentStageCompletion'].toString());
    currentStageCompletionPercentage = json['projectStatus']['currentStageCompletion'].toDouble();
  }


  double get completionPercentage => _completionPercentage;

  set completionPercentage(double value) {
    _completionPercentage = value;
  }

  ProjectInitialization get initialization => _initialization;

  set initialization(ProjectInitialization value) {
    _initialization = value;
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

  PlantStage get plantStage => _plantStage;

  set plantStage(PlantStage value) {
    _plantStage = value;
  }


  Crop get crop => _crop;

  set crop(Crop value) {
    _crop = value;
  }

  String get projectName => _projectName;

  set projectName(String value) {
    _projectName = value;
  }

  String get projectID => _projectID;

  set projectID(String value) {
    _projectID = value;
  }

  double get currentStageCompletionPercentage =>
      _currentStageCompletionPercentage;

  set currentStageCompletionPercentage(double value) {
    _currentStageCompletionPercentage = value;
  }

  String get currentStage => _currentStage;

  set currentStage(String value) {
    _currentStage = value;
  }
}