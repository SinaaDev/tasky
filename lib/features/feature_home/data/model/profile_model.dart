/// _id : "6654d313ed5aa194fac02ca2"
/// displayName : "alii"
/// username : "+93744443344"
/// roles : ["user"]
/// active : true
/// experienceYears : 1
/// address : "kabul"
/// level : "junior"
/// createdAt : "2024-05-27T18:38:11.056Z"
/// updatedAt : "2024-05-27T18:38:11.056Z"
/// __v : 0

class ProfileModel {
  ProfileModel({
      this.id, 
      this.displayName, 
      this.username, 
      this.roles, 
      this.active, 
      this.experienceYears, 
      this.address, 
      this.level, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  ProfileModel.fromJson(dynamic json) {
    id = json['_id'];
    displayName = json['displayName'];
    username = json['username'];
    roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    active = json['active'];
    experienceYears = json['experienceYears'];
    address = json['address'];
    level = json['level'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? displayName;
  String? username;
  List<String>? roles;
  bool? active;
  num? experienceYears;
  String? address;
  String? level;
  String? createdAt;
  String? updatedAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['displayName'] = displayName;
    map['username'] = username;
    map['roles'] = roles;
    map['active'] = active;
    map['experienceYears'] = experienceYears;
    map['address'] = address;
    map['level'] = level;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}