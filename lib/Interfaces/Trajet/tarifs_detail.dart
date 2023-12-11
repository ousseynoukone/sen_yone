import 'package:flutter/material.dart';

class TarifsViewer extends StatelessWidget {
  final String tarifs;
  final  numero;

  const TarifsViewer({Key? key, required this.tarifs, required this.numero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace ellipsis characters with appropriate spacing
    String formattedTarifs = tarifs.replaceAll('………', '');

    double screenWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text("Tarification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth > 600 ? 40.0 : 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tarifs de la ligne $numero",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth > 600
                            ? 24 * textScaleFactor
                            : 18 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenWidth > 600 ? 20 : 10),
                    Text(
                      formattedTarifs,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth > 600
                            ? 18 * textScaleFactor
                            : 14 * textScaleFactor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
