// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'example.dart';

// **************************************************************************
// EnumeratorGenerator
// **************************************************************************

extension StatusEnumPredicateExtension on Status {
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

extension StatusEnumIsInExtension on Status {
  bool isIn(Iterable<Status> values) => values.contains(this);
}

extension RoleEnumPredicateExtension on Role {
  bool get isAdmin => this == .admin;

  bool get isUser => this == .user;

  bool get isGuest => this == .guest;
}

extension RoleEnumIterableExtension on Iterable<Role> {
  Role fromName(String name) => .values.firstWhere((e) => e.name == name);

  Role? fromNameOrNull(String? name) =>
      .values.firstWhereOrNull((e) => e.name == name);
}

extension RoleEnumMapExtension on Role {
  T map<T>({
    required T Function() admin,
    required T Function() user,
    required T Function() guest,
  }) => switch (this) {
    .admin => admin(),
    .user => user(),
    .guest => guest(),
  };

  T? mapOrNull<T>({
    T Function()? admin,
    T Function()? user,
    T Function()? guest,
  }) => switch (this) {
    .admin => admin?.call(),
    .user => user?.call(),
    .guest => guest?.call(),
  };
}

extension RoleEnumIsInExtension on Role {
  bool isIn(Iterable<Role> values) => values.contains(this);
}

extension RoleEnumLookupExtension on Iterable<Role> {
  Role fromApiValue(String apiValue) =>
      .values.firstWhere((e) => e.apiValue == apiValue);

  Role? fromApiValueOrNull(String? apiValue) =>
      .values.firstWhereOrNull((e) => e.apiValue == apiValue);
}
