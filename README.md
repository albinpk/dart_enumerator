# enumerator

A generated enum helper library for Dart.

```dart
// example.dart

import 'package:enumerator/enumerator.dart';

part 'example.g.dart';

@enumerator
enum Status { pending, success, error }

void main() {
  const status = Status.pending;

  // Getters
  print(status.isPending); // true
  print(status.isSuccess); // false
  print(status.isError); // false

  // From list of enum
  Status enum1 = Status.values.fromName('pending');
  Status? enum2 = Status.values.fromNameOrNull('something');

  // From set of enum
  Status enum3 = Status.values.toSet().fromName('error');
  Status? enum4 = Status.values.toSet().fromNameOrNull(null);

  // Map to function
  int value1 = status.map(
    pending: () => 1,
    success: () => 2,
    error: () => 3,
  );

  // Map to function (optional)
  String? value2 = status.mapOrNull(
    success: () => 'Success',
    // error: () { ... },
  );

  // Check if enum is in given iterable
  status.isIn({.pending, .error}); // true
}


// Enum with custom lookup field.

@enumerator
enum Role {
  admin('ROLE-ADMIN'),
  user('ROLE-USER'),
  guest('ROLE-GUEST');

  const Role(this.apiValue);

  @enumLookup
  final String apiValue;
}

void fn() {
  final role = Role.values.fromApiValue('ROLE-ADMIN');
  print(role); // Role.admin
}
```
