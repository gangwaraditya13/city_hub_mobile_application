class TokenModel {
  String? jwtToken;

  TokenModel({this.jwtToken});

  TokenModel.fromJson(Map<String, dynamic> json) {
    jwtToken = json['jwtToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwtToken'] = this.jwtToken;
    return data;
  }
}
