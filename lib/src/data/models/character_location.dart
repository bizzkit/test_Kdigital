import 'package:json_annotation/json_annotation.dart';

part 'character_location.g.dart';

@JsonSerializable()
class CharacterLocation {
  final String name;
  final String url;

  CharacterLocation(this.name, this.url);

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterLocationToJson(this);
}
