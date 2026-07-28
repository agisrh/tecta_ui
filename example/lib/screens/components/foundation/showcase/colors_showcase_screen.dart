import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

import '../../../../utils/showcase_section.dart';
import '../../../../utils/showcase_page_layout.dart';

class ColorsShowcasePage extends StatelessWidget {
  const ColorsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Colors',
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
                child: Container(
                  color: theme.dividerColor,
                  height: 1.0,
                ),
              ),
            ),
      body: ShowcasePageLayout(
        sections: [
          ShowcaseSection(
            title: 'Primary (Deep Blue)',
            note: 'Always use TectaColors tokens instead of hardcoded hex values. This ensures your UI responds correctly to theme changes and future palette updates across the entire design system.',
            noteVariant: ShowcaseNoteVariant.tip,
            code: '''// Accessing Primary Colors
Container(
  color: TectaColors.primaryMain,
)''',
            overview: _buildColorGroup(
              shades: [
                _ColorShadeItem(
                  'Lighter',
                  TectaColors.primaryLighter,
                  'FFE6EDFA',
                  TectaColors.primaryDarker,
                ),
                _ColorShadeItem(
                  'Light',
                  TectaColors.primaryLight,
                  'FF7D9ECF',
                  TectaColors.primaryDarker,
                ),
                _ColorShadeItem(
                  'Main',
                  TectaColors.primaryMain,
                  'FF0F2B5C',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Dark',
                  TectaColors.primaryDark,
                  'FF0A1E42',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Darker',
                  TectaColors.primaryDarker,
                  'FF050F22',
                  TectaColors.white,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Secondary (Orange)',
            code: '''// Accessing Secondary Colors
Container(
  color: TectaColors.secondaryMain,
)''',
            overview: _buildColorGroup(
              shades: [
                _ColorShadeItem(
                  'Lighter',
                  TectaColors.secondaryLighter,
                  'FFFFECE4',
                  TectaColors.secondaryDarker,
                ),
                _ColorShadeItem(
                  'Light',
                  TectaColors.secondaryLight,
                  'FFFFB399',
                  TectaColors.secondaryDarker,
                ),
                _ColorShadeItem(
                  'Main',
                  TectaColors.secondaryMain,
                  'FFF05A24',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Dark',
                  TectaColors.secondaryDark,
                  'FFC84517',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Darker',
                  TectaColors.secondaryDarker,
                  'FF802B0E',
                  TectaColors.white,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Success (Green)',
            code: '''// Accessing Success Colors
Container(
  color: TectaColors.successMain,
)''',
            overview: _buildColorGroup(
              shades: [
                _ColorShadeItem(
                  'Lighter',
                  TectaColors.successLighter,
                  'FFE1F8EB',
                  TectaColors.successDarker,
                ),
                _ColorShadeItem(
                  'Light',
                  TectaColors.successLight,
                  'FF86EFAC',
                  TectaColors.successDarker,
                ),
                _ColorShadeItem(
                  'Main',
                  TectaColors.successMain,
                  'FF22C55E',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Dark',
                  TectaColors.successDark,
                  'FF16A34A',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Darker',
                  TectaColors.successDarker,
                  'FF115E59',
                  TectaColors.white,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Info (Blue)',
            code: '''// Accessing Info Colors
Container(
  color: TectaColors.infoMain,
)''',
            overview: _buildColorGroup(
              shades: [
                _ColorShadeItem(
                  'Lighter',
                  TectaColors.infoLighter,
                  'FFCAFDF5',
                  TectaColors.infoDarker,
                ),
                _ColorShadeItem(
                  'Light',
                  TectaColors.infoLight,
                  'FF61F3F3',
                  TectaColors.infoDarker,
                ),
                _ColorShadeItem(
                  'Main',
                  TectaColors.infoMain,
                  'FF00B8D9',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Dark',
                  TectaColors.infoDark,
                  'FF006C9C',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Darker',
                  TectaColors.infoDarker,
                  'FF003768',
                  TectaColors.white,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Warning (Orange/Yellow)',
            code: '''// Accessing Warning Colors
Container(
  color: TectaColors.warningMain,
)''',
            overview: _buildColorGroup(
              shades: [
                _ColorShadeItem(
                  'Lighter',
                  TectaColors.warningLighter,
                  'FFFFF5CC',
                  TectaColors.warningDarker,
                ),
                _ColorShadeItem(
                  'Light',
                  TectaColors.warningLight,
                  'FFFFD666',
                  TectaColors.warningDarker,
                ),
                _ColorShadeItem(
                  'Main',
                  TectaColors.warningMain,
                  'FFFFAB00',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Dark',
                  TectaColors.warningDark,
                  'FFB77900',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Darker',
                  TectaColors.warningDarker,
                  'FF7A4F01',
                  TectaColors.white,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Error (Red)',
            code: '''// Accessing Error Colors
Container(
  color: TectaColors.errorMain,
)''',
            overview: _buildColorGroup(
              shades: [
                _ColorShadeItem(
                  'Lighter',
                  TectaColors.errorLighter,
                  'FFFFE9D5',
                  TectaColors.errorDarker,
                ),
                _ColorShadeItem(
                  'Light',
                  TectaColors.errorLight,
                  'FFFFAC82',
                  TectaColors.errorDarker,
                ),
                _ColorShadeItem(
                  'Main',
                  TectaColors.errorMain,
                  'FFFF5630',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Dark',
                  TectaColors.errorDark,
                  'FFB7211F',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Darker',
                  TectaColors.errorDarker,
                  'FF7A0C2E',
                  TectaColors.white,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Greys Scale',
            code: '''// Accessing Neutral Greys
Container(
  color: TectaColors.grey500,
)''',
            overview: _buildColorGroup(
              shades: [
                _ColorShadeItem(
                  'Grey 50',
                  TectaColors.grey50,
                  'FFFDFDFD',
                  TectaColors.grey800,
                ),
                _ColorShadeItem(
                  'Grey 100',
                  TectaColors.grey100,
                  'FFF9FAFB',
                  TectaColors.grey800,
                ),
                _ColorShadeItem(
                  'Grey 200',
                  TectaColors.grey200,
                  'FFF4F6F8',
                  TectaColors.grey800,
                ),
                _ColorShadeItem(
                  'Grey 300',
                  TectaColors.grey300,
                  'FFDFE3E8',
                  TectaColors.grey800,
                ),
                _ColorShadeItem(
                  'Grey 400',
                  TectaColors.grey400,
                  'FFC4CDD5',
                  TectaColors.grey800,
                ),
                _ColorShadeItem(
                  'Grey 500',
                  TectaColors.grey500,
                  'FF919EAB',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Grey 600',
                  TectaColors.grey600,
                  'FF637381',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Grey 700',
                  TectaColors.grey700,
                  'FF454F5B',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Grey 800',
                  TectaColors.grey800,
                  'FF212B36',
                  TectaColors.white,
                ),
                _ColorShadeItem(
                  'Grey 900',
                  TectaColors.grey900,
                  'FF161C24',
                  TectaColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorGroup({
    required List<_ColorShadeItem> shades,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Column(
        children: shades.map((shade) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            color: shade.color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shade.name,
                  style: TectaTypography.body2.copyWith(
                    color: shade.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '#${shade.hex}',
                  style: TectaTypography.caption.copyWith(
                    color: shade.textColor,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ColorShadeItem {
  final String name;
  final Color color;
  final String hex;
  final Color textColor;

  const _ColorShadeItem(this.name, this.color, this.hex, this.textColor);
}
