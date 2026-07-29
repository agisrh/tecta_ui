import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class ButtonShowcasePage extends StatelessWidget {
  const ButtonShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Widget mailIcon = Icon(SolarLinearIcons.letter);

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Buttons',
                style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(color: TectaColors.grey300.withValues(alpha: 0.5), height: 1.0),
              ),
            ),
      body: ShowcasePageLayout(
        sections: [
          ShowcaseSection(
            title: 'Contained Buttons',
            note:
                'Contained buttons have high visual emphasis, designed for primary actions or terminal confirmation triggers in forms.',
            code: '''TectaButton(
  label: 'Primary',
  color: TectaColors.primaryMain,
  onPressed: () {},
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard(
                  context,
                  labelText: 'Base',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Inherit',
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Primary',
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Secondary',
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      const TectaButton(
                        label: 'Disabled',
                        color: TectaColors.primaryMain,
                        onPressed: null,
                      ),
                      TectaButton(label: 'Link', color: TectaColors.grey900, onPressed: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Colors',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Inherit',
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Primary',
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Secondary',
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(label: 'Info', color: TectaColors.infoMain, onPressed: () {}),
                      TectaButton(
                        label: 'Success',
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Warning',
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaButton(label: 'Error', color: TectaColors.errorMain, onPressed: () {}),
                      TectaButton(label: 'Black', color: TectaColors.grey900, onPressed: () {}),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: TectaColors.grey200),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TectaButton(
                          label: 'White',
                          color: TectaColors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Custom Colors',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Purple',
                        color: Colors.purple,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Pink',
                        color: Colors.pink,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Orange',
                        color: Colors.orange,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Teal',
                        color: Colors.teal,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'With icon & loading',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Icon left',
                        color: TectaColors.errorMain,
                        icon: mailIcon,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Icon right',
                        color: TectaColors.errorMain,
                        trailingIcon: mailIcon,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Loading',
                        color: TectaColors.grey800,
                        loading: true,
                        loadingPosition: TectaButtonLoadingPosition.center,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Loading...',
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'Loading...',
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Start',
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'Start',
                        loadingPosition: TectaButtonLoadingPosition.start,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'End',
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'End',
                        loadingPosition: TectaButtonLoadingPosition.end,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Sizes',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TectaButton(
                            label: 'Small',
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.small,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Medium',
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.medium,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Large',
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.large,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'XLarge',
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.xLarge,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TectaButton(
                            label: 'Small',
                            color: TectaColors.grey800,
                            size: TectaButtonSize.small,
                            loading: true,
                            loadingLabel: 'Small',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Medium',
                            color: TectaColors.grey800,
                            size: TectaButtonSize.medium,
                            loading: true,
                            loadingLabel: 'Medium',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Large',
                            color: TectaColors.grey800,
                            size: TectaButtonSize.large,
                            loading: true,
                            loadingLabel: 'Large',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'XLarge',
                            color: TectaColors.grey800,
                            size: TectaButtonSize.xLarge,
                            loading: true,
                            loadingLabel: 'XLarge',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Outlined Buttons',
            note:
                'Outlined buttons feature medium emphasis. Best suited for secondary actions, dashboard filters, or cancel buttons.',
            code: '''TectaButton(
  label: 'Primary',
  variant: TectaButtonVariant.outlined,
  color: TectaColors.primaryMain,
  onPressed: () {},
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard(
                  context,
                  labelText: 'Base',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Inherit',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Primary',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Secondary',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      const TectaButton(
                        label: 'Disabled',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.primaryMain,
                        onPressed: null,
                      ),
                      TectaButton(
                        label: 'Link',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Colors',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Inherit',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Primary',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Secondary',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Info',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.infoMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Success',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Warning',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Error',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.errorMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Black',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'With icon & loading',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Icon left',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.errorMain,
                        icon: mailIcon,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Icon right',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.errorMain,
                        trailingIcon: mailIcon,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Loading',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingPosition: TectaButtonLoadingPosition.center,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Loading...',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'Loading...',
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Start',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'Start',
                        loadingPosition: TectaButtonLoadingPosition.start,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'End',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'End',
                        loadingPosition: TectaButtonLoadingPosition.end,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Sizes',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TectaButton(
                            label: 'Small',
                            variant: TectaButtonVariant.outlined,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.small,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Medium',
                            variant: TectaButtonVariant.outlined,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.medium,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Large',
                            variant: TectaButtonVariant.outlined,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.large,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'XLarge',
                            variant: TectaButtonVariant.outlined,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.xLarge,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TectaButton(
                            label: 'Small',
                            variant: TectaButtonVariant.outlined,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.small,
                            loading: true,
                            loadingLabel: 'Small',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Medium',
                            variant: TectaButtonVariant.outlined,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.medium,
                            loading: true,
                            loadingLabel: 'Medium',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Large',
                            variant: TectaButtonVariant.outlined,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.large,
                            loading: true,
                            loadingLabel: 'Large',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'XLarge',
                            variant: TectaButtonVariant.outlined,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.xLarge,
                            loading: true,
                            loadingLabel: 'XLarge',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Text Buttons',
            note:
                'Text buttons are used for low emphasis actions, inline link selections, or card footers.',
            code: '''TectaButton(
  label: 'Primary',
  variant: TectaButtonVariant.text,
  color: TectaColors.primaryMain,
  onPressed: () {},
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard(
                  context,
                  labelText: 'Base',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Inherit',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Primary',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Secondary',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      const TectaButton(
                        label: 'Disabled',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.primaryMain,
                        onPressed: null,
                      ),
                      TectaButton(
                        label: 'Link',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Colors',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Inherit',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Primary',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Secondary',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Info',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.infoMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Success',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Warning',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Error',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.errorMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Black',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'With icon & loading',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Icon left',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.errorMain,
                        icon: mailIcon,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Icon right',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.errorMain,
                        trailingIcon: mailIcon,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Loading',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingPosition: TectaButtonLoadingPosition.center,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Loading...',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'Loading...',
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Start',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'Start',
                        loadingPosition: TectaButtonLoadingPosition.start,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'End',
                        variant: TectaButtonVariant.text,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'End',
                        loadingPosition: TectaButtonLoadingPosition.end,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Sizes',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TectaButton(
                            label: 'Small',
                            variant: TectaButtonVariant.text,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.small,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Medium',
                            variant: TectaButtonVariant.text,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.medium,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Large',
                            variant: TectaButtonVariant.text,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.large,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'XLarge',
                            variant: TectaButtonVariant.text,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.xLarge,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TectaButton(
                            label: 'Small',
                            variant: TectaButtonVariant.text,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.small,
                            loading: true,
                            loadingLabel: 'Small',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Medium',
                            variant: TectaButtonVariant.text,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.medium,
                            loading: true,
                            loadingLabel: 'Medium',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Large',
                            variant: TectaButtonVariant.text,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.large,
                            loading: true,
                            loadingLabel: 'Large',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'XLarge',
                            variant: TectaButtonVariant.text,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.xLarge,
                            loading: true,
                            loadingLabel: 'XLarge',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Soft Buttons',
            note:
                'Soft buttons provide an elegant semi-transparent background tint, blending primary colors softly on layouts.',
            code: '''TectaButton(
  label: 'Primary',
  variant: TectaButtonVariant.soft,
  color: TectaColors.primaryMain,
  onPressed: () {},
)''',
            overview: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard(
                  context,
                  labelText: 'Base',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Inherit',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Primary',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Secondary',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      const TectaButton(
                        label: 'Disabled',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.primaryMain,
                        onPressed: null,
                      ),
                      TectaButton(
                        label: 'Link',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Colors',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Inherit',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Primary',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Secondary',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Info',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.infoMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Success',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Warning',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Error',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.errorMain,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Black',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'With icon & loading',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaButton(
                        label: 'Icon left',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.errorMain,
                        icon: mailIcon,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Icon right',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.errorMain,
                        trailingIcon: mailIcon,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Loading',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingPosition: TectaButtonLoadingPosition.center,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Loading...',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'Loading...',
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'Start',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'Start',
                        loadingPosition: TectaButtonLoadingPosition.start,
                        onPressed: () {},
                      ),
                      TectaButton(
                        label: 'End',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey800,
                        loading: true,
                        loadingLabel: 'End',
                        loadingPosition: TectaButtonLoadingPosition.end,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Sizes',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TectaButton(
                            label: 'Small',
                            variant: TectaButtonVariant.soft,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.small,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Medium',
                            variant: TectaButtonVariant.soft,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.medium,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Large',
                            variant: TectaButtonVariant.soft,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.large,
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'XLarge',
                            variant: TectaButtonVariant.soft,
                            color: TectaColors.infoMain,
                            size: TectaButtonSize.xLarge,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TectaButton(
                            label: 'Small',
                            variant: TectaButtonVariant.soft,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.small,
                            loading: true,
                            loadingLabel: 'Small',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Medium',
                            variant: TectaButtonVariant.soft,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.medium,
                            loading: true,
                            loadingLabel: 'Medium',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'Large',
                            variant: TectaButtonVariant.soft,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.large,
                            loading: true,
                            loadingLabel: 'Large',
                            onPressed: () {},
                          ),
                          TectaButton(
                            label: 'XLarge',
                            variant: TectaButtonVariant.soft,
                            color: TectaColors.grey800,
                            size: TectaButtonSize.xLarge,
                            loading: true,
                            loadingLabel: 'XLarge',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ===========================================================================
                // ICON BUTTONS
                // ===========================================================================
                Text('Icon button', style: TectaTypography.h5.copyWith(color: TectaColors.grey700)),
                const SizedBox(height: 30),
                _buildCard(
                  context,
                  labelText: 'Base',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TectaIconButton(icon: mailIcon, onPressed: () {}),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      const TectaIconButton(icon: mailIcon, onPressed: null),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Colors',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TectaIconButton(icon: mailIcon, onPressed: () {}),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                          icon: mailIcon, color: TectaColors.infoMain, onPressed: () {}),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.errorMain,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Sizes',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.small,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.medium,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.large,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.small,
                        variant: TectaButtonVariant.outlined,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.medium,
                        variant: TectaButtonVariant.outlined,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.large,
                        variant: TectaButtonVariant.outlined,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'With animate',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.errorMain,
                        animate: true,
                        onPressed: () {},
                      ),
                      TectaIconButton(
                        icon: mailIcon,
                        color: TectaColors.errorMain,
                        size: TectaButtonSize.large,
                        animate: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Disabled',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      const TectaIconButton(icon: mailIcon, onPressed: null),
                      TectaIconButton(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        onPressed: null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ===========================================================================
                // FAB BUTTONS
                // ===========================================================================
                Text('Fab button', style: TectaTypography.h5.copyWith(color: TectaColors.grey700)),
                const SizedBox(height: 30),
                _buildCard(
                  context,
                  labelText: 'Circular',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(icon: mailIcon, color: TectaColors.grey800, onPressed: () {}),
                      TectaFab(icon: mailIcon, color: TectaColors.grey900, onPressed: () {}),
                      TectaFab(icon: mailIcon, color: TectaColors.primaryMain, onPressed: () {}),
                      TectaFab(icon: mailIcon, color: TectaColors.secondaryMain, onPressed: () {}),
                      TectaFab(icon: mailIcon, color: TectaColors.infoMain, onPressed: () {}),
                      TectaFab(icon: mailIcon, color: TectaColors.successMain, onPressed: () {}),
                      TectaFab(icon: mailIcon, color: TectaColors.warningMain, onPressed: () {}),
                      TectaFab(icon: mailIcon, color: TectaColors.errorMain, onPressed: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Extended',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(
                        icon: mailIcon,
                        label: 'Default',
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Inherit',
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Primary',
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Secondary',
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Info',
                        color: TectaColors.infoMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Success',
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Warning',
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Error',
                        color: TectaColors.errorMain,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Sizes',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(
                        icon: mailIcon,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.small,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.medium,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.large,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Small',
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.small,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Medium',
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.medium,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Large',
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.large,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Outlined FABs
                _buildCard(
                  context,
                  labelText: 'Circular',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.infoMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.errorMain,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Extended',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(
                        icon: mailIcon,
                        label: 'Default',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Inherit',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Primary',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Secondary',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Info',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.infoMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Success',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Warning',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Error',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.errorMain,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Sizes',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.small,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.medium,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.large,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Small',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.small,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Medium',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.medium,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Large',
                        variant: TectaButtonVariant.outlined,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.large,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Disabled',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(
                          icon: mailIcon, variant: TectaButtonVariant.outlined, onPressed: null),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Disabled',
                        variant: TectaButtonVariant.outlined,
                        onPressed: null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Soft FABs
                _buildCard(
                  context,
                  labelText: 'Circular',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.infoMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.errorMain,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Extended',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(
                        icon: mailIcon,
                        label: 'Default',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey800,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Inherit',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.grey900,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Primary',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.primaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Secondary',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.secondaryMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Info',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.infoMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Success',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.successMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Warning',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.warningMain,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Error',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.errorMain,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  labelText: 'Sizes',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.small,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.medium,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.large,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Small',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.small,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Medium',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.medium,
                        onPressed: () {},
                      ),
                      TectaFab(
                        icon: mailIcon,
                        label: 'Large',
                        variant: TectaButtonVariant.soft,
                        color: TectaColors.infoMain,
                        size: TectaButtonSize.large,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child, String? labelText}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0),
              child: Text(
                labelText,
                style: TectaTypography.overline.copyWith(
                  color: isDark ? Colors.white38 : TectaColors.grey700,
                  fontSize: 11,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Divider(height: 20, thickness: 1, color: theme.dividerColor.withValues(alpha: 0.5)),
          ],
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: labelText == null ? 20.0 : 0,
              bottom: 20.0,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
