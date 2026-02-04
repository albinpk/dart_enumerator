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
    this.iterableLookup,
    this.map,
    this.isIn,
    this.customGetters,
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
  /// @Enumerator(iterableLookup: true)
  /// enum Status {good, bad}
  ///
  /// Status status = Status.values.fromName('good');
  /// Status? status = Status.values.fromNameOrNull('something');
  /// ```
  final bool? iterableLookup;

  /// Whether to generate `map` and `mapOrNull` callbacks. Default is `true`.
  ///
  /// eg.
  /// ```dart
  /// @Enumerator(map: true)
  /// enum Status {good, bad}
  ///
  /// const status = Status.good;
  ///
  /// int result = status.map(
  ///   good: () => 1,
  ///   bad: () => 2,
  /// );
  /// ```
  final bool? map;

  /// Whether to generate `isIn` method. Default is `true`.
  ///
  /// eg.
  /// ```dart
  /// @Enumerator(isIn: true)
  /// enum Status {good, bad, unknown}
  ///
  /// const status = Status.good;
  ///
  /// bool result = status.isIn({.good, .unknown});
  /// ```
  final bool? isIn;

  // TODO(albin):
  final Set<Symbol>? customGetters;
}

/// {@macro enumerator.enumerator}
const enumerator = Enumerator();

@Target({.field})
class EnumLookup {
  const EnumLookup();
}

const enumLookup = EnumLookup();
