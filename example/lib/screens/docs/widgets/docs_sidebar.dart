import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../data/docs_data.dart';

class DocsSidebar extends StatelessWidget {
  final List<DocSection> sections;
  final int activeIndex;
  final ValueChanged<int> onSectionSelected;

  const DocsSidebar({
    super.key,
    required this.sections,
    required this.activeIndex,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 220,
      margin: const EdgeInsets.only(top: 40.0),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: theme.dividerColor.withValues(alpha: 0.4)),
        ),
      ),
      padding: const EdgeInsets.only(right: 20.0, left: 40.0),
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
          ...List.generate(sections.length, (index) {
            final isSelected = activeIndex == index;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => onSectionSelected(index),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 3,
                        height: 14,
                        decoration: BoxDecoration(
                          color:
                              isSelected ? TectaColors.secondaryMain : Colors.transparent,
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
                                ? TectaColors.secondaryMain
                                : (isDark ? Colors.white54 : TectaColors.grey500),
                          ),
                          child: Text(
                            '${index + 1} - ${sections[index].title}',
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
    );
  }
}
