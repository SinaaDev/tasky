/// _id : "665616f0ed5aa194fac036b6"
/// image : "/Users/ali/Library/Developer/CoreSimulator/Devices/CC0FA4FD-5924-4915-8C7E-2427C1098100/data/Containers/Data/Application/A14220D6-06C7-48A7-8B4B-8FC96647BBFB/tmp/image_picker_97FBDC5A-D8C3-4A03-A42B-7196573127C9-12777-000005C1338572E6.jpg"
/// title : "study"
/// desc : "I have to study"
/// priority : "low"
/// status : "waiting"
/// user : "6654d313ed5aa194fac02ca2"
/// createdAt : "2024-05-28T17:40:00.210Z"
/// updatedAt : "2024-05-28T17:40:00.210Z"
/// __v : 0

class AllTaskModel {
  AllTaskModel({
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

  AllTaskModel.fromJson(dynamic json) {
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