class CityInfoModel {
  String? cityName;
  List<CitySchools>? citySchools;
  List<CityHospitals>? cityHospitals;
  List<CityUtilities>? cityUtilities;

  CityInfoModel(
      {this.cityName,
        this.citySchools,
        this.cityHospitals,
        this.cityUtilities});

  CityInfoModel.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    if (json['citySchools'] != null) {
      citySchools = <CitySchools>[];
      json['citySchools'].forEach((v) {
        citySchools!.add(new CitySchools.fromJson(v));
      });
    }
    if (json['cityHospitals'] != null) {
      cityHospitals = <CityHospitals>[];
      json['cityHospitals'].forEach((v) {
        cityHospitals!.add(new CityHospitals.fromJson(v));
      });
    }
    if (json['cityUtilities'] != null) {
      cityUtilities = <CityUtilities>[];
      json['cityUtilities'].forEach((v) {
        cityUtilities!.add(new CityUtilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    if (this.citySchools != null) {
      data['citySchools'] = this.citySchools!.map((v) => v.toJson()).toList();
    }
    if (this.cityHospitals != null) {
      data['cityHospitals'] =
          this.cityHospitals!.map((v) => v.toJson()).toList();
    }
    if (this.cityUtilities != null) {
      data['cityUtilities'] =
          this.cityUtilities!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toJsonOtherCity() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.cityName;
    return data;
  }
}

class CitySchools {
  String? schoolName;
  String? category;
  String? ownership;
  String? schoolAddress;
  String? schoolContact;
  String? sId;

  CitySchools(
      {this.schoolName,
        this.category,
        this.ownership,
        this.schoolAddress,
        this.schoolContact,
        this.sId});

  CitySchools.fromJson(Map<String, dynamic> json) {
    schoolName = json['schoolName'];
    category = json['category'];
    ownership = json['ownership'];
    schoolAddress = json['schoolAddress'];
    schoolContact = json['schoolContact'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolName'] = this.schoolName;
    data['category'] = this.category;
    data['ownership'] = this.ownership;
    data['schoolAddress'] = this.schoolAddress;
    data['schoolContact'] = this.schoolContact;
    data['_id'] = this.sId;
    return data;
  }
}

class CityHospitals {
  String? hospitalName;
  String? hospitalAddress;
  String? hospitalContact;
  List<String>? hospitalFacilities;
  String? sId;

  CityHospitals(
      {this.hospitalName,
        this.hospitalAddress,
        this.hospitalContact,
        this.hospitalFacilities,
        this.sId});

  CityHospitals.fromJson(Map<String, dynamic> json) {
    hospitalName = json['hospitalName'];
    hospitalAddress = json['hospitalAddress'];
    hospitalContact = json['hospitalContact'];
    hospitalFacilities = json['hospitalFacilities'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospitalName'] = this.hospitalName;
    data['hospitalAddress'] = this.hospitalAddress;
    data['hospitalContact'] = this.hospitalContact;
    data['hospitalFacilities'] = this.hospitalFacilities;
    data['_id'] = this.sId;
    return data;
  }
}

class CityUtilities {
  String? utilityDepartment;
  String? utilityContact;
  String? utilityAddress;
  String? utilityDepartmentOfficer;
  String? sId;

  CityUtilities(
      {this.utilityDepartment,
        this.utilityContact,
        this.utilityAddress,
        this.utilityDepartmentOfficer,
        this.sId});

  CityUtilities.fromJson(Map<String, dynamic> json) {
    utilityDepartment = json['utilityDepartment'];
    utilityContact = json['utilityContact'];
    utilityAddress = json['utilityAddress'];
    utilityDepartmentOfficer = json['utilityDepartmentOfficer'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['utilityDepartment'] = this.utilityDepartment;
    data['utilityContact'] = this.utilityContact;
    data['utilityAddress'] = this.utilityAddress;
    data['utilityDepartmentOfficer'] = this.utilityDepartmentOfficer;
    data['_id'] = this.sId;
    return data;
  }
}
