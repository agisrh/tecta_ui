import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class AccordionShowcasePage extends StatefulWidget {
  const AccordionShowcasePage({super.key});

  @override
  State<AccordionShowcasePage> createState() => _AccordionShowcasePageState();
}

class _AccordionShowcasePageState extends State<AccordionShowcasePage> {
  int _expandedIndex = -1;

  bool _pushNotifications = true;
  bool _emailNotifications = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'Accordion',
                style: TectaTypography.h4.copyWith(
                  color: isDark ? Colors.white : TectaColors.grey800,
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
            title: 'Simple Accordions',
            note: 'TectaAccordion displays collapsible content segments. Supports titles, optional helper subtitle texts, and clean icon-rotation animations.',
            code: '''TectaAccordion(
  title: 'Basic Settings',
  subtitle: 'Configure details here',
  child: Text('Accordion content body'),
)''',
            overview: SizedBox(
              width: 540,
              child: Column(
                children: [
                  TectaAccordion(
                    title: 'Accordion 1',
                    child: Text(
                      'This is the body content of the first simple accordion. It has no leading icons or subtitles, giving a minimal clean look.',
                      style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TectaAccordion(
                    title: 'Accordion 2',
                    subtitle: 'With an optional helper subtitle text',
                    child: Text(
                      'This accordion has a title and a subtitle. Subtitles are helpful for providing extra context without cluttering the main header title text.',
                      style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Interactive Content & Leading Icons',
            note: 'Incorporate complex widget hierarchies (like forms, buttons, or list items) and leading decorative icons.',
            code: '''TectaAccordion(
  title: 'Account Settings',
  leading: Icon(Icons.person),
  child: Column(
    children: [TectaSwitch(...)],
  ),
)''',
            overview: SizedBox(
              width: 540,
              child: Column(
                children: [
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
                          style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Push Notifications', style: TectaTypography.subtitle2.copyWith(color: isDark ? Colors.white : TectaColors.grey800)),
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
                            Text('Email Reports', style: TectaTypography.subtitle2.copyWith(color: isDark ? Colors.white : TectaColors.grey800)),
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
                    leading: Icon(
                      SolarLinearIcons.user,
                      color: isDark ? Colors.white : TectaColors.grey800,
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
                                Text('John Doe', style: TectaTypography.subtitle2.copyWith(color: isDark ? Colors.white : TectaColors.grey800)),
                                Text('john.doe@example.com', style: TectaTypography.caption.copyWith(color: isDark ? Colors.white54 : TectaColors.grey500)),
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
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Accordion Group (Single Expand)',
            note: 'Pass dynamic open indexes down to options to enforce single expand behavior in lists.',
            code: '''TectaAccordion(
  initiallyExpanded: _expandedIndex == index,
  onExpansionChanged: (open) => setState(() => _expandedIndex = open ? index : -1),
)''',
            overview: SizedBox(
              width: 540,
              child: Column(
                children: List.generate(3, (index) {
                  final int itemIndex = index + 1;
                  return Padding(
                    key: ValueKey('group_item_$index'),
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TectaAccordion(
                      title: 'Group Accordion Item $itemIndex',
                      initiallyExpanded: _expandedIndex == index,
                      onExpansionChanged: (isExpanded) {
                        setState(() {
                          _expandedIndex = isExpanded ? index : -1;
                        });
                      },
                      child: Text(
                        'This is group accordion item $itemIndex. Expanding this item will automatically close all other expanded items in the group list.',
                        style: TectaTypography.body2.copyWith(color: isDark ? Colors.white60 : TectaColors.grey600),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Disabled State',
            note: 'Set isDisabled to true to freeze interactions on the accordion.',
            code: '''TectaAccordion(
  title: 'Disabled Option',
  isDisabled: true,
)''',
            overview: SizedBox(
              width: 540,
              child: const TectaAccordion(
                title: 'Disabled Accordion',
                subtitle: 'This accordion cannot be interacted with',
                isDisabled: true,
                leading: Icon(SolarLinearIcons.bell, color: TectaColors.grey400, size: 22),
                child: SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
