import 'package:SenYone/Interfaces/Line/aftu/line-liste.dart';
import 'package:flutter/material.dart';
import 'package:SenYone/Interfaces/ChatBot/chatbot.dart';
import 'package:SenYone/Interfaces/Home/home.dart';
import 'package:SenYone/Interfaces/Line/aftu/check-point-list.dart';

class line extends StatefulWidget {
  const line({super.key});

  @override
  State<line> createState() => _lineState();
}

class _lineState extends State<line> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Adjust the height as needed
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              " Réseau des bus ",
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove the appbar shadow
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      FocusScope.of(context)
                          .unfocus(); // Ensure focus is cleared before navigation
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LineListe()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      height: height * 0.3,
                      width: width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "AFTU",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 17,
                              // Use Noto Serif without custom setup
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),

                          // Add an Image widget here
                          Image.asset(
                            'assets/imgs/AFTU.jpg',
                            height: height * 0.25,
                            width: width * 0.485,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      final snackBar = SnackBar(
                        content: Text('En cours de développement.'),
                        duration: Duration(
                            seconds:
                                4), // Duration for which the SnackBar will be displayed
                        action: SnackBarAction(
                          label:
                              'Cette fonctionnalité sera bientôt disponible ! ',
                          onPressed: () {
                            // Code to undo the user's action
                          },
                        ),
                      );

                      // Show the SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      height: height * 0.3,
                      width: width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "DAKAR DEM DIKK",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 17,
                              // Use Noto Serif without custom setup
                            ),
                          ),

                          SizedBox(
                            height: 7,
                          ),

                          // Add an Image widget here
                          Image.asset(
                            'assets/imgs/DDD.jpg',
                            height: height * 0.25,
                            width: width * 0.485,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
