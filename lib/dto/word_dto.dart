import 'package:freezed_annotation/freezed_annotation.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

part '../word_dto.g.dart';

@JsonSerializable() // Va permettre de générer des méthodes from et toJSON
class WordDTO {

  // Constructeur
  WordDTO(this.uid, this.author, this.content, this.latitude, this.longitude );

  // Attributs
  final int? uid;
  final String? author;
  final String? content;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toJson() => _$WordDTOToJson(this);

  factory WordDTO.fromJson(Map<String, dynamic> json) => _$WordDTOFromJson(json);

  // Permet de créer un WordDTO avec le résultat d'une requete SQLite
static fromMap(Map<String, Object?>map) => WordDTO.fromJson(map);


}