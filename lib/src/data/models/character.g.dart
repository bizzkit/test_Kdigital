// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      json['name'] as String,
      json['image'] as String,
      (json['id'] as num).toInt(),
      json['status'] as String,
      DateTime.parse(json['created'] as String),
      (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      json['gender'] as String,
      CharacterLocation.fromJson(json['location'] as Map<String, dynamic>),
      CharacterLocation.fromJson(json['origin'] as Map<String, dynamic>),
      json['species'] as String,
      json['type'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created.toIso8601String(),
    };
