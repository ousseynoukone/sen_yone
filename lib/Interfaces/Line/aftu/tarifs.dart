import 'package:flutter/material.dart';

class TarifView extends StatelessWidget {
  final List<String> tarifs;

  TarifView({required this.tarifs});

  @override
  Widget build(BuildContext context) {
    // Remove occurrences of '………' from each string in tarifs
    List<String> formattedTarifs =
        tarifs.map((tarif) => tarif.replaceAll('…', '')).toList();
    var ScallFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarifs'),
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text('Section')),
          DataColumn(label: Text('Lieux et prix')),
        ],
        rows: formattedTarifs.map(
          (tarif) {
            // Split each string into section and price
            final sections = tarif.split(':');
            if (sections.length == 2) {
              final section = sections[0].trim();
              final price = sections[1].trim();

              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      style: TextStyle(fontSize: 12 * ScallFactor),

                      section,
                      // Apply styling if needed
                    ),
                  ),
                  DataCell(
                    Text(
                      style: TextStyle(fontSize: 12 * ScallFactor),

                      price,
                      // Apply styling if needed
                    ),
                  ),
                ],
              );
            } else {
              // Handle improperly formatted strings
              return DataRow(cells: [
                DataCell(Text('Invalid Format')),
                DataCell(Text('')),
              ]);
            }
          },
        ).toList(),
      ),
    );
  }
}
