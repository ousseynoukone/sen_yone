import 'package:flutter/material.dart';

class TarifsViewer extends StatelessWidget {
  final String tarifs;

  const TarifsViewer({Key? key, required this.tarifs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace ellipsis characters with appropriate spacing
    String formattedTarifs = tarifs.replaceAll('………', '');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tarification"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formattedTarifs,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
