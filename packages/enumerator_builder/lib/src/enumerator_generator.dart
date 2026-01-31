import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:enumerator/enumerator.dart';
import 'package:source_gen/source_gen.dart';

/// Generator for [Enumerator] annotation.
class EnumeratorGenerator extends GeneratorForAnnotation<Enumerator> {
  @override
  String? generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final meta = annotation.parse;
    if (element case final EnumElement enumElement) {
      final generated = Library((libraryBuilder) {
        libraryBuilder.body.addAll([
          if (meta.predicate ?? true) _buildBooleanExtension(enumElement),
          if (meta.iterableExtension ?? true)
            _buildIterableExtension(enumElement),
          if (meta.map ?? true) _buildMapExtension(enumElement),
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

  Extension _buildBooleanExtension(EnumElement element) {
    return Extension((extBuilder) {
      extBuilder
        ..name = '${element.name}EnumBooleanExtension'
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

  Extension _buildIterableExtension(EnumElement element) {
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

  Extension _buildMapExtension(EnumElement element) {
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
}

extension on String {
  String get capitalize => this[0].toUpperCase() + substring(1);
}

extension on ConstantReader {
  Enumerator get parse {
    return Enumerator(
      predicate: objectValue.getField('predicate')?.toBoolValue(),
      iterableExtension: objectValue
          .getField('iterableExtension')
          ?.toBoolValue(),
      map: objectValue.getField('map')?.toBoolValue(),
    );
  }
}
