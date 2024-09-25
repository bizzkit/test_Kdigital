import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:kdigital_test/src/data/models/character.dart';
import 'package:kdigital_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  String baseURL = "https://rickandmortyapi.com/api";
  final Client client;

  CharactersRepositoryImpl(this.client);

  Future<bool> _isInternetAvailable(int page) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    print("Connectivity result: $connectivityResult");

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final response = await client.get(
            Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'));
        print("API response status: ${response.statusCode}");
        return response.statusCode == 200;
      } catch (e) {
        print('Error during internet check: $e');
        return false;
      }
    }
    return false;
  }

  @override
  Future<List<Character>?> getCharacters(int page) async {
    if (await _isInternetAvailable(page)) {
      throw Exception("No internet connection");
    }

    try {
      final charResult = await client.get(
        Uri.parse("$baseURL/character/?page=$page"),
      );

      if (charResult.statusCode != 200) {
        print("Failed to load characters: ${charResult.statusCode}");
        return null;
      }

      final jsonMap = json.decode(charResult.body) as Map<String, dynamic>;
      if (jsonMap["results"] == null || jsonMap["results"] is! List) {
        print("Invalid data format");
        return null;
      }

      return List.of(
        (jsonMap["results"] as List<dynamic>).map(
          (value) => Character.fromJson(value),
        ),
      );
    } catch (e) {
      print("Error fetching characters: $e");
      return null;
    }
  }
}
