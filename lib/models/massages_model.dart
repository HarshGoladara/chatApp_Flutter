class Massages {
  Massages({
    required this.read,
    required this.from,
    required this.time,
    required this.to,
    required this.type,
    required this.massage,
  });
  late final bool read;
  late final String from;
  late final String time;
  late final String to;
  late final Type type ;
  late final String massage;

  Massages.fromJson(Map<String, dynamic> json){
    read = json['read'];
    from = json['from'].toString();
    time = json['time'].toString();
    to = json['to'].toString();
    type = json['type'] == Type.text.name ? Type.text : Type.image;
    massage = json['massage'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['read'] = read;
    _data['from'] = from;
    _data['time'] = time;
    _data['to'] = to;
    _data['type'] = type.name;
    _data['massage'] = massage;
    return _data;
  }
}

enum Type {text,image}