import 'package:json_annotation/json_annotation.dart';
import 'package:kdigital_test/src/data/models/character_location.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterLocation origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  Character(
      this.name,
      this.image,
      this.id,
      this.status,
      this.created,
      this.episode,
      this.gender,
      this.location,
      this.origin,
      this.species,
      this.type,
      this.url);

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
