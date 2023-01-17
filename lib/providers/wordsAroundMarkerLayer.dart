// Permet d'officher les mots sur la cartes
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/dto/word_dto.dart';
import 'package:littlewords/providers/words_around.provider.dart';

class WordsAroundMarkerLayer extends ConsumerWidget {
  const WordsAroundMarkerLayer({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return ref
        .watch(wordsAroundProvider) // utilisation du provider
        .when(data: _onData, error: _onError, loading: _onLoading);
  }

  Widget _onData(final List<WordDTO> words) {
    final List<Marker> markers = <Marker>[]; // init du tableau de markers
    for (final WordDTO w in words) {
      // on construit un marker pour chaque mot
      final LatLng wordPosition =
          LatLng(w.latitude!, w.longitude!); // position du mot
      final Marker marker = Marker(
          point: wordPosition,
          builder: (context) {
            return Icon(Icons.mail, size: 32,); // contenu du marker
          }); // Marker
      // on ajoute le marker à la liste des resultats
      markers.add(marker);
    }
    return MarkerLayer(markers: markers); // retourne un layer de markers
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return Container(
      color: Colors.red,
    );
  }

  Widget _onLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

