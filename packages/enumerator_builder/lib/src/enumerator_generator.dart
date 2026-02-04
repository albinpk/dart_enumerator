import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:enumerator_annotation/enumerator_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// Generator for [Enumerator] annotation.
class EnumeratorGenerator extends GeneratorForAnnotation<Enumerator> {
  const EnumeratorGenerator({required this.options});

  final BuilderOptions options;

  @override
  String? generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element case final EnumElement enumElement) {
      final meta = annotation.parse(options);
      final generated = Library((libraryBuilder) {
        libraryBuilder.body.addAll([
          if (meta.predicate ?? true) _buildPredicate(enumElement),
          if (meta.iterableLookup ?? true) _buildIterableLookup(enumElement),
          if (meta.map ?? true) _buildMap(enumElement),
          if (meta.isIn ?? true) _buildIsIn(enumElement),
          ?_buildCustomLookup(element),
          // if (meta.customGetters?.isNotEmpty ?? false)
          //   _buildCustomGetterExtension(element, meta.customGetters!),
        ]);
      });

      final emitter = DartEmitter(
        useNullSafetySyntax: true,
        orderDirectives: true,
        allocator: Allocator(),
      );

      return DartFormatter(
        languageVersion: DartFormatter.latestLanguageVersion,
      ).format(generated.accept(emitter).toString());
    }

    return null;
  }

  Extension _buildPredicate(EnumElement element) {
    return Extension((extBuilder) {
      extBuilder
        ..name = '${element.name}EnumPredicateExtension'
        ..on = Reference(element.name)
        ..methods.addAll(
          element.fields.where((f) => f.isEnumConstant).map((f) {
            return Method((m) {
              m
                ..name = 'is${f.name?.capitalize ?? ''}'
                ..type = .getter
                ..returns = const Reference('bool')
                ..lambda = true
                ..body = Code('this == .${f.name}');
            });
          }),
        );
    });
  }

  Extension _buildIterableLookup(EnumElement element) {
    return Extension((extBuilder) {
      extBuilder
        ..name = '${element.name}EnumIterableExtension'
        ..on = Reference('Iterable<${element.name}>')
        ..methods.addAll([
          Method((m) {
            m
              ..name = 'fromName'
              ..requiredParameters = ListBuilder([
                Parameter((p) {
                  p
                    ..name = 'name'
                    ..type = const Reference('String');
                }),
              ])
              ..returns = Reference(element.name)
              ..lambda = true
              ..body = const Code('.values.firstWhere((e) => e.name == name)');
          }),

          Method((m) {
            m
              ..name = 'fromNameOrNull'
              ..requiredParameters = ListBuilder([
                Parameter((p) {
                  p
                    ..name = 'name'
                    ..type = const Reference('String?');
                }),
              ])
              ..returns = Reference('${element.name}?')
              ..lambda = true
              ..body = const Code(
                '.values.firstWhereOrNull((e) => e.name == name)',
              );
          }),
        ]);
    });
  }

  Extension? _buildCustomLookup(EnumElement element) {
    final fields = element.fields.where((e) {
      return e.isFinal && !e.hasInitializer && e.parse != null;
    }).toList();

    if (fields.isEmpty) return null;

    // ignore: avoid_positional_boolean_parameters
    Method buildMethod(FieldElement s, bool nullable) {
      final name = s.name!;
      final type = s.type;
      return Method((m) {
        m
          ..name = 'from${name.capitalize}${nullable ? 'OrNull' : ''}'
          ..requiredParameters = ListBuilder([
            Parameter((p) {
              p
                ..name = name
                ..type = !nullable || type.nullabilitySuffix == .question
                    ? Reference('$type')
                    : Reference('$type?');
            }),
          ])
          ..returns = Reference('${element.name}${nullable ? '?' : ''}')
          ..lambda = true
          ..body = Code(
            '.values.firstWhere${nullable ? 'OrNull' : ''}((e) => e.$name == $name)',
          );
      });
    }

    return Extension((extBuilder) {
      extBuilder
        ..name = '${element.name}EnumLookupExtension'
        ..on = Reference('Iterable<${element.name}>')
        ..methods.addAll([
          for (final s in fields) ...[
            buildMethod(s, false),
            buildMethod(s, true),
          ],
        ]);
    });
  }

  Extension _buildMap(EnumElement element) {
    Method buildMap({required bool nullable}) {
      final nullMark = nullable ? '?' : '';
      return Method((m) {
        m
          ..name = nullable ? 'mapOrNull' : 'map'
          ..types = ListBuilder([const Reference('T')])
          ..optionalParameters = ListBuilder(
            element.constants.map((e) {
              return Parameter((p) {
                p
                  ..name = e.name!
                  ..named = true
                  ..required = !nullable
                  ..type = Reference('T Function()$nullMark');
              });
            }),
          )
          ..returns = Reference('T$nullMark')
          ..lambda = true
          ..body = Code(
            ' switch (this) {'
            '${element.constants.map((e) {
              return ' .${e.name} => ${e.name}${nullable ? '?.call' : ''}()';
            }).join(',')}'
            ' }',
          );
      });
    }

    return Extension((extBuilder) {
      extBuilder
        ..name = '${element.name}EnumMapExtension'
        ..on = Reference('${element.name}')
        ..methods.addAll([
          buildMap(nullable: false),
          buildMap(nullable: true),
        ]);
    });
  }

  /*
  Extension _buildCustomGetterExtension(
    EnumElement element,
    Set<Symbol> getterSymbols,
  ) {
    final fields = element.fields
        .where((e) => e.isFinal && !e.hasInitializer)
        .toList();

    Method buildMethod(Symbol symbol, bool nullable) {
      final name = symbol.name;
      final type = fields.firstWhere((e) => e.name == name).type;
      return Method((m) {
        m
          ..name = 'from${name.capitalize}${nullable ? 'OrNull' : ''}'
          ..requiredParameters = ListBuilder([
            Parameter((p) {
              p
                ..name = name
                ..type = !nullable || type.nullabilitySuffix == .question
                    ? Reference('$type')
                    : Reference('$type?');
            }),
          ])
          ..returns = Reference('${element.name}${nullable ? '?' : ''}')
          ..lambda = true
          ..body = Code(
            '.values.firstWhere${nullable ? 'OrNull' : ''}((e) => e.$name == $name)',
          );
      });
    }

    final validSymbols = getterSymbols.where(
      (e) => fields.any((f) => f.name == e.name),
    );

    return Extension((extBuilder) {
      extBuilder
        ..name = '${element.name}EnumCustomGetterExtension'
        ..on = Reference('Iterable<${element.name}>')
        ..methods.addAll([
          for (final s in validSymbols) ...[
            buildMethod(s, false),
            buildMethod(s, true),
          ],
        ]);
    });
  }
  */

  Extension _buildIsIn(EnumElement element) {
    return Extension((extBuilder) {
      extBuilder
        ..name = '${element.name}EnumIsInExtension'
        ..on = Reference(element.name)
        ..methods.add(
          Method((m) {
            m
              ..name = 'isIn'
              ..requiredParameters = ListBuilder([
                Parameter((p) {
                  p
                    ..name = 'values'
                    ..type = Reference('Iterable<${element.name}>');
                }),
              ])
              ..returns = const Reference('bool')
              ..lambda = true
              ..body = const Code('values.contains(this)');
          }),
        );
    });
  }
}

extension on String {
  String get capitalize => this[0].toUpperCase() + substring(1);
}

extension on ConstantReader {
  Enumerator parse(BuilderOptions options) {
    final map = options.config;
    return Enumerator(
      predicate:
          objectValue.getField('predicate')?.toBoolValue() ??
          map['predicate'] as bool?,
      iterableLookup:
          objectValue.getField('iterableLookup')?.toBoolValue() ??
          map['iterableLookup'] as bool?,
      map: objectValue.getField('map')?.toBoolValue() ?? map['map'] as bool?,
      isIn: objectValue.getField('isIn')?.toBoolValue() ?? map['isIn'] as bool?,
      customGetters: objectValue
          .getField('customGetters')
          ?.toSetValue()
          ?.map((e) => Symbol(e.toSymbolValue()!))
          .toSet(),
    );
  }
}

extension on FieldElement {
  EnumLookup? get parse {
    if (metadata.annotations.firstOrNull?.computeConstantValue() case final obj?
        when obj.type?.getDisplayString() == '$EnumLookup') {
      return const EnumLookup();
    }
    return null;
  }
}

// extension on Symbol {
//   String get name => toString().substring(8, toString().length - 2);
// }
