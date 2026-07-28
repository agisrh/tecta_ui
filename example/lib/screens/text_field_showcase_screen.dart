import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class TextFieldShowcasePage extends StatefulWidget {
  const TextFieldShowcasePage({super.key});

  @override
  State<TextFieldShowcasePage> createState() => _TextFieldShowcasePageState();
}

class _TextFieldShowcasePageState extends State<TextFieldShowcasePage> {
  // Dropdown states
  String _selectedValue = 'EUR';

  // Password toggle state
  bool _isPasswordObscured = true;

  // Controllers for general inputs to show "Activated *" values
  late final TextEditingController _activatedController;
  late final TextEditingController _passwordController;
  late final TextEditingController _disabledController;
  late final TextEditingController _helperController;
  late final TextEditingController _errorController;
  late final TextEditingController _multilineControlledController;
  late final TextEditingController _multilineDefaultController;

  @override
  void initState() {
    super.initState();
    _activatedController = TextEditingController(text: '2Minimal');
    _passwordController = TextEditingController(text: '12345678');
    _disabledController = TextEditingController(text: '2Minimal');
    _helperController = TextEditingController(text: '2Minimal');
    _errorController = TextEditingController(text: '2Minimal');
    _multilineControlledController = TextEditingController(text: 'Controlled');
    _multilineDefaultController = TextEditingController(text: 'Default value');
  }

  @override
  void dispose() {
    _activatedController.dispose();
    _passwordController.dispose();
    _disabledController.dispose();
    _helperController.dispose();
    _errorController.dispose();
    _multilineControlledController.dispose();
    _multilineDefaultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
          title: Text(
            'TextField',
            style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: TectaColors.grey200,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TabBar(
                  labelColor: TectaColors.grey900,
                  unselectedLabelColor: TectaColors.grey500,
                  labelStyle: TectaTypography.subtitle2.copyWith(fontWeight: FontWeight.w600),
                  unselectedLabelStyle: TectaTypography.subtitle2.copyWith(fontWeight: FontWeight.w500),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: TectaColors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: TectaShadows.z1,
                  ),
                  tabs: const [
                    Tab(text: 'Outlined'),
                    Tab(text: 'Filled'),
                    Tab(text: 'Standard'),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: TectaColors.grey100,
        body: TabBarView(
          children: [
            _buildVariantTab(TectaTextFieldVariant.outlined),
            _buildVariantTab(TectaTextFieldVariant.filled),
            _buildVariantTab(TectaTextFieldVariant.standard),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantTab(TectaTextFieldVariant variant) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      children: [
        _buildSectionHeader('General'),
        const SizedBox(height: 12),
        _buildCard(
          child: Column(
            children: [
              TectaTextField(
                variant: variant,
                placeholder: 'Inactive',
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                label: 'Activated *',
                controller: _activatedController,
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                label: 'Password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                label: 'Disabled',
                enabled: false,
                controller: _disabledController,
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                placeholder: '${variant.name.substring(0, 1).toUpperCase()}${variant.name.substring(1)} Input',
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('With adornments'),
        const SizedBox(height: 12),
        _buildCard(
          child: Column(
            children: [
              TectaTextField(
                variant: variant,
                label: 'Enabled',
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                label: 'Disabled',
                enabled: false,
                placeholder: 'Default value',
                prefixIcon: const Icon(Icons.person),
                helperText: 'Helper text',
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                label: 'With normal TextField',
                prefixText: 'Kg',
                suffixIcon: TextButton(
                  onPressed: () {},
                  child: const Text('Action', style: TextStyle(color: TectaColors.white)),
                ),
                suffixIconColorOverride: TectaColors.grey800,
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                placeholder: 'End adornment',
                suffixText: 'Kg',
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                label: 'Password',
                obscureText: _isPasswordObscured,
                prefixIcon: const Icon(Icons.person),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('With helper text'),
        const SizedBox(height: 12),
        _buildCard(
          child: Column(
            children: [
              TectaTextField(
                variant: variant,
                label: 'Helper text',
                controller: _helperController,
                helperText: 'Helper text',
              ),
              const SizedBox(height: 24),
              TectaTextField(
                variant: variant,
                label: 'Error',
                controller: _errorController,
                errorText: 'Error text',
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('Type'),
        const SizedBox(height: 12),
        _buildCard(
          child: Column(
            children: [
              TectaTextField(
                variant: variant,
                placeholder: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                placeholder: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('Sizes'),
        const SizedBox(height: 12),
        _buildCard(
          child: Column(
            children: [
              TectaTextField(
                variant: variant,
                size: TectaTextFieldSize.small,
                label: 'Size',
                placeholder: 'Small',
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                size: TectaTextFieldSize.medium,
                label: 'Size',
                placeholder: 'Medium',
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('Select'),
        const SizedBox(height: 12),
        _buildCard(
          child: Column(
            children: [
              TectaTextField<String>(
                variant: variant,
                label: 'Select',
                selectedValue: _selectedValue,
                onSelectChanged: (val) => setState(() => _selectedValue = val!),
                items: const [
                  DropdownMenuItem(value: 'USD', child: Text('\$')),
                  DropdownMenuItem(value: 'EUR', child: Text('€')),
                  DropdownMenuItem(value: 'GBP', child: Text('£')),
                  DropdownMenuItem(value: 'JPY', child: Text('¥')),
                ],
                helperText: 'Please select your currency',
              ),
              const SizedBox(height: 24),
              TectaTextField<String>(
                variant: variant,
                label: 'Native select',
                selectedValue: _selectedValue,
                onSelectChanged: (val) => setState(() => _selectedValue = val!),
                items: const [
                  DropdownMenuItem(value: 'USD', child: Text('\$')),
                  DropdownMenuItem(value: 'EUR', child: Text('€')),
                  DropdownMenuItem(value: 'GBP', child: Text('£')),
                  DropdownMenuItem(value: 'JPY', child: Text('¥')),
                ],
                helperText: 'Please select your currency',
              ),
              const SizedBox(height: 24),
              TectaTextField<String>(
                variant: variant,
                label: 'Form control select',
                selectedValue: _selectedValue,
                onSelectChanged: (val) => setState(() => _selectedValue = val!),
                items: const [
                  DropdownMenuItem(value: 'USD', child: Text('\$')),
                  DropdownMenuItem(value: 'EUR', child: Text('€')),
                  DropdownMenuItem(value: 'GBP', child: Text('£')),
                  DropdownMenuItem(value: 'JPY', child: Text('¥')),
                ],
              ),
              const SizedBox(height: 24),
              TectaTextField<String>(
                variant: variant,
                label: 'Form control select (native)',
                selectedValue: _selectedValue,
                onSelectChanged: (val) => setState(() => _selectedValue = val!),
                items: const [
                  DropdownMenuItem(value: 'USD', child: Text('\$')),
                  DropdownMenuItem(value: 'EUR', child: Text('€')),
                  DropdownMenuItem(value: 'GBP', child: Text('£')),
                  DropdownMenuItem(value: 'JPY', child: Text('¥')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('Multiline'),
        const SizedBox(height: 12),
        _buildCard(
          child: Column(
            children: [
              TectaTextField(
                variant: variant,
                label: 'Multiline',
                controller: _multilineControlledController,
                maxLines: null,
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                placeholder: 'Multiline placeholder',
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                label: 'Multiline',
                controller: _multilineDefaultController,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              TectaTextField(
                variant: variant,
                placeholder: 'No label',
                maxLines: 4,
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: child,
    );
  }
}
