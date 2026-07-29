import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class TextFieldShowcasePage extends StatefulWidget {
  const TextFieldShowcasePage({super.key});

  @override
  State<TextFieldShowcasePage> createState() => _TextFieldShowcasePageState();
}

class _TextFieldShowcasePageState extends State<TextFieldShowcasePage> {
  String _selectedValue = 'USD';
  bool _isPasswordObscured = true;

  late final TextEditingController _basicController;
  late final TextEditingController _passwordController;
  late final TextEditingController _helperController;
  late final TextEditingController _errorController;
  late final TextEditingController _multilineController;

  @override
  void initState() {
    super.initState();
    _basicController = TextEditingController(text: 'Tecta UI Input');
    _passwordController = TextEditingController(text: 'supersecret123');
    _helperController = TextEditingController(text: 'User input value');
    _errorController = TextEditingController(text: 'Invalid entry');
    _multilineController = TextEditingController(text: 'This is a multiline text area.\nFeel free to write long comments here.');
  }

  @override
  void dispose() {
    _basicController.dispose();
    _passwordController.dispose();
    _helperController.dispose();
    _errorController.dispose();
    _multilineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'TextField',
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
            title: 'Visual Variants',
            note: 'TectaTextField supports three major design variants: Outlined (default), Filled (subtle background), and Standard (bottom line border).',
            code: '''// Outlined (default)
TectaTextField(
  variant: TectaTextFieldVariant.outlined,
  placeholder: 'Outlined Variant',
)

// Filled
TectaTextField(
  variant: TectaTextFieldVariant.filled,
  placeholder: 'Filled Variant',
)

// Standard
TectaTextField(
  variant: TectaTextFieldVariant.standard,
  placeholder: 'Standard Variant',
)''',
            overview: Column(
              children: [
                TectaTextField(
                  variant: TectaTextFieldVariant.outlined,
                  placeholder: 'Outlined (Default)',
                  controller: _basicController,
                ),
                const SizedBox(height: 20),
                TectaTextField(
                  variant: TectaTextFieldVariant.filled,
                  placeholder: 'Filled',
                ),
                const SizedBox(height: 20),
                TectaTextField(
                  variant: TectaTextFieldVariant.standard,
                  placeholder: 'Standard Bottom Line',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Helper & Error States',
            note: 'Display support texts below the input boundary or trigger error borders with contextual helper message boxes.',
            code: '''TectaTextField(
  label: 'Normal Field',
  helperText: 'Required field indicator',
)

TectaTextField(
  label: 'Error Field',
  errorText: 'The value entered is invalid',
)''',
            overview: Column(
              children: [
                TectaTextField(
                  label: 'Account Name',
                  controller: _helperController,
                  helperText: 'Enter your profile organization alias',
                ),
                const SizedBox(height: 24),
                TectaTextField(
                  label: 'Billing Email',
                  controller: _errorController,
                  errorText: 'Please enter a valid email address (e.g. user@domain.com)',
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Adornments (Icons & Prefix/Suffix)',
            note: 'Prepend or append decorative prefix labels, icons, suffix texts, or interactive buttons (like password visibility toggles).',
            code: '''TectaTextField(
  prefixIcon: Icon(Icons.search),
  placeholder: 'Search resources...',
)

TectaTextField(
  suffixText: 'kg',
  placeholder: 'Weight metric',
)

// Password Visibility
TectaTextField(
  obscureText: _isObscured,
  suffixIcon: IconButton(
    icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
    onPressed: () => setState(() => _isObscured = !_isObscured),
  ),
)''',
            overview: Column(
              children: [
                const TectaTextField(
                  prefixIcon: Icon(Icons.search_rounded),
                  placeholder: 'Search across workspace projects...',
                ),
                const SizedBox(height: 20),
                const TectaTextField(
                  label: 'Storage Capacity',
                  suffixText: 'GB',
                  placeholder: '50',
                ),
                const SizedBox(height: 20),
                TectaTextField(
                  label: 'Secure Password',
                  obscureText: _isPasswordObscured,
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordObscured ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                    onPressed: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Sizes & Dimensions',
            note: 'TectaTextField supports medium (default) and small density layout options.',
            code: '''TectaTextField(
  size: TectaTextFieldSize.small,
  placeholder: 'Small variant',
)''',
            overview: Column(
              children: [
                const TectaTextField(
                  size: TectaTextFieldSize.small,
                  placeholder: 'Small Density input',
                ),
                const SizedBox(height: 20),
                TectaTextField(
                  size: TectaTextFieldSize.medium,
                  placeholder: 'Medium Density input (Default)',
                  controller: _basicController,
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Dropdown Select Option',
            note: 'Transform TectaTextField into a drop-down menu selector by passing values, callback listeners, and a collection of DropdownMenuItem items.',
            code: '''TectaTextField<String>(
  label: 'Choose Currency',
  selectedValue: _selectedValue,
  onSelectChanged: (val) => setState(() => _selectedValue = val!),
  items: const [
    DropdownMenuItem(value: 'USD', child: Text('USD (\$)')),
    DropdownMenuItem(value: 'EUR', child: Text('EUR (€)')),
  ],
)''',
            overview: TectaTextField<String>(
              label: 'Default Currency',
              selectedValue: _selectedValue,
              onSelectChanged: (val) {
                if (val != null) {
                  setState(() => _selectedValue = val);
                  _showFeedback('Selected: $val');
                }
              },
              items: const [
                DropdownMenuItem(value: 'USD', child: Text('United States Dollar (USD)')),
                DropdownMenuItem(value: 'EUR', child: Text('Euro (EUR)')),
                DropdownMenuItem(value: 'GBP', child: Text('British Pound (GBP)')),
                DropdownMenuItem(value: 'JPY', child: Text('Japanese Yen (JPY)')),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Multiline Inputs',
            note: 'Configure custom row heights or dynamic auto-sizing boxes using maxLines parameter.',
            code: '''TectaTextField(
  label: 'Notes',
  maxLines: null, // Auto-expand
)''',
            overview: Column(
              children: [
                TectaTextField(
                  label: 'Project Summary (Auto-expand)',
                  maxLines: null,
                  controller: _multilineController,
                ),
                const SizedBox(height: 20),
                const TectaTextField(
                  placeholder: 'Enter descriptions (Fixed 3 rows max)...',
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFeedback(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 1)),
    );
  }
}
