import 'package:flutter/material.dart';

const _megaMenuCategories = <String, List<String>>{
  'Foundation': ['Color', 'Typography', 'Shadows', 'Icons'],
  'Forms': ['Button', 'Checkbox', 'Switch', 'Slider', 'Picker', 'SegmentedControl', 'TextField'],
  'Feedback': ['Alert', 'Skeleton', 'Progress'],
  'Display': ['Card', 'Accordion', 'Timeline', 'Tabs', 'Label'],
  'Overlays': ['Dialog', 'BottomSheet', 'Snackbar', 'Tooltip', 'DropdownMenu'],
};

class PlaygroundMegaMenu extends StatelessWidget {
  final String selectedTemplate;
  final ValueChanged<String> onTemplateSelected;

  const PlaygroundMegaMenu({
    super.key,
    required this.selectedTemplate,
    required this.onTemplateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 850,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF333333)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'SNIPPETS',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
                color: Colors.white38,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _megaMenuCategories.entries
                .where((e) => e.value.isNotEmpty)
                .map((entry) => Expanded(
                      child: _buildMegaColumn(entry.key, entry.value),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMegaColumn(String category, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.toUpperCase(),
            style: const TextStyle(
              fontSize: 9,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF8C42),
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) {
            final isSelected = item == selectedTemplate;
            return InkWell(
              onTap: () => onTemplateSelected(item),
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                margin: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFF8C42).withValues(alpha: 0.18)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    if (isSelected)
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.check_rounded,
                          size: 12,
                          color: Color(0xFFFF8C42),
                        ),
                      ),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                          color: isSelected ? Colors.white : Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
