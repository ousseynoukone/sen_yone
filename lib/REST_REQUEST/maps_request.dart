import 'package:SenYone/Shared/shared_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeoapifyAutocompleteApi {
  // Replace with your Geoapify API key
    var apiKey =  SharedConfig().geoApiFyApiKeyForPredictionLocation;


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
