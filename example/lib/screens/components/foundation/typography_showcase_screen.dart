import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../utils/showcase_page_layout.dart';
import '../../../utils/showcase_section.dart';

class TypographyShowcasePage extends StatelessWidget {
  const TypographyShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Typography',
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
            title: 'Headings (H1 - H6)',
            code: '''Text('Heading 1', style: TectaTypography.h1)
Text('Heading 2', style: TectaTypography.h2)
Text('Heading 3', style: TectaTypography.h3)
Text('Heading 4', style: TectaTypography.h4)
Text('Heading 5', style: TectaTypography.h5)
Text('Heading 6', style: TectaTypography.h6)''',
            overview: Column(
              children: [
                _buildTypographyCard(
                  context: context,
                  variantName: 'H1 - Display',
                  style: TectaTypography.h1,
                  desc: 'Size: 40, Bold (700)',
                  sampleText: 'Lorem Ipsum',
                ),
                const SizedBox(height: 16),
                _buildTypographyCard(
                  context: context,
                  variantName: 'H2 - Title Large',
                  style: TectaTypography.h2,
                  desc: 'Size: 32, Bold (700)',
                  sampleText: 'Lorem Ipsum Dolor',
                ),
                const SizedBox(height: 16),
                _buildTypographyCard(
                  context: context,
                  variantName: 'H3 - Title Medium',
                  style: TectaTypography.h3,
                  desc: 'Size: 24, Bold (700)',
                  sampleText: 'Consectetur Adipiscing',
                ),
                const SizedBox(height: 16),
                _buildTypographyCard(
                  context: context,
                  variantName: 'H4 - Title Small',
                  style: TectaTypography.h4,
                  desc: 'Size: 20, Bold (700)',
                  sampleText: 'Sed Do Eiusmod Tempor',
                ),
                const SizedBox(height: 16),
                _buildTypographyCard(
                  context: context,
                  variantName: 'H5 - Subtitle 1',
                  style: TectaTypography.h5,
                  desc: 'Size: 18, SemiBold (600)',
                  sampleText: 'Incididunt Ut Labore',
                ),
                const SizedBox(height: 16),
                _buildTypographyCard(
                  context: context,
                  variantName: 'H6 - Subtitle 2',
                  style: TectaTypography.h6,
                  desc: 'Size: 16, SemiBold (600)',
                  sampleText: 'Et Dolore Magna Aliqua',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Subtitles',
            code: '''Text('Subtitle 1', style: TectaTypography.subtitle1)
Text('Subtitle 2', style: TectaTypography.subtitle2)''',
            overview: Column(
              children: [
                _buildTypographyCard(
                  context: context,
                  variantName: 'Subtitle 1',
                  style: TectaTypography.subtitle1,
                  desc: 'Size: 16, SemiBold (600)',
                  sampleText: 'Ut Enim Ad Minim Veniam',
                ),
                const SizedBox(height: 16),
                _buildTypographyCard(
                  context: context,
                  variantName: 'Subtitle 2',
                  style: TectaTypography.subtitle2,
                  desc: 'Size: 14, SemiBold (600)',
                  sampleText: 'Quis Nostrud Exercitation',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Body Text',
            code: '''Text('Body 1', style: TectaTypography.body1)
Text('Body 2', style: TectaTypography.body2)''',
            overview: Column(
              children: [
                _buildTypographyCard(
                  context: context,
                  variantName: 'Body 1',
                  style: TectaTypography.body1,
                  desc: 'Size: 16, Regular (400)',
                  sampleText: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                ),
                const SizedBox(height: 16),
                _buildTypographyCard(
                  context: context,
                  variantName: 'Body 2',
                  style: TectaTypography.body2,
                  desc: 'Size: 14, Regular (400)',
                  sampleText: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Caption & Overline',
            code: '''Text('Caption', style: TectaTypography.caption)
Text('OVERLINE', style: TectaTypography.overline)''',
            overview: Column(
              children: [
                _buildTypographyCard(
                  context: context,
                  variantName: 'Caption',
                  style: TectaTypography.caption,
                  desc: 'Size: 12, Regular (400)',
                  sampleText: 'Duis aute irure dolor in reprehenderit in voluptate.',
                ),
                const SizedBox(height: 16),
                _buildTypographyCard(
                  context: context,
                  variantName: 'Overline',
                  style: TectaTypography.overline,
                  desc: 'Size: 12, Bold (700), Spaced',
                  sampleText: 'LOREM IPSUM DOLOR SIT',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypographyCard({
    required BuildContext context,
    required String variantName,
    required TextStyle style,
    required String desc,
    required String sampleText,
  }) {
    final theme = Theme.of(context);

    // Resolve color dynamically for the showcase text
    final resolvedStyle = style.copyWith(
      color: TectaColors.grey700,
    );

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                variantName,
                style: (theme.textTheme.labelMedium ?? TectaTypography.subtitle2).copyWith(
                  color: TectaColors.grey500,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: Text(
                  desc,
                  textAlign: TextAlign.right,
                  style: (theme.textTheme.labelMedium ?? TectaTypography.subtitle2).copyWith(
                    color: TectaColors.grey500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 24, thickness: 0.8, color: TectaColors.grey300.withValues(alpha: 0.4)),
          Text(
            sampleText,
            style: resolvedStyle,
          ),
        ],
      ),
    );
  }
}
