extension EmptyCheckOnStringNullable on String? {
  bool get checkNotEmpty => (this ?? '').isNotEmpty;

  bool get checkEmpty => (this ?? '').isEmpty;
}

extension EmptyCheckOnMapNullable on Map? {
  bool get checkNotEmpty => (this ?? {}).isNotEmpty;

  bool get checkEmpty => (this ?? {}).isEmpty;
}

extension EmptyCheckOnListNullable on List? {
  bool get checkNotEmpty => (this ?? []).isNotEmpty;

  bool get checkEmpty => (this ?? []).isEmpty;
}

extension FirstOrLastElementInList<T> on List<T>? {
  T? get firstElement => checkNotEmpty ? this!.first : null;

  T? get lastElement => checkNotEmpty ? this!.last : null;
}