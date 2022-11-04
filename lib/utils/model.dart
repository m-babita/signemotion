class UserModel {
  String? name;
  String? email;
  String? uid;

// receiving data
  UserModel({this.name, this.uid, this.email});
  factory UserModel.fromMap(map) {
    return UserModel(
      name: map['name'],
      uid: map['uid'],
      email: map['email'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
    };
  }
}
