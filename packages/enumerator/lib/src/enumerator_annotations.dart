import 'package:meta/meta_meta.dart';

/// {@template enumerator.enumerator}
/// [Enum]s annotated with [Enumerator] will generate
/// helper methods and extensions for the enum.
/// {@endtemplate}
@Target({.enumType})
class Enumerator {
  /// {@macro enumerator.enumerator}
  const Enumerator({
    this.predicate,
    this.iterableExtension,
  });

  /// Whether to generate predicate getters. Default is `true`.
  ///
  /// eg.
  /// ```dart
  /// @Enumerator(predicate: true)
  /// enum Status {good, bad}
  ///
  /// final status = Status.good;
  /// status.isGood; // true
  /// status.isBad; // false
  /// ```
  final bool? predicate;

  /// Whether to generate iterable extensions. Default is `true`.
  ///
  /// eg.
  /// ```dart
  /// @Enumerator(iterableExtension: true)
  /// enum Status {good, bad}
  ///
  /// Status status = Status.values.fromName('good');
  /// Status? status = Status.values.fromNameOrNull('something');
  /// ```
  final bool? iterableExtension;
}

/// {@macro enumerator.enumerator}
const enumerator = Enumerator();
