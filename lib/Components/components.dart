import 'package:flutter/material.dart';

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




  Future<void> showModalBottom(context) async {
    return     showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.photo),
                        title: Text('Photo'),
                        onTap: () {
                          // Handle photo selection
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.music_note),
                        title: Text('Music'),
                        onTap: () {
                          // Handle music selection
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.videocam),
                        title: Text('Video'),
                        onTap: () {
                          // Handle video selection
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.share),
                        title: Text('Share'),
                        onTap: () {
                          // Handle share action
                          Navigator.pop(context);
                        },
                      ),
                    ],
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



  
    Future<void> showLoadingModal(context) async {
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
                  'Nous somme entrain de chercher pour vous :) ...',
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