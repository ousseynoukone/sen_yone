
class UserDtoLogin {
  String email;
  String password;

  UserDtoLogin({required this.email, required this.password});
  
Map<String, dynamic> toBody() {
  return {
    'email': this.email,
    'password': this.password,
  };
}

}
