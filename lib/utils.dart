import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models/pokemon_card.dart';
import 'models/pokemon_detail.dart';

Future<List<PokemonCard>> fetchPokemonData() async {
  final response = await http.Client()
      .get(Uri.parse('https://api.tcgdex.net/v2/en/sets/sv03.5'));
  return compute(
    parsePokemonCards,
    response.body,
  );
}

List<PokemonCard> parsePokemonCards(String responseBody) {
  final parsed = jsonDecode(responseBody) as Map<String, dynamic>;

  return parsed['cards']
      .map<PokemonCard>((json) => PokemonCard.fromJson(json))
      .toList();
}


Future<PokemonDetail> fetchPokemonById(String localId) async {
  final response = await http.Client()
      .get(Uri.parse('https://api.tcgdex.net/v2/en/sets/sv03.5/$localId'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load Pokémon card with ID $localId');
  }

  return compute(parsePokemonDetail, response.body);
}

PokemonDetail parsePokemonDetail(String responseBody) {
  final parsed = jsonDecode(responseBody) as Map<String, dynamic>;
  return PokemonDetail.fromJson(parsed);
}


