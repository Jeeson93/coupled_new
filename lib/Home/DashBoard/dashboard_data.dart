import 'dart:async';

import 'package:coupled/resources/repository.dart';

class DashBoardData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getDashBoardData() async {
    await _getAll.addStream(repository.fetchMembershipPlans().asStream());
  }

  dispose() {
    _getAll.close();
  }
}
