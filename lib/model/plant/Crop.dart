class Crop{
  String _cropID ="";
  String _name = "";
  String _imageURL = "";
  String _description = "";
  String _placeID = "";
  String _placeName = "";
  String _lifeSpan = "";
  bool _cropNoteStatus = false;
  String _cropNoteMsg = "";

  Crop(this._cropID, this._name, this._description, this._placeName, this._placeID,
      this._lifeSpan, this._cropNoteStatus, this._cropNoteMsg);
  Crop.fromJson(var json){

    _cropID = json['cropID'];
    _name =   json['name'];
    _imageURL =  json['imageURL'];
    _description =  json['description'];
    _placeID = json['initialization']?['place']['id'];
    _placeName = json['initialization']?['place']['name'];
    _lifeSpan =   json['lifeSpan'];
    _cropNoteStatus =   json['cropNote']?['noteStatus'];
    _cropNoteMsg =   json['cropNote']?['noteMessage'];
  }

  String get cropNoteMsg => _cropNoteMsg;

  set cropNoteMsg(String value) {
    _cropNoteMsg = value;
  }

  bool get cropNoteStatus => _cropNoteStatus;

  set cropNoteStatus(bool value) {
    _cropNoteStatus = value;
  }

  String get lifeSpan => _lifeSpan;

  set lifeSpan(String value) {
    _lifeSpan = value;
  }

  String get placeName => _placeName;

  set placeName(String value) {
    _placeName = value;
  }

  String get placeID => _placeID;

  set placeID(String value) {
    _placeID = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get imageURL => _imageURL;

  set imageURL(String value) {
    _imageURL = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get cropID => _cropID;

  set cropID(String value) {
    _cropID = value;
  }
}