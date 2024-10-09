class Cast {
  int? id;
  String? name;
  String? character;
  String? avatarPath;

  Cast({this.id, this.name, this.character, this.avatarPath});


  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      avatarPath: json['profile_path']
    );
  }
}