import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import 'docs/data/docs_data.dart';
import 'docs/widgets/docs_sidebar.dart';

class DocsTabScreen extends StatefulWidget {
  const DocsTabScreen({super.key});

  @override
  State<DocsTabScreen> createState() => _DocsTabScreenState();
}

class _DocsTabScreenState extends State<DocsTabScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = [];
  int _activeIndex = 0;
  late final List<DocSection> _sections;

  @override
  void initState() {
    super.initState();
    _sections = DocsData.buildSections();
    for (int i = 0; i < _sections.length; i++) {
      _sectionKeys.add(GlobalKey());
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
    for (int i = 0; i < _sectionKeys.length; i++) {
      final keyContext = _sectionKeys[i].currentContext;
      if (keyContext != null) {
        final renderBox = keyContext.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final distance = (position.dy - 120).abs();
          if (distance < closestDistance) {
            closestDistance = distance;
            activeIndex = i;
          }
        }
      }
    }
    if (activeIndex != _activeIndex) setState(() => _activeIndex = activeIndex);
  }

  void _scrollToSection(int index) {
    final keyContext = _sectionKeys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(keyContext,
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
      setState(() => _activeIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;

        if (!isWide) {
          return _buildMobileLayout(isDark);
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Sticky sidebar
            DocsSidebar(
              sections: _sections,
              activeIndex: _activeIndex,
              onSectionSelected: _scrollToSection,
            ),
            // Right: Scrollable content
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageHeader(isDark),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(_sections.length, (index) {
                          return Container(
                            key: _sectionKeys[index],
                            child: _buildSection(context, isDark, _sections[index]),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileLayout(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(isDark),
          ...List.generate(_sections.length, (index) {
            return _buildSection(context, isDark, _sections[index]);
          }),
        ],
      ),
    );
  }

  Widget _buildPageHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documentation',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : TectaColors.grey900,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Modular, highly customizable UI library for Flutter — built for enterprise dashboard experiences.',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : TectaColors.grey600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, bool isDark, DocSection section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : TectaColors.grey900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 3,
                decoration: BoxDecoration(
                  color: TectaColors.secondaryMain,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          // Content
          ...section.contentBuilder(context, isDark),
        ],
      ),
    );
  }
}
