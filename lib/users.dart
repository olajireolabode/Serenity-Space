import '/registration.dart';

class User{
  int? id;
  String? email;
  String? password;

  User(this.email,this.password);

  User.fromMap(Map<String, dynamic> map) {
    id= map['id'];
    email = map['email'];
    password= map['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnEmail: email,
      DatabaseHelper.columnPassword: password,
    };
  }
}