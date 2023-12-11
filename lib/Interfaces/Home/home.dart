import 'dart:developer';

import 'package:SenYone/Interfaces/Home/Component/modal.dart';
import 'package:SenYone/Interfaces/Home/start.dart';
import 'package:SenYone/Layouts/mainLayout.dart';
import 'package:SenYone/Models/Dto/custom_position_dto.dart';
import 'package:SenYone/Models/Dto/globals_dto.dart';
import 'package:SenYone/Responsiveness/responsive.dart';
import 'package:logger/logger.dart';
import '../../Shared/globals.dart' as globals;
import 'package:SenYone/REST_REQUEST/maps_request.dart';
import 'package:SenYone/Services/geo_service.dart';
import 'package:SenYone/Services/operations_service.dart';
import 'package:SenYone/Services/permission_handler.dart';
import 'package:SenYone/Shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:SenYone/Interfaces/Auth/login.dart';
import 'package:SenYone/Interfaces/ChatBot/chatbot.dart';
import 'package:SenYone/Interfaces/Line/lines.dart';
import '../../Components/components.dart';
import '../../Components/map.dart';
import '../../utils.dart';
import '../../Services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final Box _boxAccount = Hive.box("account_data");
  bool switchValue = true;

  var isLoading = false;
  bool positionPermisionCheck = false;

  final GeoapifyApi geoapifyApi = GeoapifyApi();
  //Tableau qui vas tocker les prediction de completion D pour depart et A pour arrivé
  List<String> autocompleteSuggestionsD = [];
  List<String> autocompleteSuggestionsA = [];
  final TextEditingController _controllerDeparture = TextEditingController();
  final TextEditingController _controllerArrival = TextEditingController();

  positionPermistionChecker() async {
    var _positionPermisionCheck =
        await PermissionHandler.handleLocationPermission(context);
    setState(() {
      positionPermisionCheck = _positionPermisionCheck;
    });

    if (positionPermisionCheck == false) {
      setState(() {
        switchValue = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchValue = _boxAccount.get("isUsingLocalisation") ?? false;

    positionPermistionChecker();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Size screenSize = MediaQuery.of(context).size;
    double scaleFactor = MediaQuery.of(context).textScaleFactor;

    var username = _boxAccount.get("username");

    logOut() async {
      setState(() {
        isLoading = true;
      });
      var response = AuthService.logOut();
      setState(() {
        isLoading = false;
      });
      if (response.toString().isNotEmpty) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login()));
      }
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColorLight,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  // group340239S2 (210:902)
                  margin: EdgeInsets.fromLTRB(13, 0, 12, 9),
                  padding: EdgeInsets.fromLTRB(17, 7, 21, 5),
                  width: double.infinity,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //Bottom bar
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 5, 1),
                                child: Text(
                                  "Historique",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 16 * scaleFactor,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3225,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              SizedBox(
                                // vectorG2n (207:656)
                                width: 20,
                                height: 20,
                                child: Image.asset(
                                  'assets/page-1/images/vector-daz.png',
                                  width: 0.090 * baseWidth,
                                  height: 0.12 * baseWidth,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showLogOutModal(context);
                          logOut();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: SizedBox(
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 5, 1),
                                child: Text(
                                  username,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 16 * scaleFactor,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3225,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              SizedBox(
                                // vectorG2n (207:656)
                                width: 18,
                                height: 18,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Image.asset(
                                    'assets/page-1/images/vector-A6v.png',
                                    width: 0.090 * baseWidth,
                                    height: 0.12 * baseWidth,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // body
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorLight, // Background color
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            children: [
                              Visibility(
                                visible: switchValue,
                                child: Visibility(
                                  visible: switchValue,
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      hintText:
                                          'Lieu de départ  --->  Votre position actuelle',
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontSize: 14 * scaleFactor),
                                      border: InputBorder.none,
                                    ),
                                  ),

                                  // child: SizedBox(
                                  //   height: height * 0.045,
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     children: [
                                  //       Text("Lieu de départ "),
                                  //       Icon(Icons.arrow_forward_rounded),
                                  //       Text("Votre position actuelle"),
                                  //     ],
                                  //   ),
                                  // ),
                                ),
                              ),
                              Visibility(
                                visible: !switchValue,
                                child: TextField(
                                  controller: _controllerDeparture,
                                  decoration: InputDecoration(
                                    hintText: 'Lieu de départ...',
                                    hintStyle: TextStyle(
                                      fontSize: 14 * scaleFactor,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                  onChanged: (value) async {
                                    final suggestions = await geoapifyApi
                                        .getAutocompleteSuggestions(value);
                                    setState(() {
                                      autocompleteSuggestionsD = suggestions;
                                    });
                                  },
                                ),
                              ),
                              if (autocompleteSuggestionsD.isNotEmpty)
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: autocompleteSuggestionsD.length,
                                    itemBuilder: (context, index) {
                                      final suggestion =
                                          autocompleteSuggestionsD[index];
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _controllerDeparture.text =
                                                suggestion;
                                            autocompleteSuggestionsD =
                                                []; // Clear suggestions
                                            FocusScope.of(context)
                                                .unfocus(); // Dismiss keyboard
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(suggestion),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              10), // Adjust the space between the two search bars
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorLight, // Background color
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            children: [
                              TextField(
                                controller: _controllerArrival,
                                decoration: InputDecoration(
                                  hintText: 'Lieu de arrivé...',
                                  hintStyle: TextStyle(
                                    fontSize: 14 * scaleFactor,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                onChanged: (value) async {
                                  final suggestions = await geoapifyApi
                                      .getAutocompleteSuggestions(value);
                                  setState(() {
                                    autocompleteSuggestionsA = suggestions;
                                  });
                                },
                              ),
                              if (autocompleteSuggestionsA.isNotEmpty)
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: autocompleteSuggestionsA.length,
                                    itemBuilder: (context, index) {
                                      final suggestion =
                                          autocompleteSuggestionsA[index];
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _controllerArrival.text =
                                                suggestion;
                                            autocompleteSuggestionsA =
                                                []; // Clear suggestions
                                            FocusScope.of(context)
                                                .unfocus(); // Dismiss keyboard
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(suggestion),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Utiliser ma position actuelle',
                      style: TextStyle(
                        fontSize: 16 * scaleFactor,
                      ),
                    ),
                    Switch(
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey.shade300,
                      value: switchValue,
                      onChanged: (bool value) {
                        usePosition(value);
                      },
                    ),
                  ],
                ),

                //RESPONSIVE AREA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                Responsive(
                    mobile: Container(
                        // autogroupdveav2n (NxMJd4Z2q1LEKwGSa4DVEA)
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        width: double.infinity,
                        height: height / 2.2,
                        child: const MapScreen()),
                    tablet: Container(
                        // autogroupdveav2n (NxMJd4Z2q1LEKwGSa4DVEA)
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        width: double.infinity,
                        height: baseWidth / 1.20,
                        child: const MapScreen()),
                    desktop: Container(
                        // this is random , for the moments desktop is not the priority
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        width: double.infinity,
                        height: baseWidth / 2.20,
                        child: const MapScreen())),

                //END OF RESPONSIVE AREA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                Container(
                  // autogroup9sfcXYN (NxMJhE6m1x6MzaXkjG9SfC)
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),

                  width: double.infinity,
                  height: 50,

                  child: TextButton(
                    // group34007Rte (208:741)
                    onPressed: () async {
                      if (switchValue == true) {
                        if (_controllerArrival.text.isNotEmpty) {
                          searchForTraject();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Veuillez saisir votre destination."),
                            duration: Duration(milliseconds: 2000),
                          ));
                        }
                      } else {
                        if (_controllerArrival.text.isNotEmpty &&
                            _controllerDeparture.text.isNotEmpty) {
                          searchForTraject();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Verifiez d'avoir bien saisit votre adresse de départ et votre destination."),
                            duration: Duration(milliseconds: 4000),
                          ));
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 175,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Color(0xff810000),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      // vectorKUE (208:672)

                                      width: 22,
                                      height: 24,
                                      child: Image.asset(
                                        'assets/page-1/images/vector-6HY.png',
                                        width: 22,
                                        height: 24,
                                      ),
                                    ),
                                    Text(
                                      'Trouver un trajet',
                                      style: SafeGoogleFont(
                                        'Red Hat Display',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        height: 1.3225,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                  ]))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<void> usePosition(bool value) async {
    await positionPermistionChecker();
    if (positionPermisionCheck == true) {
      switchValue = value;
    }
    _boxAccount.put("isUsingLocalisation", switchValue);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MainLayout()));
  }

  Future<void> searchForTraject() async {
    ModalManager.showLoadingModal(context);

    CustumPostionDto userPosition = globals.userLocation;
    if (switchValue == true) {
      log(" actuall positipon");
      var response = null;
      if (userPosition != null) {
        var arrivalLocation =
            await GeoapifyService.fetchCoordinates(_controllerArrival.text);
        if (arrivalLocation != null) {
          RouteRequestDTO routeRequestDTO = new RouteRequestDTO(
              departLatitude: userPosition.latitude,
              departLongitude: userPosition.longitude,
              arriveLatitude: arrivalLocation!.latitude,
              arriveLongitude: arrivalLocation!.longitude,
              approximation: 1);

          print(routeRequestDTO.departLatitude);
          print(routeRequestDTO.departLongitude);
          print(routeRequestDTO.arriveLatitude);
          print(routeRequestDTO.arriveLongitude);
          response = await OpsServices.searchForTraject(routeRequestDTO);

          if (response != null) {
            ModalManager.dismissModal(); // Dismiss the loading modal
            if (context != null && ModalManager.loadingModalContext != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showModalBottom(ModalManager.loadingModalContext!, response);
              });
            }
          } else {
            ModalManager.dismissModal();
            if (mounted) {
              // Show the error modal
              ModalManager.showErrorModal(context);

              // Dismiss the modal after a delay
              Future.delayed(Duration(seconds: 5), () {
                if (mounted) {
                  ModalManager.dismissModal();
                }
              });
            }
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Destination inatteignable."),
            duration: Duration(milliseconds: 3000),
          ));
        }
      }
    } else {
      log("not actuall positipon");

      var userPosition =
          await GeoapifyService.fetchCoordinates(_controllerDeparture.text);
      var arrivalLocation =
          await GeoapifyService.fetchCoordinates(_controllerArrival.text);

      if (userPosition != null) {
        if (arrivalLocation != null) {
          RouteRequestDTO routeRequestDTO = new RouteRequestDTO(
              departLatitude: userPosition!.latitude,
              departLongitude: userPosition!.longitude,
              arriveLatitude: arrivalLocation!.latitude,
              arriveLongitude: arrivalLocation!.longitude,
              approximation: 1);

          print(routeRequestDTO.arriveLatitude);
          print(routeRequestDTO.arriveLongitude);
          print(routeRequestDTO.departLatitude);
          print(routeRequestDTO.departLongitude);
          var response = await OpsServices.searchForTraject(routeRequestDTO);
          if (response != null) {
            ModalManager.dismissModal(); // Dismiss the loading modal
            if (context != null && ModalManager.loadingModalContext != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showModalBottom(ModalManager.loadingModalContext!, response);
              });
            }
          } else {
            ModalManager.dismissModal();
            if (context != null) {
              // ignore: use_build_context_synchronously
              ModalManager.showErrorModal(context);
              Future.delayed(Duration(seconds: 5), () {
                ModalManager.dismissModal();
              });
            }
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Destination inatteignable."),
            duration: Duration(milliseconds: 3000),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Point de départ inatteignable."),
          duration: Duration(milliseconds: 3000),
        ));
      }
    }

    // showModalBottom(context);
  }
}
