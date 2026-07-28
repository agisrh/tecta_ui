import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecta_ui/tecta_ui.dart';
import 'code_highlighter.dart';

class ShowcaseSection extends StatefulWidget {
  final String title;
  final Widget overview;
  final String code;

  const ShowcaseSection({
    super.key,
    required this.title,
    required this.overview,
    required this.code,
  });

  @override
  State<ShowcaseSection> createState() => _ShowcaseSectionState();
}

class _ShowcaseSectionState extends State<ShowcaseSection> {
  bool _showCode = false;

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.code));
    TectaSnackbar.show(
      context,
      message: 'Code snippet copied to clipboard!',
      variant: TectaSnackbarVariant.success,
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 32.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title & Tab Controls
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 500;
              
              final titleWidget = Text(
                widget.title,
                style: TextStyle(
                  color: isDark ? Colors.white : TectaColors.grey800,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                overflow: isWide ? TextOverflow.ellipsis : null,
              );
              
              final tabsWidget = SizedBox(
                width: 190,
                child: TectaSegmentedControl(
                  height: 32,
                  outerPadding: 2.0,
                  borderRadius: BorderRadius.circular(8.0),
                  options: const [
                    TectaSegmentedOption(label: 'Overview'),
                    TectaSegmentedOption(label: 'Code'),
                  ],
                  selectedIndex: _showCode ? 1 : 0,
                  onValueChanged: (index) {
                    setState(() {
                      _showCode = index == 1;
                    });
                  },
                ),
              );

              if (isWide) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: titleWidget),
                    const SizedBox(width: 16),
                    tabsWidget,
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget,
                    const SizedBox(height: 12),
                    tabsWidget,
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 20),
          // Content Area (Nested rounded box)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _showCode ? _buildCodeView() : _buildOverviewView(),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewView() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      key: const ValueKey('overview_view'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: Center(
        child: widget.overview,
      ),
    );
  }

  Widget _buildCodeView() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      key: const ValueKey('code_view'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: Stack(
        children: [
          CodeHighlighter(code: widget.code),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.copy_rounded, size: 16),
              color: TectaColors.grey500,
              tooltip: 'Copy Code',
              onPressed: _copyToClipboard,
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withValues(alpha: 0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
