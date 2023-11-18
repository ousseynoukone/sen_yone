import 'package:SenYone/Interfaces/Line/aftu/check-point-list.dart';
import 'package:SenYone/Models/ligne.dart';
import 'package:SenYone/REST_REQUEST/http_request_operation.dart';
import 'package:SenYone/Services/operations_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:SenYone/utils.dart';

class LineListe extends StatefulWidget {
  const LineListe({super.key});

  @override
  State<LineListe> createState() => _LineListeState();
}

class _LineListeState extends State<LineListe> {
  Future<List<Ligne>>? _ligneListe;
  final TextEditingController _controllerSearch = TextEditingController();
  List<Ligne> _filteredLines = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllLine();
  }

  getAllLine() {
    _ligneListe = OpsServices.getAllLines();
    _ligneListe?.then((value) {
      setState(() {
        _filteredLines = value;
      });
    });
  }

// SearchLineByNumeroLine
  searchLine(String searchValue) {
    setState(() {
      _ligneListe!.then((lines) {
        _filteredLines = lines;
        _filteredLines = _filteredLines
            .where(
              (element) => element.numero.toString().contains(searchValue),
            )
            .toList();
      });
    });
  }

  void refresh() {
    getAllLine();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des lignes TATA"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            width: width * 0.7,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                controller: _controllerSearch,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "  Rechercher une ligne...",
                  hintStyle: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                  ),
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                onChanged: (value) {
                  searchLine(value);
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              'Selectionnez une ligne pour en voir les details',
              style: SafeGoogleFont(
                'Red Hat Display',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: RefreshIndicator(
                  onRefresh: () async {
                    refresh();
                  },
                  child: SingleChildScrollView(
                    child: FutureBuilder<List<Ligne>>(
                        future: _ligneListe,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            if (_filteredLines.isEmpty) {
                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      "Aucune ligne de bus trouvée.",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(8),
                                  itemCount: _filteredLines.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: LineItems(
                                              ligne: _filteredLines
                                                  .elementAt(index)),
                                        )
                                      ],
                                    );
                                  });
                            }
                          }
                          return const SizedBox.shrink();
                        }),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}

class LineItems extends StatelessWidget {
  final Ligne ligne;
  const LineItems({Key? key, required this.ligne}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CheckPointListe(ligne: ligne)));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/page-1/images/vector-siz.png',
                    width: width * 0.1, // Adjust the width as needed
                    height: width * 0.12, // Adjust the height as needed
                  ),
                ),
                SizedBox(
                  child: Text(
                    ligne.numero.toString(),
                    style: TextStyle(
                      fontFamily: 'Red Hat Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 16,
                          child: Text(
                            'Départ',
                            style: TextStyle(
                              fontFamily: 'Red Hat Display',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02, // Adjust the width as needed
                        ),
                        SizedBox(
                          width: width * 0.1, // Adjust the width as needed
                          height: width * 0.12, // Adjust the height as needed
                          child: Image.asset(
                            'assets/page-1/images/vector-fpE.png',
                            width: width * 0.1, // Adjust the width as needed
                            height: width * 0.12, // Adjust the height as needed
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 16,
                          child: Text(
                            'Arrivé',
                            style: TextStyle(
                              fontFamily: 'Red Hat Display',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02, // Adjust the width as needed
                        ),
                        SizedBox(
                          width: width * 0.1, // Adjust the width as needed
                          height: width * 0.12, // Adjust the height as needed
                          child: Image.asset(
                            'assets/page-1/images/vector-fpE.png',
                            width: width * 0.1, // Adjust the width as needed
                            height: width * 0.12, // Adjust the height as needed
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Container(
              width: 180,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 16,
                        child: Text(
                          ligne.check_points.firstOrNull.trim().length >= 25
                              ? '${ligne.check_points.firstOrNull?.trim().substring(0, 22)}...'
                              : '${ligne.check_points.firstOrNull.trim()}',
                          style: TextStyle(
                            fontFamily: 'Red Hat Display',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.09 * width,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                        child: Text(
                          ligne.check_points.lastOrNull.trim().length >= 25
                              ? '${ligne.check_points.lastOrNull?.trim().substring(0, 22)}...'
                              : '${ligne.check_points.lastOrNull.trim()}',
                          style: TextStyle(
                            fontFamily: 'Red Hat Display',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.1, // Adjust the width as needed
                  height: width * 0.12, // Adjust the height as needed
                  child: Image.asset(
                    'assets/page-1/images/vector-FNz.png',
                    width: width * 0.1, // Adjust the width as needed
                    height: width * 0.12, // Adjust the height as needed
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
