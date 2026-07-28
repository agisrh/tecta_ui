import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

class DividerShowcasePage extends StatelessWidget {
  const DividerShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
        title: Text(
          'Divider',
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
      backgroundColor: TectaColors.grey100,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          // ===========================================================================
          // HORIZONTAL DIVIDERS
          // ===========================================================================
          _buildSectionHeader('HORIZONTAL DIVIDERS'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              children: [
                const Text('Solid Divider (Default)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const TectaDivider(),
                const SizedBox(height: 24),
                const Text('Dashed Divider', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const TectaDivider(style: TectaDividerStyle.dashed),
                const SizedBox(height: 24),
                const Text('Dotted Divider', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const TectaDivider(style: TectaDividerStyle.dotted, thickness: 3.0),
                const SizedBox(height: 24),
                const Text('Thick colored with Indents',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const TectaDivider(
                  thickness: 4.0,
                  color: TectaColors.primaryMain,
                  indent: 32.0,
                  endIndent: 32.0,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ===========================================================================
          // VERTICAL DIVIDERS
          // ===========================================================================
          _buildSectionHeader('VERTICAL DIVIDERS'),
          const SizedBox(height: 16),
          _buildCard(
            child: SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Item 1'),
                  const TectaDivider(orientation: Axis.vertical),
                  const Text('Item 2'),
                  const TectaDivider(
                    orientation: Axis.vertical,
                    style: TectaDividerStyle.dashed,
                    color: TectaColors.errorMain,
                  ),
                  const Text('Item 3'),
                  const TectaDivider(
                    orientation: Axis.vertical,
                    style: TectaDividerStyle.dotted,
                    thickness: 4.0,
                    color: TectaColors.successMain,
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                  const Text('Item 4'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // ===========================================================================
          // DIVIDERS WITH LABELS
          // ===========================================================================
          _buildSectionHeader('DIVIDERS WITH LABELS'),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              children: [
                const Text(
                  'Label Centered',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TectaDivider(
                  label: Text(
                    'OR',
                    style: TectaTypography.caption.copyWith(
                      color: TectaColors.grey500,
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Label Start Align',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TectaDivider(
                  labelAlignment: TectaDividerLabelAlignment.start,
                  label: Text(
                    'Section A',
                    style: TectaTypography.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                const Text('Label End Align (with Icon)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TectaDivider(
                  labelAlignment: TectaDividerLabelAlignment.end,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: TectaColors.infoMain,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Info',
                        style: TectaTypography.caption.copyWith(
                          color: TectaColors.infoMain,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Dashed with Label & Custom Color',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TectaDivider(
                  style: TectaDividerStyle.dashed,
                  color: Colors.orange,
                  label: Text(
                    'CUSTOM',
                    style: TectaTypography.body2.copyWith(
                      color: Colors.orange,
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: child,
    );
  }
}
