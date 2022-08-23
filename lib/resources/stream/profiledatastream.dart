import 'dart:async';

import 'package:coupled/resources/repository.dart';

class ProfileBasicDataStream {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getbasesettingtData() async {
    await _getAll.addStream(repository.fetchBaseSettings().asStream());
  }

  dispose() {
    _getAll.close();
  }
}
