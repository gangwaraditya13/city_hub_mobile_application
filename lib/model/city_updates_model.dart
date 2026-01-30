class CityUpdates {
  List<CityUpdate>? cityUpdates;

  CityUpdates({this.cityUpdates});

  CityUpdates.fromJson(Map<String, dynamic> json) {
    if (json['cityUpdates'] != null) {
      cityUpdates = <CityUpdate>[];
      json['cityUpdates'].forEach((v) {
        cityUpdates!.add(new CityUpdate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cityUpdates != null) {
      data['cityUpdates'] = this.cityUpdates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityUpdate{
  String? title;
  String? description;
  String? createdDate;
  String? profilePhotoURL;
  String? profileProductId;
  String? sId;

  CityUpdate(
      {this.title,
        this.description,
        this.createdDate,
        this.profilePhotoURL,
        this.profileProductId,
        this.sId});

  CityUpdate.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    createdDate = json['createdDate'];
    profilePhotoURL = json['profilePhotoURL'];
    profileProductId = json['profileProductId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdDate'] = this.createdDate;
    data['profilePhotoURL'] = this.profilePhotoURL;
    data['profileProductId'] = this.profileProductId;
    data['_id'] = this.sId;
    return data;
  }
}
