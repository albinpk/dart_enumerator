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

extension StatusEnumMapExtension on Status {
  T map<T>({
    required T Function() pending,
    required T Function() success,
    required T Function() error,
  }) => switch (this) {
    .pending => pending(),
    .success => success(),
    .error => error(),
  };

  T? mapOrNull<T>({
    T Function()? pending,
    T Function()? success,
    T Function()? error,
  }) => switch (this) {
    .pending => pending?.call(),
    .success => success?.call(),
    .error => error?.call(),
  };
}
