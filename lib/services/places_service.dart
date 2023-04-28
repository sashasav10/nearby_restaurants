import 'package:http/http.dart' as http;
import 'package:nearby_restaurants/models/place.dart';
import 'package:nearby_restaurants/models/place_item.dart';
import 'dart:convert' as convert;

import 'package:nearby_restaurants/models/place_search.dart';

class PlacesService {
  final key = 'AIzaSyBrVfPW1lLg8V1cD29xciyDZewfk5jOmvI';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key';
    var response = await http.get(Uri.parse(url));
    print(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  void getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=AUjq9jlF4fNNK26S9Zg_NHDL7vlGOoFaVSr7BYFLh_pX3BGQ5MwmwnE3wbpYYLVNZIOvBe9vlt1BX5variFrZ4sU495rLXgWtnmrCnyPFKTPGOM_9HB5F5xXBEHzgCxPattpQd_ldx1NjGYf5fCZ-QrW30W0xlW0paUyPpQaxw5L56eGN0-l&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    print("OOPP");
    print(jsonResult);
    //return Place.fromJson(jsonResult);
  }

  Future<List<Placeitem>> getPlaces(
      double lat, double lng, String placeType) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;

    return jsonResults.map((place) => Placeitem.fromJson(place)).toList();
  }
}
