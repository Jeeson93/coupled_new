import 'dart:async';

import 'package:coupled/models/notification_model.dart';
import 'package:coupled/resources/repository.dart';

class NotificationInfiniteList {
  Stream<NotificationModel1>? stream;
  bool hasMore = false;

  bool? _isLoading;
  NotificationModel1? _data;
  StreamController<NotificationModel1>? _controller;

  NotificationInfiniteList({String type = ''}) {
    _data = new NotificationModel1();
    _controller = StreamController<NotificationModel1>.broadcast();
    _isLoading = false;
    stream = _controller?.stream.map((NotificationModel1 postsData) {
      return postsData;
    });
    hasMore = true;
    refresh(type);
  }

  Future<void> refresh(String type) {
    return loadMore(clearCachedData: true, page: 1, type: type);
  }

  Future<void> loadMore(
      {bool clearCachedData = true,
      int page = 0,
      String type = '',
      int total = 0,
      int to = 0}) {
    print(type);
    if (clearCachedData) {
      _data = new NotificationModel1();
      hasMore = true;
    }
    if (_isLoading! || !hasMore) {
      return Future.value();
    }
    _isLoading = true;
    return Repository()
        .getNotifications(path: type, perPageCount: 10, page: page)
        .then((postsData) {
      _isLoading = false;
      _data = postsData;
      print(postsData.response?.data?.length);
      hasMore = (postsData.response?.to != postsData.response?.total);
      _controller?.add(_data!);
    }, onError: (v) {
      _isLoading = false;
      hasMore = false;
      _controller!.add(_data!);
      print(v);
    });
  }
}
