import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/version_dto.dart';
final dioProvider = Provider<Dio>((ref) {
  var baseOptions = BaseOptions(
    baseUrl:'https://backend.smallwords.samyn.ovh',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );
  //Construction de Dio avec les options
  return Dio(baseOptions);
});

//Provider du numéro de version du backend
final backendVersionProvider = FutureProvider<String>((ref) async {
  // On récupère l'instance de Dio
final Dio dio = ref.read(dioProvider);

  // On fait une requête Get sur l'URL /up
final Response response = await dio.get('/up');

var jsonAsString = response.toString();
var json = jsonDecode(jsonAsString);
  final VersionDTO versionDTO = VersionDTO.fromJson(json);


  //On retourne la réponse
return versionDTO.version;
});