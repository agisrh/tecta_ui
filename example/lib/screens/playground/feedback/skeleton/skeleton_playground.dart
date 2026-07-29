import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'skeleton_playground_parser.dart';
import 'skeleton_playground_docs.dart';

class SkeletonPlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const SkeletonPlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<SkeletonPlayground> createState() => _SkeletonPlaygroundState();
}

class _SkeletonPlaygroundState extends State<SkeletonPlayground> {
  double _skeletonWidth = 150.0;
  double _skeletonHeight = 150.0;
  BoxShape _skeletonShape = BoxShape.rectangle;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaSkeleton(
    width: 150,
    height: 150,
    shape: BoxShape.rectangle,
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _skeletonWidth = SkeletonPlaygroundParser.parseWidth(code, 150.0);
      _skeletonHeight = SkeletonPlaygroundParser.parseHeight(code, 150.0);
      _skeletonShape = SkeletonPlaygroundParser.parseShape(code, BoxShape.rectangle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Skeleton',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const SkeletonPlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Center(
        child: TectaSkeleton(
          width: _skeletonWidth,
          height: _skeletonHeight,
          shape: _skeletonShape,
          borderRadius: _skeletonShape == BoxShape.circle ? null : BorderRadius.circular(12),
        ),
      ),
    );
  }
}
