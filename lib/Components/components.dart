import 'package:SenYone/Models/trajet.dart';
import 'package:flutter/material.dart';
import 'package:SenYone/Interfaces/Home/Component/traject_component.dart';

//search
class SearchInputComponent extends StatelessWidget {
  final VoidCallback onPressed;

  const SearchInputComponent({Key? key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Chercher un lieu...',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: Colors.grey),
        ),
        onChanged: (value) {
          onPressed;
        },
      ),
    );
  }
}

Future<void> showModalBottom(context, Trajet trajet) async {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: TrajectComponent(trajet: trajet),
      );
    },
  );
}

Future<void> showLogOutModal(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 100, // Set your desired height here

          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Déconnexion...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          )),
        ),
      );
    },
  );
}


