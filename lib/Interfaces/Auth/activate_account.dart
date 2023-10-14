import 'package:flutter/material.dart';
import '../../Rest_Request/http_request_auth.dart' as httpRequest;

class Active_Account extends StatefulWidget {
  const Active_Account({super.key});

  @override
  State<Active_Account> createState() => _Active_AccountState();
}

class _Active_AccountState extends State<Active_Account> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Form(
          key: _formKey,
          child: SafeArea(
              child: Column(children: [
            const SizedBox(height: 150),
            Text(
              "Activation de votre compte",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            Text(
              "Saisir votre code a 6 chiffres",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 60),
            TextFormField(
              keyboardType: TextInputType.name,
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
                // else if () {
                //   return "Ce compte n'existe pas.";
                // }
                code = value;
                print("code" + code);
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
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    print("validated code" + code);

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
                child: const Text("Activer mon compte"),
              ),
            ])
          ]))),
    );
  }
}
