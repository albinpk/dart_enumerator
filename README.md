### enumerator

An enum helper library for Dart.

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
}
```
