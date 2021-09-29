import 'dart:async';

class MultiStreamController<T> {
  MultiStreamController(
      {List<Stream<T>> additionalStreams = const [],
      this.onListen,
      this.onCancel}) {
    if (additionalStreams.isNotEmpty) addStreams(additionalStreams);
  }

  final Function()? onListen;
  final Function()? onCancel;

  StreamController<T>? _nullableStreamController;

  StreamController<T> get _streamController =>
      _nullableStreamController ??= StreamController<T>.broadcast(
          onListen: onListen,
          onCancel: () {
            onCancel?.call();
            close();
          });

  Stream<T> get stream => _streamController.stream;

  void emit(T event) {
    if (_streamController.hasListener) _streamController.add(event);
  }

  void addStream(Stream<T> source) {
    _streamController.addStream(source);
  }

  void addStreams(List<Stream<T>> sources) {
    for (final source in sources) {
      _streamController.addStream(source);
    }
  }

  Future<void> close() async {
    await _nullableStreamController?.close();
    _nullableStreamController = null;
  }
}
