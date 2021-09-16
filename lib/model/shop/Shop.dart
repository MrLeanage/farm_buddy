class Shop{
  String _shopName = "";
  bool _shopStatus = false;
  String _shopCity = "";
  String _shopProvince = "";
  String _shopContactName = "";
  String _shopContactLandPhone = "";
  String _shopContactMobilePhone = "";
  String _shopContactPosition = "";

  Shop(
      this._shopName,
      this._shopStatus,
      this._shopCity,
      this._shopProvince,
      this._shopContactName,
      this._shopContactLandPhone,
      this._shopContactMobilePhone,
      this._shopContactPosition);

  Shop.fromJson(var json){
    shopName = json['name'];
    shopStatus = json['status'];
    shopCity = json['city'];
    shopProvince = json['province'];
    shopContactName = json['contact']['contact_name'];
    shopContactLandPhone = json['contact']['land_phone'];
    shopContactMobilePhone = json['contact']['mobile_phone'];
    shopContactPosition = json['contact']['position'];
  }

  String get shopContactPosition => _shopContactPosition;

  set shopContactPosition(String value) {
    _shopContactPosition = value;
  }

  String get shopContactMobilePhone => _shopContactMobilePhone;

  set shopContactMobilePhone(String value) {
    _shopContactMobilePhone = value;
  }

  String get shopContactLandPhone => _shopContactLandPhone;

  set shopContactLandPhone(String value) {
    _shopContactLandPhone = value;
  }

  String get shopContactName => _shopContactName;

  set shopContactName(String value) {
    _shopContactName = value;
  }

  String get shopProvince => _shopProvince;

  set shopProvince(String value) {
    _shopProvince = value;
  }

  String get shopCity => _shopCity;

  set shopCity(String value) {
    _shopCity = value;
  }

  bool get shopStatus => _shopStatus;

  set shopStatus(bool value) {
    _shopStatus = value;
  }

  String get shopName => _shopName;

  set shopName(String value) {
    _shopName = value;
  }
}