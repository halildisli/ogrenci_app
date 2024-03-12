import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ogretmen.dart';
import 'package:http/http.dart' as http;

class DataService{
  final String baseUrl="https://65f072bada8c6584131bcdaf.mockapi.io";
  Future<Ogretmen> ogretmenIndir() async {

    final response = await http.get(Uri.parse("$baseUrl/ogretmen/1"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Ogretmen.fromMap(jsonDecode(response.body));
    }
    else {
      throw Exception('Ogretmen indirilemedi! ${response.statusCode}');
    }
  }
}

final dataServiceProvider=Provider((ref){
    return DataService();
});
