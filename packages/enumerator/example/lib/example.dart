// ignore: lines_longer_than_80_chars
// ignore_for_file: avoid_print, unused_local_variable, omit_local_variable_types, prefer_final_locals

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
