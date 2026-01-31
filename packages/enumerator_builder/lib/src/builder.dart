import 'package:build/build.dart';
import 'package:enumerator_builder/enumerator_builder.dart';
import 'package:source_gen/source_gen.dart';

/// Builder entry point.
Builder enumeratorBuilder(BuilderOptions options) =>
    PartBuilder([EnumeratorGenerator()], '.g.dart');
