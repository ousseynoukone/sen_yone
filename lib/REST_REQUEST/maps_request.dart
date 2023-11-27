import 'package:SenYone/Shared/shared_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeoapifyApi {
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



   Future<Map<String, double>?> getGeocodeCoordinates(String query) async {
    final apiUrl =
        'https://api.geoapify.com/v1/geocode/search?text=$query,Dakar,Sénégal&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['features'] != null && data['features'].isNotEmpty) {
          final coordinates = data['features'][0]['geometry']['coordinates'];
          final double latitude = coordinates[1];
          final double longitude = coordinates[0];

          return {'latitude': latitude, 'longitude': longitude};
        } else {
          print('No features found in the response.');
          return null;
        }
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        print('Failed to load data. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle potential errors such as a timeout or network error.
      print('Error: $e');
      return null;
    }
  }
}


