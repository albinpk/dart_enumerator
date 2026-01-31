// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'example.dart';

// **************************************************************************
// EnumeratorGenerator
// **************************************************************************

extension StatusEnumBooleanExtension on Status {
  bool get isPending => this == .pending;

  bool get isSuccess => this == .success;

  bool get isError => this == .error;
}

extension StatusEnumIterableExtension on Iterable<Status> {
  Status fromName(String name) => .values.firstWhere((e) => e.name == name);

  Status? fromNameOrNull(String? name) =>
      .values.firstWhereOrNull((e) => e.name == name);
}
