import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class AccordionShowcasePage extends StatefulWidget {
  const AccordionShowcasePage({super.key});

  @override
  State<AccordionShowcasePage> createState() => _AccordionShowcasePageState();
}

class _AccordionShowcasePageState extends State<AccordionShowcasePage> {
  // Track expanded index for Accordion Group
  int _expandedIndex = -1;

  // Local state for settings switches
  bool _pushNotifications = true;
  bool _emailNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Accordion',
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          _buildSectionHeader('SIMPLE ACCORDION'),
          const SizedBox(height: 16),
          TectaAccordion(
            title: 'Accordion 1',
            child: Text(
              'This is the body content of the first simple accordion. It has no leading icons or subtitles, giving a minimal clean look.',
              style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
            ),
          ),
          const SizedBox(height: 12),
          TectaAccordion(
            title: 'Accordion 2',
            subtitle: 'With an optional helper subtitle text',
            child: Text(
              'This accordion has a title and a subtitle. Subtitles are helpful for providing extra context without cluttering the main header title text.',
              style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('ACCORDION WITH LEADING ICONS (INTERACTIVE)'),
          const SizedBox(height: 16),
          TectaAccordion(
            title: 'General Settings',
            leading: const Icon(
              SolarLinearIcons.settings,
              color: TectaColors.primaryMain,
              size: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage your notification and theme preferences dynamically.',
                  style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Push Notifications', style: TectaTypography.subtitle2),
                    TectaSwitch(
                      value: _pushNotifications,
                      onChanged: (val) => setState(() => _pushNotifications = val),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email Reports', style: TectaTypography.subtitle2),
                    TectaSwitch(
                      value: _emailNotifications,
                      onChanged: (val) => setState(() => _emailNotifications = val),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TectaAccordion(
            title: 'Personal Account',
            subtitle: 'Secure profile information',
            leading: const Icon(
              SolarLinearIcons.user,
              color: TectaColors.grey800,
              size: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const TectaAvatar(
                      text: 'JD',
                      shape: TectaAvatarShape.circle,
                      size: 44,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('John Doe', style: TectaTypography.subtitle2),
                        Text('john.doe@example.com', style: TectaTypography.caption),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TectaButton(
                    label: 'Edit Profile Settings',
                    variant: TectaButtonVariant.soft,
                    color: TectaColors.primaryMain,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile edit clicked')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('ACCORDION GROUP (SINGLE EXPAND)'),
          const SizedBox(height: 16),
          ...List.generate(3, (index) {
            final int itemIndex = index + 1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TectaAccordion(
                key: ValueKey('group_item_$index'),
                title: 'Group Accordion Item $itemIndex',
                initiallyExpanded: _expandedIndex == index,
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    _expandedIndex = isExpanded ? index : -1;
                  });
                },
                child: Text(
                  'This is group accordion item $itemIndex. Expanding this item will automatically close all other expanded items in the group list.',
                  style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          _buildSectionHeader('DISABLED STATE'),
          const SizedBox(height: 16),
          TectaAccordion(
            title: 'Disabled Accordion',
            subtitle: 'This accordion cannot be interacted with',
            isDisabled: true,
            leading: const Icon(SolarLinearIcons.bell, color: TectaColors.grey400, size: 22),
            child: const SizedBox.shrink(),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('DYNAMIC STYLING ACCORDIONS'),
          const SizedBox(height: 16),
          TectaAccordion(
            title: 'Custom Style Accordion',
            subtitle: 'Different radius, colors, and shadows',
            backgroundColor: TectaColors.secondaryLighter.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: TectaColors.secondaryLight, width: 1.5),
            boxShadow: TectaShadows.z8,
            titleStyle: TectaTypography.h5.copyWith(color: TectaColors.secondaryMain),
            subtitleStyle: TectaTypography.caption.copyWith(color: TectaColors.secondaryLight),
            trailingIcon: const Icon(Icons.add_circle_outline, color: TectaColors.secondaryMain),
            disableIconRotation: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Storage Used (85%)',
                  style: TectaTypography.subtitle2.copyWith(color: TectaColors.secondaryDarker),
                ),
                const SizedBox(height: 8),
                const TectaLinearProgress(
                  value: 0.85,
                  color: TectaColors.secondaryMain,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TectaButton(
                      label: 'Upgrade Plan',
                      variant: TectaButtonVariant.contained,
                      color: TectaColors.secondaryMain,
                      size: TectaButtonSize.small,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Redirecting to upgrade...')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TectaAccordion(
            title: 'Fast & Spring Animation',
            subtitle: 'Customized curve and duration transition',
            duration: const Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            child: Text(
              'This accordion has a customized 500ms duration and an elastic out spring animation curve when transitioning between collapsed and expanded states.',
              style: TectaTypography.body2.copyWith(color: TectaColors.grey600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        title,
        style: TectaTypography.overline.copyWith(
          color: TectaColors.grey500,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
