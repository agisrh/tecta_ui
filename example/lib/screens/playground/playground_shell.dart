// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecta_ui/tecta_ui.dart';
import 'playground_mega_menu.dart';
import 'playground_code_controller.dart';

class PlaygroundShell extends StatefulWidget {
  final String templateName;
  final String defaultCode;
  final ValueChanged<String> onTemplateChanged;
  final Widget docContent;
  final void Function(String code) onCodeChanged;
  final Widget preview;

  const PlaygroundShell({
    super.key,
    required this.templateName,
    required this.defaultCode,
    required this.onTemplateChanged,
    required this.docContent,
    required this.onCodeChanged,
    required this.preview,
  });

  @override
  State<PlaygroundShell> createState() => _PlaygroundShellState();
}

class _PlaygroundShellState extends State<PlaygroundShell> {
  late CodePlaygroundController _codeController;
  Timer? _debounce;

  double _previewScale = 1.0;
  bool _isMobilePreview = false;
  bool _isDarkPreview = true;
  bool _isDocExpanded = true;

  @override
  void initState() {
    super.initState();
    _codeController = CodePlaygroundController();
    _codeController.text = widget.defaultCode;
    _codeController.addListener(_onCodeChanged);
    // Trigger initial parsing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onCodeChanged(widget.defaultCode);
    });
  }

  @override
  void dispose() {
    _codeController.removeListener(_onCodeChanged);
    _codeController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onCodeChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onCodeChanged(_codeController.text);
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _codeController.text));
    TectaSnackbar.show(
      context,
      message: 'Code snippet copied to clipboard!',
      variant: TectaSnackbarVariant.success,
      alignment: Alignment.bottomCenter,
    );
  }

  final LayerLink _megaMenuLayerLink = LayerLink();
  OverlayEntry? _megaMenuOverlay;

  void _openMegaMenu() {
    if (_megaMenuOverlay != null) {
      _closeMegaMenu();
      return;
    }
    _megaMenuOverlay = OverlayEntry(builder: (ctx) => _buildMegaMenuOverlay(ctx));
    Overlay.of(context).insert(_megaMenuOverlay!);
    setState(() {});
  }

  void _refreshMegaMenu() {
    _megaMenuOverlay?.markNeedsBuild();
  }

  void _closeMegaMenu() {
    _megaMenuOverlay?.remove();
    _megaMenuOverlay = null;
    if (mounted) setState(() {});
  }

  Widget _buildMegaMenuOverlay(BuildContext ctx) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _closeMegaMenu,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.transparent)),
          CompositedTransformFollower(
            link: _megaMenuLayerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 36),
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {}, // prevent close when tapping inside menu
                child: PlaygroundMegaMenu(
                  selectedTemplate: widget.templateName,
                  onTemplateSelected: (item) {
                    widget.onTemplateChanged(item);
                    _refreshMegaMenu();
                    _closeMegaMenu();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Simple Dropdown (for Zoom) ──────────────────────────────────────────────
  Widget _buildTopDropdown({
    required String label,
    required List<String> items,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return PopupMenuButton<String>(
      tooltip: 'Select $label',
      offset: const Offset(0, 36),
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFF333333)),
      ),
      onSelected: onChanged,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF252526),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF3C3C3C)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white38,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        return items.map((item) {
          final isSelected = item == value;
          return PopupMenuItem<String>(
            value: item,
            height: 36,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_rounded,
                    color: TectaColors.primaryMain,
                    size: 14,
                  ),
              ],
            ),
          );
        }).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF161616),
      child: Row(
        children: [
          // Left Pane: Code Editor
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Color(0xFF2D2D2D), width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Editor Header
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: const Color(0xFF1E1E1E),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Playground',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.auto_awesome_rounded, size: 16, color: Colors.white38),
                            const SizedBox(width: 16),
                            // Templates Mega Menu trigger
                            CompositedTransformTarget(
                              link: _megaMenuLayerLink,
                              child: GestureDetector(
                                onTap: _openMegaMenu,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3A3A3C),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Templates',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Editor Body with Line Numbers
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      color: const Color(0xFF1E1E1E),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Line numbers column
                          Container(
                            width: 44,
                            padding: const EdgeInsets.only(right: 8),
                            alignment: Alignment.topRight,
                            child: ListView.builder(
                              itemCount: 40,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 13,
                                    color: Color(0xFF5A5A5A),
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.right,
                                );
                              },
                            ),
                          ),
                          // Editable code area
                          Expanded(
                            child: TextField(
                              controller: _codeController,
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 13,
                                color: Color(0xFFD4D4D4),
                                height: 1.5,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Collapsible API Reference Panel
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E1E1E),
                      border: Border(
                        top: BorderSide(color: Color(0xFF2D2D2D), width: 1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => setState(() => _isDocExpanded = !_isDocExpanded),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.menu_book_rounded,
                                        size: 16, color: TectaColors.primaryMain),
                                    const SizedBox(width: 8),
                                    Text(
                                      'API REFERENCE',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white.withValues(alpha: 0.8),
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  _isDocExpanded
                                      ? Icons.keyboard_arrow_down_rounded
                                      : Icons.keyboard_arrow_up_rounded,
                                  color: Colors.white54,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_isDocExpanded)
                          Container(
                            height: 180,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            color: const Color(0xFF151515),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: widget.docContent,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Pane: Preview Canvas
          Expanded(
            flex: 5,
            child: Container(
              color: const Color(0xFF161616),
              child: Column(
                children: [
                  // Canvas Header
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: const Color(0xFF1E1E1E),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.white70),
                          tooltip: 'Reset Code',
                          onPressed: () {
                            _codeController.text = widget.defaultCode;
                            widget.onCodeChanged(widget.defaultCode);
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                _isDarkPreview ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                                size: 18,
                                color: Colors.white70,
                              ),
                              tooltip: 'Toggle Canvas Theme',
                              onPressed: () => setState(() => _isDarkPreview = !_isDarkPreview),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(
                                _isMobilePreview
                                    ? Icons.phone_android_rounded
                                    : Icons.computer_rounded,
                                size: 18,
                                color: Colors.white70,
                              ),
                              tooltip: 'Toggle Device Layout',
                              onPressed: () => setState(() => _isMobilePreview = !_isMobilePreview),
                            ),
                            const SizedBox(width: 8),
                            _buildTopDropdown(
                              label: 'Zoom',
                              items: ['50%', '75%', '100%', '125%', '150%'],
                              value: '${(_previewScale * 100).toInt()}%',
                              onChanged: (val) {
                                if (val != null) {
                                  final numVal = double.tryParse(val.replaceAll('%', '')) ?? 100.0;
                                  setState(() {
                                    _previewScale = numVal / 100.0;
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF444444)),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              ),
                              onPressed: _copyToClipboard,
                              icon: const Icon(Icons.copy_all_rounded, size: 16),
                              label: const Text('Export',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Canvas preview body
                  Expanded(
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _isMobilePreview ? 360 : null,
                        height: _isMobilePreview ? 640 : null,
                        decoration: BoxDecoration(
                          color: _isDarkPreview ? const Color(0xFF222222) : const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(_isMobilePreview ? 24.0 : 0.0),
                          border: _isMobilePreview
                              ? Border.all(color: const Color(0xFF333333), width: 8)
                              : null,
                          boxShadow: _isMobilePreview
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    blurRadius: 24,
                                    offset: const Offset(0, 12),
                                  ),
                                ]
                              : null,
                        ),
                        child: Transform.scale(
                          scale: _previewScale,
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 600),
                                  child: widget.preview,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
