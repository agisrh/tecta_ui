import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_section.dart';
import '../../../../utils/showcase_page_layout.dart';

class ShadowsShowcasePage extends StatelessWidget {
  const ShadowsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Shadows',
          style: TectaTypography.h4.copyWith(
            color: TectaColors.grey800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: theme.dividerColor, height: 1.0),
        ),
      ),
      body: ShowcasePageLayout(
        sections: [
          ShowcaseSection(
            title: 'Standard Custom Shadows',
            note: 'TectaShadows provides elevation shadows ranging from z1 (subtle card shadows) up to z24 (floating action buttons or dialog overlays).',
            code: '''// Box decoration with standard shadow elevation
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: TectaShadows.z1, // z1, z4, z8, z12, z16, z20, z24
  ),
)''',
            overview: _buildShadowGrid(
              context: context,
              items: [
                _ShadowItem('z1', TectaShadows.z1),
                _ShadowItem('z4', TectaShadows.z4),
                _ShadowItem('z8', TectaShadows.z8),
                _ShadowItem('z12', TectaShadows.z12),
                _ShadowItem('z16', TectaShadows.z16),
                _ShadowItem('z20', TectaShadows.z20),
                _ShadowItem('z24', TectaShadows.z24),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Semantic Alias Shadows',
            note: 'Use semantic alias shortcuts (card, dialog, dropdown) to ensure alignment with standard element shadow guidelines.',
            code: '''// Box decoration with semantic alias shadows
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: TectaShadows.card, // card (z8), dialog (z16), dropdown (z12)
  ),
)''',
            overview: _buildShadowGrid(
              context: context,
              items: [
                _ShadowItem('Card (z8)', TectaShadows.card),
                _ShadowItem('Dialog (z16)', TectaShadows.dialog),
                _ShadowItem('Dropdown (z12)', TectaShadows.dropdown),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Colored Glow Shadows',
            code: '''// Box decoration with colored glow shadows
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: TectaShadows.primary, // primary, secondary, success, warning, error, info
  ),
)''',
            overview: _buildShadowGrid(
              context: context,
              items: [
                _ShadowItem('Primary', TectaShadows.primary, labelColor: TectaColors.primaryMain),
                _ShadowItem(
                  'Secondary',
                  TectaShadows.secondary,
                  labelColor: TectaColors.secondaryMain,
                ),
                _ShadowItem('Success', TectaShadows.success, labelColor: TectaColors.successMain),
                _ShadowItem('Warning', TectaShadows.warning, labelColor: TectaColors.warningMain),
                _ShadowItem('Error', TectaShadows.error, labelColor: TectaColors.errorMain),
                _ShadowItem('Info', TectaShadows.info, labelColor: TectaColors.infoMain),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShadowGrid({required BuildContext context, required List<_ShadowItem> items}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 500;
        final double itemSize = isDesktop ? 120.0 : 90.0;
        
        return Wrap(
          spacing: 24.0,
          runSpacing: 24.0,
          children: items.map((item) {
            final theme = Theme.of(context);
            return Container(
              width: itemSize,
              height: itemSize,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: item.shadow,
              ),
              child: Center(
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TectaTypography.subtitle1.copyWith(
                    color: item.labelColor ?? TectaColors.grey800,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ShadowItem {
  final String name;
  final List<BoxShadow> shadow;
  final Color? labelColor;

  const _ShadowItem(this.name, this.shadow, {this.labelColor});
}
