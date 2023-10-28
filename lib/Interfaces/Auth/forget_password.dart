import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sen_yone/Interfaces/Auth/login.dart';
import 'package:sen_yone/Services/auth_service.dart';

class forgetPassword extends StatefulWidget {
  const forgetPassword({super.key});

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var isLoading = false;
  var code = "";
  var password = "";
  bool _obscurePassword = true;

  resetPassword() async {
    setState(() {
      isLoading = true;
    });

    var response = await AuthService.resetPassword(code, password);

    if (response.toString().isNotEmpty) {
      setState(() {
        isLoading = false;
      });
    }
    print(response.statusCode);
    if (response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }

    if (response.statusCode == 422) {
      print(response.body);
      final Map<String, dynamic> responseJson = json.decode(response.body);

      if (responseJson.containsKey("errors") &&
          responseJson["errors"].containsKey("code")) {
        final scaffoldContext = ScaffoldMessenger.of(context);
        scaffoldContext.showSnackBar(
          SnackBar(
            content: Text(responseJson["errors"]["code"][0]),
          ),
        );
      } else {
        final scaffoldContext = ScaffoldMessenger.of(context);
        scaffoldContext.showSnackBar(
          SnackBar(
            content: Text(responseJson["errors"]["password"][0]),
          ),
        );
      }
    } else {
      final scaffoldContext = ScaffoldMessenger.of(context);
      scaffoldContext.showSnackBar(
        SnackBar(
          content: Text(response.body),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(title: Text("Réinitialisation")),
      body: Form(
          key: _formKey,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                const SizedBox(height: 150),
                Text(
                  "Un email  vous a été envoyé.",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                const SizedBox(height: 10),
                Text(
                  "Réinitialiser votre mots de passe",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 60),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "code",
                    prefixIcon: const Icon(Icons.password_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez saisir votre code.";
                    }
                    // else if () {
                    //   return "Ce compte n'existe pas.";
                    // }
                    code = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
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
                      return "Veuillez saisir votre nouveau mots de passe.";
                    } else if (value.length < 8) {
                      return "Le mots de passe doit contenir au moins 8 caractéres.";
                    }
                    password = value;
                    return null;
                  },
                ),
                const SizedBox(height: 60),
                Column(children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              resetPassword();
                              // );
                            }
                          },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : const Text("Réinitialiser mon mots de passe"),
                  ),
                ])
              ]),
            ),
          ))),
    );
  }
}
