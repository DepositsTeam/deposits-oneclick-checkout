import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class Place {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;
  String? state;
  String? country;
  String? formattedAddress;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
    this.state,
    this.country,
    this.formattedAddress,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode, state: $state, country: $country, formattedAddress: $formattedAddress )';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;
  
  static final String androidKey =  dotenv.env['apiMapKey']!;
  static final String iosKey = dotenv.env['apiMapKey']!;
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey&sessiontoken=$sessionToken';
    // print(request);
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place();
        // place.formattedAddress  = result['result']['formatted_address'];
        // final locations = components.where((element){
        //   return 
        //   element['types'].contains("street_number") || 
        //   element['types'].contains("route") || 
        //   element['types'].contains("administrative_area_level_2")||
        //   element['types'].contains("administrative_area_level_1") || 
        //   element['types'].contains("country") || 
        //   element['types'].contains("postal_code");
        // }).toList();
        // print(locations);
        // place.streetNumber =locations.length >=1?locations[0]['long_name']:"";
        // place.street =locations.length >=2?locations[1]['long_name']:"";
        // place.city =locations.length >=3?locations[2]['long_name']:"";
        // place.state =locations.length >=4?locations[3]['short_name']:"";
        // place.country =locations.length >=5? locations[4]['short_name'] : "";    
        // place.zipCode=locations.length >=6?locations[5]['long_name']: "";
        for (var c in components) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('administrative_area_level_2')) {
            place.city = c['long_name'];
          }
          if (type.contains('administrative_area_level_1')) {
            place.state= c['long_name'];
          }
          if (type.contains('country')) {
            place.country= c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        }
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}