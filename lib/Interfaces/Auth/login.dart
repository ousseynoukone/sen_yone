import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:SenYone/Interfaces/Auth/activate_account.dart';
import 'package:SenYone/Interfaces/Auth/forget_password.dart';
import 'package:SenYone/Models/Dto/user_dto.dart';
import 'package:SenYone/Models/user.dart';
import '../../Services/auth_service.dart';
import '../Home/home.dart';
import './register.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var email = "";
  var password = "";
  bool isLogin = false;
  var isAnyError = "";
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscurePassword = true;
  final Box _boxLogin = Hive.box("login");
  final Box _boxAccount = Hive.box("account_data");
  var isLoading = false;
  sendResetPassword() async {
    setState(() {
      isLoading = true;
    });

    var response = await AuthService.sendResetEmail(email);

    setState(() {
      isLoading = false;
    });

    print(email);

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => forgetPassword(),
        ),
      );
    } else {
      final scaffoldContext = ScaffoldMessenger.of(context);
      scaffoldContext.showSnackBar(
        SnackBar(
          content: Text(response.body),
        ),
      );
    }
  }

  login() async {
    UserDtoLogin u = UserDtoLogin(email: email, password: password);
    var response = await AuthService.login(u);
    print(response.body);
    if (response != null) {
      setState(() {
        isLogin = false;
      });
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        _boxAccount.put("username", responseJson['username']);
        _boxAccount.put("token", responseJson['token']);
        _boxLogin.put("login", email);
        _boxLogin.put("password", password);
        _boxLogin.put("loginStatus", true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }

      setState(() {
        isLogin = false;
        if (response.statusCode == 401) {
          isAnyError = "Votre compte est ou a été désactivée";
        } else if (response.statusCode == 403) {
          isAnyError = "Email et/ou mots de passe incorrecte !";
        } else if (response.statusCode == 404) {
          isAnyError = response.body;
        } else if (response.statusCode != 200) {
          isAnyError = "Une erreur réseau s'est produite. Veuillez réessayer.";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                "Bienvenue",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Se connecter a votre compte",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: _controllerUsername,
                keyboardType:
                    TextInputType.emailAddress, // Use email address type
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onEditingComplete: () => _focusNodePassword.requestFocus(),
                onChanged: (value) {
                  email = value; // Update the email variable as the user types
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez saisir votre email.";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerPassword,
                focusNode: _focusNodePassword,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Mots de passe",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Veillez saisir votre mots de passe.";
                  }
                  password = value;

                  return null;
                },
              ),
              const SizedBox(height: 10),
              Text(
                isAnyError,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: isLogin
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              login();
                              setState(() {
                                isLogin = true;
                              });
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return Home();
                              //     },
                              //   ),
                              // );
                            }
                          },
                    child: isLogin
                        ? CircularProgressIndicator()
                        : const Text("Se connecter"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Vous n'avez pas de compte ?"),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Signup();
                              },
                            ),
                          );
                        },
                        child: const Text("Créer un compte."),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Active_Account();
                              },
                            ),
                          );
                        },
                        child: const Text("Activer votre compte."),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: isAnyError
                        .isNotEmpty, // Show the widget when anyError is not empty
                    child: Column(
                      children: [
                        const Text("Mots de passe oublié ?"),
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  sendResetPassword();
                                },
                          child: isLoading
                              ? CircularProgressIndicator()
                              : const Text("Réinitialiser votre mot de passe"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
