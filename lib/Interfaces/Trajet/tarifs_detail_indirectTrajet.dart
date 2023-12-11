import 'package:SenYone/Models/Dto/undirect_trajet_dto.dart';
import 'package:flutter/material.dart';

class IndirectTarifsViewer extends StatelessWidget {
  final List<IndirectLine> indirectLinesList;

  const IndirectTarifsViewer({Key? key, required this.indirectLinesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tarification"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: indirectLinesList.length,
            itemBuilder: (context, index) {
              IndirectLine indirectLine = indirectLinesList[index];

              // Replace ellipsis characters with appropriate spacing
              String formattedTarifs =
                  indirectLine.tarifs.replaceAll('………', '');

              return Card(
                color: Theme.of(context).primaryColor,
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tarifs pour la ligne ${indirectLine.numero}",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        formattedTarifs,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
