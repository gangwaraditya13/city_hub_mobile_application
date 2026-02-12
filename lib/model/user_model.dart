class UserModel {
  String? name;
  String? email;
  String? password;
  String? newPassword;
  String? phone;
  String? idProof;
  String? profilePhotoURL;
  String? profileProductId;
  String? address;
  String? city;
  bool? suspend;
  List<String>? roll;
  List<ComplaintList>? complaintList;
  String? sId;

  UserModel(
      {this.name,
        this.email,
        this.password,
        this.newPassword,
        this.phone,
        this.idProof,
        this.profilePhotoURL,
        this.profileProductId,
        this.address,
        this.city,
        this.suspend,
        this.roll,
        this.complaintList,
        this.sId});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    idProof = json['idProof'];
    profilePhotoURL = json['profilePhotoURL'];
    profileProductId = json['profileProductId'];
    address = json['address'];
    city = json['city'];
    suspend = json['suspend'];
    roll = json['roll'].cast<String>();
    if (json['complaintList'] != null) {
      complaintList = <ComplaintList>[];
      json['complaintList'].forEach((v) {
        complaintList!.add(new ComplaintList.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['idProof'] = this.idProof;
    data['profilePhotoURL'] = this.profilePhotoURL;
    data['profileProductId'] = this.profileProductId;
    data['address'] = this.address;
    data['city'] = this.city;
    return data;
  }

  Map<String, dynamic> toJsonUpdateNameOrGmail() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }

  Map<String, dynamic> toJsonUpdateProfilePic() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profilePhotoURL'] = this.profilePhotoURL;
    data['profileProductId'] = this.profileProductId;
    return data;
  }

  Map<String, dynamic> toJsonUpdatePassword() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldPassword'] = this.password;
    data['newPassword'] = this.newPassword;
    return data;
  }

  Map<String, dynamic> toJsonDelete() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    return data;
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, password: $password, newPassword: $newPassword, phone: $phone, idProof: $idProof, profilePhotoURL: $profilePhotoURL, profileProductId: $profileProductId, address: $address, city: $city, suspend: $suspend, sId: $sId}';
  }


}

class ComplaintList {
  String? complaintToName;
  String? complaintTitle;
  String? complaintDescription;
  String? complaintCategory;
  String? complaintStatus;
  String? profilePhotoURL;
  String? profileProductId;
  String? sId;

  ComplaintList(
      {this.complaintToName,
        this.complaintTitle,
        this.complaintDescription,
        this.complaintCategory,
        this.complaintStatus,
        this.profilePhotoURL,
        this.profileProductId,
        this.sId});

  ComplaintList.fromJson(Map<String, dynamic> json) {
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
    data['complaintStatus'] = this.complaintStatus;
    data['profilePhotoURL'] = this.profilePhotoURL;
    data['profileProductId'] = this.profileProductId;
    data['_id'] = this.sId;
    return data;
  }
}
