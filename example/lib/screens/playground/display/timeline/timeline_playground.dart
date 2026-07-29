import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../playground_shell.dart';
import 'timeline_playground_parser.dart';
import 'timeline_playground_docs.dart';

class TimelinePlayground extends StatefulWidget {
  final ValueChanged<String> onTemplateChanged;

  const TimelinePlayground({
    super.key,
    required this.onTemplateChanged,
  });

  @override
  State<TimelinePlayground> createState() => _TimelinePlaygroundState();
}

class _TimelinePlaygroundState extends State<TimelinePlayground> {
  TectaTimelineIndicatorType _indicatorType = TectaTimelineIndicatorType.solid;
  TectaTimelineLineType _lineType = TectaTimelineLineType.solid;

  final String _defaultCode = '''import 'package:tecta_ui/tecta_ui.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return TectaTimeline(
    children: [
      TectaTimelineItem(
        title: 'Ordered',
        time: '09:30 AM',
        indicatorType: TectaTimelineIndicatorType.solid,
        lineType: TectaTimelineLineType.solid,
      ),
      TectaTimelineItem(
        title: 'Shipped',
        time: '11:15 AM',
        indicatorType: TectaTimelineIndicatorType.solid,
        lineType: TectaTimelineLineType.solid,
      ),
    ],
  );
}''';

  void _onCodeChanged(String code) {
    setState(() {
      _indicatorType = TimelinePlaygroundParser.parseIndicatorType(code, TectaTimelineIndicatorType.solid);
      _lineType = TimelinePlaygroundParser.parseLineType(code, TectaTimelineLineType.solid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      templateName: 'Timeline',
      defaultCode: _defaultCode,
      onTemplateChanged: widget.onTemplateChanged,
      docContent: const TimelinePlaygroundDocs(),
      onCodeChanged: _onCodeChanged,
      preview: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: TectaTimeline(
          children: [
            TectaTimelineItem(
              title: 'Ordered',
              time: '09:30 AM',
              indicatorType: _indicatorType,
              lineType: _lineType,
            ),
            TectaTimelineItem(
              title: 'Shipped',
              time: '11:15 AM',
              indicatorType: _indicatorType,
              lineType: _lineType,
            ),
            TectaTimelineItem(
              title: 'Delivered',
              time: '02:40 PM',
              indicatorType: _indicatorType,
              lineType: _lineType,
            ),
          ],
        ),
      ),
    );
  }
}
