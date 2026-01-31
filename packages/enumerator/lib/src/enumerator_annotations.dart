import 'package:meta/meta_meta.dart';

/// {@template enumerator.enumerator}
/// [Enum]s annotated with [Enumerator] will generate
/// helper methods and extensions for the enum.
/// {@endtemplate}
@Target({.enumType})
class Enumerator {
  /// {@macro enumerator.enumerator}
  const Enumerator();
}

/// {@macro enumerator.enumerator}
const enumerator = Enumerator();
