/// _id : "6656ecbced5aa194fac038d2"
/// image : "/Users/ali/Library/Developer/CoreSimulator/Devices/CC0FA4FD-5924-4915-8C7E-2427C1098100/data/Containers/Data/Application/1CA8CD84-BA69-444D-8151-17C0B7C5B757/tmp/image_picker_561F2C0B-7B32-4D5A-81EE-9E977B51CA6C-43402-0000065E791AA01F.jpg"
/// title : "macbook"
/// desc : "I need a macbook"
/// priority : "medium"
/// status : "waiting"
/// user : "6654d313ed5aa194fac02ca2"
/// createdAt : "2024-05-29T08:52:12.098Z"
/// updatedAt : "2024-05-29T08:52:12.098Z"
/// __v : 0

class OneTaskModel {
  OneTaskModel({
      this.id, 
      this.image, 
      this.title, 
      this.desc, 
      this.priority, 
      this.status, 
      this.user, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  OneTaskModel.fromJson(dynamic json) {
    id = json['_id'];
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    priority = json['priority'];
    status = json['status'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  String? createdAt;
  String? updatedAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['image'] = image;
    map['title'] = title;
    map['desc'] = desc;
    map['priority'] = priority;
    map['status'] = status;
    map['user'] = user;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}