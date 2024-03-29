import "package:analyzer/error/error.dart";
import "package:analyzer/error/listener.dart";
import "package:custom_lint_builder/custom_lint_builder.dart";

/// This is the entrypoint of our custom linter

MaxLinesFunctionLint createPlugin() => MaxLinesFunctionLint();

/// This class is the one that will analyze Dart files and return lints
class MaxLinesFunctionLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [
      MaxLinesFunctionRule.init(configs),
    ];
  }
}

/// This class contain the logic of the lint
class MaxLinesFunctionRule extends DartLintRule {
  MaxLinesFunctionRule._(
    this._maxLine,
    LintCode _code,
  ) : super(code: _code);

  /// Check if the user provide a custom limit
  /// If not use _defaultMaxLine
  factory MaxLinesFunctionRule.init(CustomLintConfigs configs) {
    final maxLine =
        configs.rules[_name]?.json[_paramName] as int? ?? _defaultMaxLine;
    final code = LintCode(
      name: _name,
      problemMessage: 'Function exceeds $maxLine lines',
      errorSeverity: ErrorSeverity.WARNING,
    );

    return MaxLinesFunctionRule._(maxLine, code);
  }

  static const String _paramName = 'limit';
  static const String _name = 'max_lines_function';
  static const int _defaultMaxLine = 30;
  final int _maxLine;

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addFunctionBody(
      (node) {
        final startFileOffset = node.beginToken.offset;
        final endFileOffset = node.endToken.offset;

        final startLine =
            resolver.lineInfo.getLocation(startFileOffset).lineNumber;
        final endLine = resolver.lineInfo.getLocation(endFileOffset).lineNumber;

        final numberLine = endLine - startLine;

        if (numberLine > _maxLine) {
          reporter.reportErrorForNode(code, node);
        }
      },
    );
  }
}
