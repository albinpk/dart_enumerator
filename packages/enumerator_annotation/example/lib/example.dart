// ignore: lines_longer_than_80_chars
// ignore_for_file: avoid_print, unused_local_variable, omit_local_variable_types, prefer_final_locals

import 'package:enumerator_annotation/enumerator_annotation.dart';

part 'example.enum.dart';

@enumerator
enum Status { pending, success, error }

void main() {
  const status = Status.pending;

  // Predicate getters derived from enum value names
  print(status.isPending); // true
  print(status.isSuccess); // false
  print(status.isError); // false

  // Lookup by name
  Status enum1 = Status.values.fromName('pending');
  Status? enum2 = Status.values.fromNameOrNull('something');

  // Functional mapping
  int value1 = status.map(
    pending: () => 1,
    success: () => 2,
    error: () => 3,
  );

  // Optional mapping
  String? value2 = status.mapOrNull(
    success: () => 'Success',
    // error: () { ... },
  );

  // Membership check
  status.isIn({.pending, .error}); // true
}

// Enum with custom lookup field.
@enumerator
enum Role {
  admin('ROLE-ADMIN'),
  user('ROLE-USER'),
  guest('ROLE-GUEST'),
  ;

  const Role(this.apiValue);

  @enumLookup
  final String apiValue;
}

void fn() {
  final role = Role.values.fromApiValue('ROLE-ADMIN');
  print(role); // Role.admin
}
