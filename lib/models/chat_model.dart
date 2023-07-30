
class chatUser{
  chatUser({
    required this.id,
    required this.image,
    required this.name,
    required this.lastActive,
    required this.isOnline,
    required this.email,
    required this.pushToken,
    required this.about
  });
  late final String id;
  late  String image;
  late  String name;
  late  String lastActive;
  late  bool isOnline;
  late final String email;
  late  String pushToken;
  late  String about;

  chatUser.fromJson(Map<String, dynamic> json){
    id=json['id'] ?? '';
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    lastActive = json['last_active'] ?? '';
    isOnline = json['is_online'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    about=json['about'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id']=id;
    data['image'] = image;
    data['name'] = name;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['about']=about;
    return data;
  }
}