import 'dart:async';

import 'package:async/async.dart';

class MergedStreamController<T> {
  MergedStreamController._(this._streamController, this._mergedStream);

  factory MergedStreamController(
      {List<Stream<T>> streamsToMerge = const [],
      void onListen()?,
      void onPause()?,
      void onResume()?,
      FutureOr<void> onCancel()?}) {
    final streamController = StreamController<T>(
      onListen: onListen,
      onCancel: onCancel,
      onPause: onPause,
      onResume: onResume,
    );

    final mergedStream =
        StreamGroup.merge([streamController.stream, ...streamsToMerge]);

    return MergedStreamController._(streamController, mergedStream);
  }

  factory MergedStreamController.broadcast(
      {List<Stream<T>> streamsToMerge = const [],
      void onListen()?,
      FutureOr<void> onCancel()?}) {
    final streamController = StreamController<T>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
    );

    final mergedStream = StreamGroup.mergeBroadcast(
        [streamController.stream, ...streamsToMerge]);

    return MergedStreamController._(streamController, mergedStream);
  }

  late Stream<T> _mergedStream;
  late StreamController<T> _streamController;

  Stream<T> get stream => _mergedStream;

  void emit(T event) {
    if (_streamController.hasListener) _streamController.sink.add(event);
  }

  Future<void> close() async {
    await _streamController.close();
  }
}
