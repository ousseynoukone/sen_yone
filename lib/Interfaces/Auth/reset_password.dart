import 'package:flutter/material.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({super.key});

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var code = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Form(
          child: SafeArea(
              child: Column(children: [
        const SizedBox(height: 150),
        Text(
          "Réinitialiser votre mots de passe",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 10),
        Text(
          "Saisir votre adresse code a 4 chiffres",
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
        const SizedBox(height: 10),
        Text(
          "Saisir votre nouveau mots de passe",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 60),
        TextFormField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: "Nouveau mots de passe",
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
              return "Veuillez saisir votre nouveau mots de passe.";
            }
            // else if () {
            //   return "Ce compte n'existe pas.";
            // }
            password = value;
            print("password" + password);
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
                    print("validated password" + password);

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
                child: const Text("Réinitialiser mon compte"),
              ),
      ])
      ])
      ),
    ));
  }
}
