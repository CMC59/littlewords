import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/dio.provider.dart';


class Version extends StatelessWidget {
  const Version({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget ? child) {
        // On utilise ref pour "Lire" notre provider
        final AsyncValue<String> read = ref.watch(backendVersionProvider);

        return read.when(data: (String data) {
          return Text(data);
        }, error: (error, stack) {
          return const Text('Error');
        }, loading: () {
          return const CircularProgressIndicator();
        });
        return Text('You have ...');
      },
    );
  }
}