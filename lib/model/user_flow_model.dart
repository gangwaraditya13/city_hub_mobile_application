class UserFlowModel {
  String? _name;
  String? _email;
  String? _password;
  String? _phone;
  String? _idProof;
  String? _profilePhotoURL;
  String? _profileProductId;
  String? _address;
  String? _city;


  UserFlowModel();


  @override
  String toString() {
    return 'UserFlowModel{_name: $_name, _email: $_email, _password: $_password,  _phone: $_phone, _idProof: $_idProof, _profilePhotoURL: $_profilePhotoURL, _profileProductId: $_profileProductId, _address: $_address, _city: $_city}';
  }

  String? get city => _city;

  set city(String value) {
    _city = value;
  }

  String? get address => _address;

  set address(String value) {
    _address = value;
  }

  String? get profileProductId => _profileProductId;

  set profileProductId(String value) {
    _profileProductId = value;
  }

  String? get profilePhotoURL => _profilePhotoURL;

  set profilePhotoURL(String value) {
    _profilePhotoURL = value;
  }

  String? get idProof => _idProof;

  set idProof(String value) {
    _idProof = value;
  }

  String? get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String? get password => _password;

  set password(String value) {
    _password = value;
  }

  String? get email => _email;

  set email(String value) {
    _email = value;
  }

  String? get name => _name;

  set name(String value) {
    _name = value;
  }


}
