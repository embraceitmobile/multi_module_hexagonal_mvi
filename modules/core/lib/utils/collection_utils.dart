extension CollectionExtension<T> on Iterable<T?> {
  Iterable<T> get filterNotNull => List<T>.from(where((e) => e != null));
}

extension ListExtension<T> on List<T?> {
  List<T> get filterNotNull => List<T>.from(where((e) => e != null));
}
