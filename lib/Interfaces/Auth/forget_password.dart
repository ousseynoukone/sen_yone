import 'package:flutter/material.dart';

class forgetPassword extends StatefulWidget {
  const forgetPassword({super.key});

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var email = "";

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
              "Réinitialiser votre mots de passe",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            Text(
              "Saisir votre adresse e-mail",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 60),
            TextFormField(
              keyboardType: TextInputType.name,
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
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez saisir votre  email.";
                }
                // else if () {
                //   return "Ce compte n'existe pas.";
                // }
                email = value;
                print("email" + email);
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
                    print("validated email" + email);

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
                child: const Text("Envoyez-moi un email"),
              ),
            ])
          ]))),
    );
  }
}
