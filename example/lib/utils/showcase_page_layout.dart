import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import 'showcase_section.dart';

class ShowcasePageLayout extends StatefulWidget {
  final List<ShowcaseSection> sections;

  const ShowcasePageLayout({
    super.key,
    required this.sections,
  });

  @override
  State<ShowcasePageLayout> createState() => _ShowcasePageLayoutState();
}

class _ShowcasePageLayoutState extends State<ShowcasePageLayout> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = [];
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.sections.length; i++) {
      _keys.add(GlobalKey());
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    int activeIndex = 0;
    double closestDistance = double.infinity;

    for (int i = 0; i < _keys.length; i++) {
      final keyContext = _keys[i].currentContext;
      if (keyContext != null) {
        final renderBox = keyContext.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          // Find the section closest to the top of the viewport (y = 120 offset)
          final distance = (position.dy - 150).abs();
          if (distance < closestDistance) {
            closestDistance = distance;
            activeIndex = i;
          }
        }
      }
    }

    if (activeIndex != _activeIndex && activeIndex < widget.sections.length) {
      setState(() {
        _activeIndex = activeIndex;
      });
    }
  }

  void _scrollToSection(int index) {
    final keyContext = _keys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() {
        _activeIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 800; // Adjusted breakpoint for container width

        if (!isDesktop || widget.sections.length <= 1) {
          // For mobile or pages with single sections, render as standard list view without sidebar
          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0), // Added horizontal padding for mobile
            itemCount: widget.sections.length,
            itemBuilder: (context, index) {
              return Container(
                key: _keys[index],
                padding: const EdgeInsets.only(bottom: 24.0), // Add spacing between items
                child: widget.sections[index],
              );
            },
          );
        }

        // Desktop split-pane layout with "ON THIS PAGE" sidebar
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Scrollable components list
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  children: List.generate(widget.sections.length, (index) {
                    return Container(
                      key: _keys[index],
                      padding: const EdgeInsets.only(bottom: 32.0), // Add spacing between items
                      child: widget.sections[index],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(width: 40),
            // Right Column: "ON THIS PAGE" sticky sidebar
            Container(
              width: 220,
              margin: const EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: theme.dividerColor.withValues(alpha: 0.4),
                  ),
                ),
              ),
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ON THIS PAGE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white70 : TectaColors.grey800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(widget.sections.length, (index) {
                    final isSelected = _activeIndex == index;
                    final section = widget.sections[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _scrollToSection(index),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 3,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: isSelected ? TectaColors.primaryMain : Colors.transparent,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 150),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    color: isSelected
                                        ? TectaColors.primaryMain
                                        : (isDark ? Colors.white54 : TectaColors.grey500),
                                  ),
                                  child: Text(
                                    '${index + 1} - ${section.title}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
