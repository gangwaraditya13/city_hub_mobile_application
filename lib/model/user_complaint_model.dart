class UserComplaintModel {
  String? complaintToName;
  String? complaintTitle;
  String? complaintDescription;
  String? complaintCategory;
  String? complaintStatus;
  String? profilePhotoURL;
  String? profileProductId;
  String? sId;

  UserComplaintModel(
      {this.complaintToName,
        this.complaintTitle,
        this.complaintDescription,
        this.complaintCategory,
        this.complaintStatus,
        this.profilePhotoURL,
        this.profileProductId,
        this.sId});

  UserComplaintModel.fromJson(Map<String, dynamic> json) {
    complaintToName = json['complaintToName'];
    complaintTitle = json['complaintTitle'];
    complaintDescription = json['complaintDescription'];
    complaintCategory = json['complaintCategory'];
    complaintStatus = json['complaintStatus'];
    profilePhotoURL = json['profilePhotoURL'];
    profileProductId = json['profileProductId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complaintToName'] = this.complaintToName;
    data['complaintTitle'] = this.complaintTitle;
    data['complaintDescription'] = this.complaintDescription;
    data['complaintCategory'] = this.complaintCategory;
    data['profilePhotoURL'] = this.profilePhotoURL;
    data['profileProductId'] = this.profileProductId;
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['title'] = this.complaintTitle;
    data['description'] = this.complaintDescription;
    data['profilePhotoURL'] = this.profilePhotoURL ?? "";
    data['profileProductId'] = this.profileProductId ?? "";
    return data;
  }

}
