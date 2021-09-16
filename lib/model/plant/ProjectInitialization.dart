import 'package:farm_buddy/utils/utility.dart';

class ProjectInitialization{
  bool _purchaseStatus = false;
  bool _placeSelectionStatus = false;
  String _placeID = "";
  String _placeName = "";
  List<String> _prerequisite = [];
  List<String> _methodology = [];
  String _placeImageURL = "";
  String _sampleViewImage = "";

  ProjectInitialization(
      this._purchaseStatus,
      this._placeSelectionStatus,
      this._placeID,
      this._placeName,
      this._prerequisite,
      this._methodology,
      this._placeImageURL,
      this._sampleViewImage);

  ProjectInitialization.fromJson(var json){
    purchaseStatus = json['purchaseStatus'];
    placeSelectionStatus = json['place_selectionStatus'];
    print("Project Status purchaseStatus : "+purchaseStatus.toString());
    print("Project Status placeSelectionStatus : "+placeSelectionStatus.toString());

    placeID = json['place']['id'];
    placeName = json['place']['name'];
    prerequisite = Utility.listBuilderFromJson(json['place']['prerequisite']);
    methodology = Utility.listBuilderFromJson(json['place']['methodology']);
    placeImageURL = json['place']['imageURL'];
    sampleViewImage = json['place']['sampleViewImage'];

  }

  String get sampleViewImage => _sampleViewImage;

  set sampleViewImage(String value) {
    _sampleViewImage = value;
  }

  List<String> get methodology => _methodology;

  set methodology(List<String> value) {
    _methodology = value;
  }

  List<String> get prerequisite => _prerequisite;

  set prerequisite(List<String> value) {
    _prerequisite = value;
  }

  String get placeImageURL => _placeImageURL;

  set placeImageURL(String value) {
    _placeImageURL = value;
  }

  String get placeName => _placeName;

  set placeName(String value) {
    _placeName = value;
  }

  String get placeID => _placeID;

  set placeID(String value) {
    _placeID = value;
  }


  bool get placeSelectionStatus => _placeSelectionStatus;

  set placeSelectionStatus(bool value) {
    _placeSelectionStatus = value;
  }

  bool get purchaseStatus => _purchaseStatus;

  set purchaseStatus(bool value) {
    _purchaseStatus = value;
  }
}
