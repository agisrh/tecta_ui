import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Syntax-highlighted code block widget (dark theme, VS Code style).
class SyntaxHighlightedCode extends StatelessWidget {
  final String code;

  const SyntaxHighlightedCode({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = [];
    final textVal = code;

    final regExp = RegExp(
      r'//.*$|' // Comments [0]
      r'\b(import|class|extends|final|const|return|Widget|build|BuildContext|context|void|null|true|false|super|void\s+main|runApp|required|this|static|late|async|await|enum|switch|case|default|if|else|for|in|new)\b|' // Keywords [1]
      r'\b(TectaCard|TectaButton|TectaAlert|TectaTextField|TectaTheme|TectaColors|TectaTypography|TectaSnackbar|MaterialApp|MyApp|Text|Padding|Row|Column|EdgeInsets|TextStyle|Divider|Container|BoxDecoration|BorderRadius|Scaffold|Center|ThemeData|ThemeMode|ValueNotifier|SizedBox|Icon|IconButton|AppBar|Navigator|MediaQuery|LayoutBuilder|StatelessWidget|StatefulWidget|State|Widget|BuildContext|Key|GlobalKey|Color|Colors|Icons)\b|' // Widgets/Classes [2]
      r'([a-zA-Z0-9_]+)(?=:)|' // Parameters/Keys [3]
      r'(\".*?\"|'
      "'.*?')"
      r'|' // Strings [4]
      r'(\b\d+(?:\.\d+)?\b)', // Numbers [5]
      multiLine: true,
    );

    int lastMatchEnd = 0;
    regExp.allMatches(textVal).forEach((match) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: textVal.substring(lastMatchEnd, match.start)));
      }
      final fullMatch = match.group(0) ?? '';
      if (fullMatch.startsWith('//')) {
        spans.add(TextSpan(
            text: fullMatch,
            style: const TextStyle(color: Color(0xFF6A9955), fontStyle: FontStyle.italic)));
      } else if (match.group(1) != null) {
        spans.add(TextSpan(
            text: fullMatch,
            style: const TextStyle(color: Color(0xFFC586C0), fontWeight: FontWeight.bold)));
      } else if (match.group(2) != null) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFF4EC9B0))));
      } else if (match.group(3) != null) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFF9CDCFE))));
      } else if (match.group(4) != null) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFFCE9178))));
      } else if (match.group(5) != null) {
        spans.add(TextSpan(text: fullMatch, style: const TextStyle(color: Color(0xFFB5CEA8))));
      } else {
        spans.add(TextSpan(text: fullMatch));
      }
      lastMatchEnd = match.end;
    });

    if (lastMatchEnd < textVal.length) {
      spans.add(TextSpan(text: textVal.substring(lastMatchEnd)));
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 48, 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontFamily: 'monospace', fontSize: 13, color: Color(0xFFD4D4D4), height: 1.6),
              children: spans,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: _CopyButton(code: code),
        ),
      ],
    );
  }
}

class _CopyButton extends StatefulWidget {
  final String code;
  const _CopyButton({required this.code});

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _copied = false;

  void _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: IconButton(
        key: ValueKey(_copied),
        icon: Icon(_copied ? Icons.check_rounded : Icons.copy_rounded, size: 15),
        color: _copied ? const Color(0xFF4EC9B0) : const Color(0xFF9CDCFE),
        tooltip: _copied ? 'Copied!' : 'Copy',
        style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.06)),
        onPressed: _copy,
      ),
    );
  }
}
