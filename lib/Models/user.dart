import 'dart:convert';

class User {
  String name;
  String email;
  String password;

  User({required this.email, required this.name, required this.password});
  toBody() {
    return {name: this.name, email: this.email, password: this.password};
  }
}
