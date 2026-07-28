import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class CodeHighlighter extends StatelessWidget {
  final String code;

  const CodeHighlighter({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lineCount = code.split('\n').length;
    final estimatedHeight = (lineCount * 20.0) + 40.0;

    // Use vscodeDark as base and override background to match container
    final SyntaxTheme theme = isDark
        ? SyntaxTheme.vscodeDark().copyWith(
            backgroundColor: Colors.transparent,
          )
        : SyntaxTheme.vscodeLight().copyWith(
            backgroundColor: Colors.transparent,
          );

    return SizedBox(
      height: estimatedHeight,
      child: SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: theme,
        fontSize: 13,
        withZoom: false,
        withLinesCount: true,
        expanded: false,
        selectable: true,
      ),
    );
  }
}
