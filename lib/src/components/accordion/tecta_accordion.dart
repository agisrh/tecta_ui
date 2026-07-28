import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium, highly dynamic Accordion component for the Tecta Design System.
/// Features a customizable header and content area with dynamic styling parameters:
/// - Custom title/subtitle text styles
/// - Custom box shadows (shadows can be passed or disabled)
/// - Configurable border radius, borders, padding, and margins
/// - Expand/collapse duration, curve, and rotation animation
class TectaAccordion extends StatefulWidget {
  /// The title of the accordion header
  final String title;

  /// An optional subtitle displaying below the title
  final String? subtitle;

  /// Optional leading widget (usually an Icon using SolarLinearIcons)
  final Widget? leading;

  /// The child content containing body text or widgets when expanded
  final Widget child;

  /// Defines if the accordion is expanded initially
  final bool initiallyExpanded;

  /// Callback when the expanded state changes
  final ValueChanged<bool>? onExpansionChanged;

  /// Background color of the accordion card
  final Color? backgroundColor;

  /// Defines if the accordion is disabled and cannot be toggled
  final bool isDisabled;

  // ===========================================================================
  // DYNAMIC STYLING PARAMETERS
  // ===========================================================================

  /// Custom text style for the title. Defaults to `TectaTypography.subtitle1`.
  final TextStyle? titleStyle;

  /// Custom text style for the subtitle. Defaults to `TectaTypography.caption`.
  final TextStyle? subtitleStyle;

  /// Custom border radius. Defaults to `BorderRadius.circular(16.0)`.
  final BorderRadius? borderRadius;

  /// Custom border. Defaults to a subtle thin border using `theme.dividerColor`.
  /// Pass `Border.all(color: Colors.transparent)` to disable the border.
  final BoxBorder? border;

  /// Custom box shadow list. Defaults to empty list (no shadows) to fit KALOG's main specs.
  /// Pass `TectaShadows.z4` or similar to add soft elevations dynamically.
  final List<BoxShadow>? boxShadow;

  /// Custom margins around the accordion card container. Defaults to `EdgeInsets.zero`.
  final EdgeInsetsGeometry? margin;

  /// Custom padding inside the header area. Defaults to `EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)`.
  final EdgeInsetsGeometry? headerPadding;

  /// Custom padding inside the content area when expanded. Defaults to `EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0)`.
  final EdgeInsetsGeometry? contentPadding;

  /// Transition duration for expanding / collapsing. Defaults to `250ms`.
  final Duration duration;

  /// Animation curve for the expand height transition. Defaults to `Curves.fastOutSlowIn`.
  final Curve curve;

  /// Custom trailing icon widget when collapsed. Defaults to `Icons.keyboard_arrow_down`.
  final Widget? trailingIcon;

  /// Disable rotating animation for the trailing chevron icon. Defaults to `false`.
  final bool disableIconRotation;

  /// Custom splash color for ink well feedback.
  final Color? splashColor;

  /// Custom highlight color for ink well feedback.
  final Color? highlightColor;

  /// Creates a [TectaAccordion] collapsible card component.
  const TectaAccordion({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.leading,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.backgroundColor,
    this.isDisabled = false,
    this.titleStyle,
    this.subtitleStyle,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.margin = EdgeInsets.zero,
    this.headerPadding,
    this.contentPadding,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.fastOutSlowIn,
    this.trailingIcon,
    this.disableIconRotation = false,
    this.splashColor,
    this.highlightColor,
  });

  @override
  State<TectaAccordion> createState() => _TectaAccordionState();
}

class _TectaAccordionState extends State<TectaAccordion> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  late Animation<double> _iconTurns;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = PageStorage.of(context).readState(context) as bool? ?? widget.initiallyExpanded;

    _controller = AnimationController(duration: widget.duration, vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: widget.curve));
    _iconTurns = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.5).chain(CurveTween(curve: Curves.easeIn)),
    );

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant TectaAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
    // Handle programmatic expansion changes if needed
    if (widget.initiallyExpanded != oldWidget.initiallyExpanded &&
        widget.initiallyExpanded != _isExpanded) {
      _handleTap();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isDisabled) return;

    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild so height factor settles
          });
        });
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });

    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildHeader(BuildContext context) {
    final finalTitleStyle = widget.titleStyle ?? TectaTypography.subtitle1;
    final finalSubtitleStyle = widget.subtitleStyle ?? TectaTypography.caption;
    final defaultHeaderPadding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
    final finalBorderRadius = widget.borderRadius ?? BorderRadius.circular(16.0);

    // Interpolate icon color dynamically during expansion
    final iconColor = Color.lerp(
      widget.isDisabled ? TectaColors.grey400 : TectaColors.grey600,
      TectaColors.primaryMain,
      _heightFactor.value,
    )!;

    return Semantics(
      button: true,
      enabled: !widget.isDisabled,
      label: widget.title,
      hint: _isExpanded ? 'Collapse' : 'Expand',
      child: InkWell(
        onTap: widget.isDisabled ? null : _handleTap,
        borderRadius: finalBorderRadius,
        splashColor: widget.splashColor,
        highlightColor: widget.highlightColor,
        child: Padding(
          padding: widget.headerPadding ?? defaultHeaderPadding,
          child: Row(
            children: [
              if (widget.leading != null) ...[
                Opacity(opacity: widget.isDisabled ? 0.4 : 1.0, child: widget.leading!),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: finalTitleStyle.copyWith(
                        color: widget.isDisabled
                            ? TectaColors.grey400
                            : (widget.titleStyle?.color ?? TectaColors.grey800),
                        fontWeight: widget.titleStyle?.fontWeight ?? FontWeight.w700,
                      ),
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle!,
                        style: finalSubtitleStyle.copyWith(
                          color: widget.isDisabled
                              ? TectaColors.grey400
                              : (widget.subtitleStyle?.color ?? TectaColors.grey500),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (widget.disableIconRotation)
                widget.trailingIcon ??
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: iconColor,
                      size: 24,
                    )
              else
                RotationTransition(
                  turns: _iconTurns,
                  child:
                      widget.trailingIcon ??
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: iconColor,
                        size: 24,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Widget? child) {
    final defaultContentPadding = const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0);
    return SizeTransition(
      sizeFactor: _heightFactor,
      child: FadeTransition(
        opacity: _heightFactor,
        child: Container(
          width: double.infinity,
          padding: widget.contentPadding ?? defaultContentPadding,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finalBorderRadius = widget.borderRadius ?? BorderRadius.circular(16.0);

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        // Soft primary tint on border when expanded
        final borderSideColor = Color.lerp(
          theme.dividerColor,
          TectaColors.primaryMain.withValues(alpha: 0.25),
          _heightFactor.value,
        )!;
        final finalBorder = widget.border ?? Border.all(color: borderSideColor, width: 1.0);

        // Soft elevation shadow lift when expanded
        final resolvedBoxShadow = widget.boxShadow ?? [
          BoxShadow(
            color: TectaColors.primaryMain.withValues(alpha: 0.04 * _heightFactor.value),
            blurRadius: 12.0 * _heightFactor.value,
            offset: Offset(0, 4.0 * _heightFactor.value),
          ),
        ];

        return Container(
          margin: widget.margin,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? theme.cardColor,
            borderRadius: finalBorderRadius,
            border: finalBorder,
            boxShadow: resolvedBoxShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              ClipRect(child: _buildContent(context, child)),
            ],
          ),
        );
      },
    );
  }
}
