/// _id : "665345cbed5aa194fac01f88"
/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjUzNDVjYmVkNWFhMTk0ZmFjMDFmODgiLCJpYXQiOjE3MTY3MzM1MTAsImV4cCI6MTcxNjczNDExMH0.zkM_BKzOfequRMgipMmZgDbsM8IKFhwcAabYVnZVROQ"
/// refresh_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjUzNDVjYmVkNWFhMTk0ZmFjMDFmODgiLCJpYXQiOjE3MTY3MzM1MTB9.CWwWk60aK33ZIuPP5RkSCIDNjrZZxbF_EoiRpZ1zFJY"

class TokenModel {
  TokenModel({
    this.id,
    this.accessToken,
    this.refreshToken,
  });

  TokenModel.fromJson(dynamic json) {
    id = json['_id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  String? id;
  String? accessToken;
  String? refreshToken;

  TokenModel copyWith({
    String? id,
    String? accessToken,
    String? refreshToken,
  }) =>
      TokenModel(
        id: id ?? this.id,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['access_token'] = accessToken;
    map['refresh_token'] = refreshToken;
    return map;
  }
}
