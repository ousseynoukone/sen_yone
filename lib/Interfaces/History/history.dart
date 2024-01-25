import 'package:SenYone/Interfaces/History/direct_trajet_history_details.dart';
import 'package:SenYone/Interfaces/Trajet/trajets_detail.dart';
import 'package:SenYone/Models/Dto/trajet_history_dto.dart';
import 'package:SenYone/Models/trajetHistorique.dart';
import 'package:SenYone/Services/operations_service.dart';
import 'package:SenYone/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:logger/logger.dart';

class HistoriqueTrajet extends StatefulWidget {
  const HistoriqueTrajet({Key? key}) : super(key: key);

  @override
  State<HistoriqueTrajet> createState() => _HistoriqueTrajetState();
}

class _HistoriqueTrajetState extends State<HistoriqueTrajet> {
  late Future<TrajetHistorique?> historiqueFuture;
  TextEditingController _datePickerController = TextEditingController();
  DateTime? dateToSearch;
  @override
  void initState() {
    super.initState();
    historiqueFuture = OpsServices.getHistoriques();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historique")),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: FutureBuilder<TrajetHistorique?>(
            future: historiqueFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Loading indicator
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Error indicator
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Data is available, display it
                return Container(
                    child: Center(
                        child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                          readOnly: true,
                        controller: _datePickerController,
                        decoration: InputDecoration(
                          hintText: 'Choisir une date',
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.event_note),
                                SizedBox(
                                    width:
                                        20), // Add some spacing between the icons
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      dateToSearch = null;
                                      _datePickerController.clear();
                                    });
                                  },
                                  child: Icon(Icons.cancel),
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: dateToSearch ?? DateTime.now(),
                            firstDate: DateTime.now().subtract(const Duration(
                                days:
                                    365)), // Earliest selectable date (40 days ago)
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null &&
                              pickedDate != dateToSearch) {
                            setState(() {
                              dateToSearch = pickedDate;
                              _datePickerController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: buildHistoriqueWidget(
                              snapshot.data!, dateToSearch, context),
                        ),
                      ),
                    ),
                  ],
                )));
              } else {
                // No data available
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "😏 ",
                          style: DefaultTextStyle.of(context).style.copyWith(
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 40,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBox(height: 16.0),
                        Center(
                          child: Text(
                            "Vous n'avez pas encore sauvegardé de trajet.",
                            style: DefaultTextStyle.of(context).style.copyWith(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          16,
                                  fontWeight: FontWeight.w400,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildHistoriqueWidget(
      TrajetHistorique historique, DateTime? dateToSearch, context) {
    // Check if there are direct and indirect trajets
    if (historique.trajetDirect.isNotEmpty ||
        historique.trajetIndirect.isNotEmpty) {
      // Filter the data based on the selected date and time
      List<TrajetDirectDto> filteredDirectTrajets = historique.trajetDirect
          .where(
              (directTrajet) => isTrajetInTimeRange(directTrajet, dateToSearch))
          .toList();

      List<TrajetIndirectDto> filteredIndirectTrajets = historique
          .trajetIndirect
          .where((indirectTrajet) =>
              isIndirectTrajetInTimeRange(indirectTrajet, dateToSearch))
          .toList();

      return Column(
        children: [
          // Display direct trajets
          if (filteredDirectTrajets.isNotEmpty)
            ...filteredDirectTrajets
                .map((directTrajet) => buildDirectTrajetCard(directTrajet))
                .toList(),

          // Display indirect trajets
          if (filteredIndirectTrajets.isNotEmpty)
            ...filteredIndirectTrajets
                .map((indirectTrajet) =>
                    buildIndirectTrajetCard(indirectTrajet, context))
                .toList()
        ],
      );
    } else {
      // No trajets found
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "😅",
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: MediaQuery.of(context).textScaleFactor * 40,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                "Oups, Vous n'avez pas encore sauvegarder de trajet.",
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: MediaQuery.of(context).textScaleFactor * 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }
  }

  bool isTrajetInTimeRange(TrajetDirectDto trajet, DateTime? dateToSearch) {
    if (dateToSearch == null) {
      return true; // No date specified, consider all trajets
    }
    DateTime dateToSearchWithoutTime = DateTime(
      dateToSearch.year,
      dateToSearch.month,
      dateToSearch.day,
    );

    DateTime trajetCreatedAt = DateTime(
      trajet.createdAt!.year,
      trajet.createdAt!.month,
      trajet.createdAt!.day,
    );

    // Check if trajet's createdAt is on the specified date

    Logger().e(dateToSearchWithoutTime);
    Logger().e(trajetCreatedAt);
    if (!trajetCreatedAt.isAtSameMomentAs(dateToSearchWithoutTime)) {
      return false;
    }
    return true;
  }

  bool isIndirectTrajetInTimeRange(
      TrajetIndirectDto indirectTrajet, DateTime? dateToSearch) {
    if (dateToSearch == null) {
      return true; // No date specified, consider all trajets
    }
    DateTime dateToSearchWithoutTime = DateTime(
      dateToSearch.year,
      dateToSearch.month,
      dateToSearch.day,
    );

    DateTime trajetCreatedAt = DateTime(
      indirectTrajet.createdAt!.year,
      indirectTrajet.createdAt!.month,
      indirectTrajet.createdAt!.day,
    );

    // Check if trajet's createdAt is on the specified date

    Logger().e(dateToSearchWithoutTime);
    Logger().e(trajetCreatedAt);
    if (!trajetCreatedAt.isAtSameMomentAs(dateToSearchWithoutTime)) {
      return false;
    }
    return true;
  }

  Widget buildDirectTrajetCard(TrajetDirectDto directTrajet) {
    // Placeholder code for displaying direct trajet card
    var scalFactor = MediaQuery.of(context).textScaler;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => directTrajetsHistoryDetails(
                    trajetDirectDto: directTrajet,
                  )),
        );
      },
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Trajet direct : ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w900),
                      ),
                      busNumero(directTrajet.numero, context),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            'Départ          : ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.visible,
                            directTrajet.depart.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            'Arrivé           : ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.visible,
                            directTrajet.arrive.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            'Fréquence   : ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.visible,
                            "De 5 à ${directTrajet.frequence.toString()} mn",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            'Distance      : ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${double.parse((directTrajet.distance).toStringAsFixed(2))} KM',
                            style: TextStyle(
                              overflow: TextOverflow.visible,
                              fontSize: 15,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            'Date             : ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.visible,
                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(directTrajet.createdAt!),
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      OpsServices.deleteDirectTraject(
                          directTrajet.id.toString());

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoriqueTrajet()),
                      );
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7, 7, 7, 4.63),
                            child: Text(
                              'Supprimer',
                              style: SafeGoogleFont(
                                'Red Hat Display',
                                fontSize: scalFactor.scale(12),
                                fontWeight: FontWeight.w700,
                                height: 1.3225,
                                color: Color.fromARGB(255, 97, 0, 0),
                              ),
                            ),
                          ),
                          Icon(Icons.remove_circle_sharp)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              IntrinsicWidth(
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Customize the button color
                  ),
                  child: Row(
                    children: [
                      Text("Plus de détails",
                          style: TextStyle(color: Colors.white)),
                      Icon(Icons.arrow_forward_ios, color: Colors.white),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget busNumero(numero, context) {
    return Container(
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                numero.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 21,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              width: 22,
              height: 24,
              child: Image.asset(
                'assets/page-1/images/vector-Bkv.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndirectTrajetCard(TrajetIndirectDto indirectTrajets, context) {
    List<String> ligneList = indirectTrajets.lignes.split('-');

    var scalFactor = MediaQuery.of(context).textScaler;

    return Card(
      color: Theme.of(context).primaryColor,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Trajet indirect : ",
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w900),
                ),
                for (String ligne in ligneList) busNumero(ligne, context),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'Départ          : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      indirectTrajets.depart.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'Arrivé           : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      indirectTrajets.arrive.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'Distance      : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${double.parse((indirectTrajets.distance).toStringAsFixed(2))} KM',
                      style: TextStyle(
                        overflow: TextOverflow.visible,
                        fontSize: 15,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'Date             : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(indirectTrajets.createdAt!),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  OpsServices.deleteInDirectTraject(
                      indirectTrajets.id.toString());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoriqueTrajet()),
                  );
                });
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 7, 7, 4.63),
                      child: Text(
                        'Supprimer',
                        style: SafeGoogleFont(
                          'Red Hat Display',
                          fontSize: scalFactor.scale(12),
                          fontWeight: FontWeight.w700,
                          height: 1.3225,
                          color: Color.fromARGB(255, 97, 0, 0),
                        ),
                      ),
                    ),
                    Icon(Icons.remove_circle_sharp)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
