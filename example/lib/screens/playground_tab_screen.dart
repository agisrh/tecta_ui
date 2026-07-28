import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class PlaygroundTabScreen extends StatefulWidget {
  const PlaygroundTabScreen({super.key});

  @override
  State<PlaygroundTabScreen> createState() => _PlaygroundTabScreenState();
}

class _PlaygroundTabScreenState extends State<PlaygroundTabScreen> {
  // Playground state variables
  String _buttonLabel = 'Tecta Action';
  Color _buttonColor = TectaColors.primaryMain;
  TectaButtonVariant _variant = TectaButtonVariant.contained;
  TectaButtonSize _size = TectaButtonSize.medium;
  bool _loading = false;
  bool _disabled = false;
  bool _hasIcon = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interactive Playground',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : TectaColors.grey900,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Configure properites live to see how Tecta UI elements adapt instantly.',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : TectaColors.grey600,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left: live preview canvas
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
                    ),
                    child: Center(
                      child: TectaButton(
                        label: _buttonLabel,
                        color: _buttonColor,
                        variant: _variant,
                        size: _size,
                        loading: _loading,
                        icon: _hasIcon ? const Icon(SolarLinearIcons.letter) : null,
                        onPressed: _disabled ? null : () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                // Right: controller configurations pane
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PROPERTIES',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white60 : TectaColors.grey500,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Label controller
                          Text('Button Label', style: theme.textTheme.titleSmall),
                          const SizedBox(height: 8),
                          TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            controller: TextEditingController(text: _buttonLabel),
                            onChanged: (val) {
                              setState(() {
                                _buttonLabel = val;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          // Variant selection
                          Text('Variant', style: theme.textTheme.titleSmall),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<TectaButtonVariant>(
                            value: _variant,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            items: TectaButtonVariant.values.map((v) {
                              return DropdownMenuItem(
                                value: v,
                                child: Text(v.toString().split('.').last),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _variant = val;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          // Size selection
                          Text('Size', style: theme.textTheme.titleSmall),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<TectaButtonSize>(
                            value: _size,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            items: TectaButtonSize.values.map((s) {
                              return DropdownMenuItem(
                                value: s,
                                child: Text(s.toString().split('.').last),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _size = val;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          // Checkbox controls
                          SwitchListTile(
                            title: const Text('Loading'),
                            value: _loading,
                            onChanged: (val) => setState(() => _loading = val),
                            contentPadding: EdgeInsets.zero,
                          ),
                          SwitchListTile(
                            title: const Text('Disabled'),
                            value: _disabled,
                            onChanged: (val) => setState(() => _disabled = val),
                            contentPadding: EdgeInsets.zero,
                          ),
                          SwitchListTile(
                            title: const Text('With Icon'),
                            value: _hasIcon,
                            onChanged: (val) => setState(() => _hasIcon = val),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
