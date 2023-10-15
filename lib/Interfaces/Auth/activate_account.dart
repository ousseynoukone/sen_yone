import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sen_yone/Interfaces/Auth/login.dart';
import '../../Rest_Request/http_request_auth.dart' as httpRequest;
import '../../Services/auth_service.dart';
import '../Home/home.dart';

class Active_Account extends StatefulWidget {
  const Active_Account({super.key});

  @override
  State<Active_Account> createState() => _Active_AccountState();
}

class _Active_AccountState extends State<Active_Account> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var code = "";
  bool isActivating = false;
  var isAnyError = "";
  final Box _boxLogin = Hive.box("login");
  final Box _boxAccount = Hive.box("account_data");

  activateAccount() async {
    var response = await AuthService.activateAccount(code);

    if (response.statusCode == 422) {
      final Map<String, dynamic> responseJson = json.decode(response.body);

      if (responseJson.containsKey("errors") &&
          responseJson["errors"].containsKey("code")) {
        setState(() {
          isAnyError = responseJson["errors"]["code"][0];
        });
      }
    } else {
      setState(() {
        isAnyError = response.body;
      });
    }

    setState(() {
      isActivating = false;
    });
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Activation de votre compte"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Go back when the button is pressed
            },
          ),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Padding(
          padding: EdgeInsetsDirectional.all(20),
          child: Form(
              key: _formKey,
              child: SafeArea(
                  child: Column(children: [
                const SizedBox(height: 130),
                Text(
                  "Un email de vérification vous a été envoyé.",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                const SizedBox(height: 10),
                Text(
                  "Saisir votre code a 6 chiffres",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 60),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Code",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez saisir votre  code.";
                    }
                    if (value.length != 6) {
                      return "Veuillez saisir un code de 6 chiffres.";
                    }
                    // else if () {
                    //   return "Ce compte n'existe pas.";
                    // }
                    code = value;

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  isAnyError.isNotEmpty ? isAnyError : "",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 30),
                Column(children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          isActivating = true;
                        });
                        activateAccount();
                      }
                    },
                    child: isActivating
                        ? CircularProgressIndicator()
                        : const Text("Activer mon compte"),
                  ),
                ])
              ]))),
        ));
  }
}
