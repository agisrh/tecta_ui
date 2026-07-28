import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class LabelShowcasePage extends StatelessWidget {
  const LabelShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Label',
          style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: TectaColors.grey100,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          // ---------------------------------------------------------
          // FILLED VARIANT
          // ---------------------------------------------------------
          _buildSectionHeader('Filled'),
          const SizedBox(height: 12),
          _buildCard(
            child: Wrap(
              spacing: 8,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _buildColorLabels(TectaLabelVariant.filled),
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------------------------------------------
          // OUTLINED VARIANT
          // ---------------------------------------------------------
          _buildSectionHeader('Outlined'),
          const SizedBox(height: 12),
          _buildCard(
            child: Wrap(
              spacing: 8,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _buildColorLabels(TectaLabelVariant.outlined),
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------------------------------------------
          // SOFT VARIANT
          // ---------------------------------------------------------
          _buildSectionHeader('Soft'),
          const SizedBox(height: 12),
          _buildCard(
            child: Wrap(
              spacing: 8,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _buildColorLabels(TectaLabelVariant.soft),
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------------------------------------------
          // INVERTED VARIANT
          // ---------------------------------------------------------
          _buildSectionHeader('Inverted'),
          const SizedBox(height: 12),
          _buildCard(
            child: Wrap(
              spacing: 8,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _buildColorLabels(TectaLabelVariant.inverted),
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------------------------------------------
          // WITH ICON VARIANT
          // ---------------------------------------------------------
          _buildSectionHeader('With icon'),
          const SizedBox(height: 12),
          _buildCard(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaLabel(
                  text: 'Start icon',
                  variant: TectaLabelVariant.filled,
                  color: TectaColors.successMain,
                  startIcon: Icon(Icons.mail),
                ),
                const TectaLabel(
                  text: 'Start icon',
                  variant: TectaLabelVariant.outlined,
                  color: TectaColors.successMain,
                  startIcon: Icon(Icons.mail),
                ),
                const TectaLabel(
                  text: 'End icon',
                  variant: TectaLabelVariant.soft,
                  color: TectaColors.secondaryMain,
                  endIcon: Icon(Icons.mail),
                ),
                const TectaLabel(
                  text: 'End icon',
                  variant: TectaLabelVariant.inverted,
                  color: TectaColors.secondaryMain,
                  endIcon: Icon(Icons.mail),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------------------------------------------
          // CUSTOM COLORS VARIANT
          // ---------------------------------------------------------
          _buildSectionHeader('Custom Colors (Non-Tecta)'),
          const SizedBox(height: 12),
          _buildCard(
            child: Wrap(
              spacing: 8,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TectaLabel(text: 'Purple', variant: TectaLabelVariant.filled, color: Colors.purple),
                const TectaLabel(text: 'Purple', variant: TectaLabelVariant.outlined, color: Colors.purple),
                const TectaLabel(text: 'Purple', variant: TectaLabelVariant.soft, color: Colors.purple),
                const TectaLabel(text: 'Teal', variant: TectaLabelVariant.filled, color: Colors.teal),
                const TectaLabel(text: 'Teal', variant: TectaLabelVariant.outlined, color: Colors.teal),
                const TectaLabel(text: 'Deep Orange', variant: TectaLabelVariant.soft, color: Colors.deepOrange),
                const TectaLabel(text: 'Indigo', variant: TectaLabelVariant.inverted, color: Colors.indigo),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildColorLabels(TectaLabelVariant variant) {
    return [
      TectaLabel(text: 'Default', variant: variant, color: TectaColors.grey800),
      TectaLabel(text: 'Primary', variant: variant, color: TectaColors.primaryMain),
      TectaLabel(text: 'Secondary', variant: variant, color: TectaColors.secondaryMain),
      TectaLabel(text: 'Info', variant: variant, color: TectaColors.infoMain),
      TectaLabel(text: 'Success', variant: variant, color: TectaColors.successMain),
      TectaLabel(text: 'Warning', variant: variant, color: TectaColors.warningMain),
      TectaLabel(text: 'Error', variant: variant, color: TectaColors.errorMain),
      TectaLabel(text: 'Black', variant: variant, color: TectaColors.black),
      TectaLabel(text: 'White', variant: variant, color: TectaColors.white),
    ];
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
