import 'package:SenYone/Shared/shared_config.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeoapifyAutocompleteApi {
  final String apiKey =
      SharedConfig().geoApiFyApiKeyForPredictionLocation; // Replace with your Geoapify API key

  Future<List<String>> getAutocompleteSuggestions(String query) async {
    // Define bounding box coordinates for Dakar region
    double minLongitude = -17.594604;
    double minLatitude = 14.570293;
    double maxLongitude = -17.138672;
    double maxLatitude = 14.932843;
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.geoapify.com/v1/geocode/autocomplete?'
          'text=$query&'
          'apiKey=$apiKey&'
          'filter=rect:$minLongitude,$minLatitude,$maxLongitude,$maxLatitude&'
          'type=amenity',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('features')) {
          final List<dynamic> features = data['features'];
          print(features);

          return features.map<String>((feature) {
            return feature['properties']['address_line1'] as String;
          }).toList();
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}

class MyAutocompleteDropdown extends StatefulWidget {
  @override
  _MyAutocompleteDropdownState createState() => _MyAutocompleteDropdownState();
}

class _MyAutocompleteDropdownState extends State<MyAutocompleteDropdown> {
  final GeoapifyAutocompleteApi geoapifyApi = GeoapifyAutocompleteApi();
  List<String> autocompleteSuggestions = [];
  final TextEditingController _controllerDespature = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          children: [
            TextField(
              controller: _controllerDespature,
              decoration: InputDecoration(
                hintText: 'Lieu de départ...',
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                ),
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              onChanged: (value) async {
                final suggestions =
                    await geoapifyApi.getAutocompleteSuggestions(value);
                setState(() {
                  autocompleteSuggestions = suggestions;
                });
              },
            ),
            if (autocompleteSuggestions.isNotEmpty)
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
                  itemCount: autocompleteSuggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = autocompleteSuggestions[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _controllerDespature.text = suggestion;
                          autocompleteSuggestions = []; // Clear suggestions
                          FocusScope.of(context).unfocus(); // Dismiss keyboard
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
    );
  }
}
