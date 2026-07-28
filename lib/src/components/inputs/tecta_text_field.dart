import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Visual variants for [TectaTextField].
enum TectaTextFieldVariant { outlined, filled, standard }

/// Sizing options for [TectaTextField].
enum TectaTextFieldSize { small, medium }

/// A premium, highly customizable Text Field and Dropdown Select component
/// matching Minimals design language.
class TectaTextField<T> extends StatelessWidget {
  /// The controller for standard text field inputs.
  final TextEditingController? controller;

  /// Optional initial value.
  final String? initialValue;

  /// Optional focus node.
  final FocusNode? focusNode;

  /// The keyboard type for text input.
  final TextInputType? keyboardType;

  /// The action button on the keyboard.
  final TextInputAction? textInputAction;

  /// Whether to hide the text (e.g. for password inputs).
  final bool obscureText;

  /// Whether to auto-focus the field.
  final bool autofocus;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Whether the input is enabled.
  final bool enabled;

  /// Maximum number of lines. Defaults to 1.
  final int? maxLines;

  /// Minimum number of lines.
  final int? minLines;

  /// Maximum length of characters.
  final int? maxLength;

  /// Callback when text changes.
  final ValueChanged<String>? onChanged;

  /// Callback when the input is tapped.
  final VoidCallback? onTap;

  /// Callback when the form is submitted.
  final ValueChanged<String>? onFieldSubmitted;

  /// Callback when the form field is saved.
  final FormFieldSetter<String>? onSaved;

  /// Form validator callback.
  final FormFieldValidator<String>? validator;

  /// The floating label text.
  final String? label;

  /// The hint placeholder text.
  final String? placeholder;

  /// The helper text displayed below the field.
  final String? helperText;

  /// The error text displayed below the field (turns borders red).
  final String? errorText;

  /// Leading widget (e.g. an Icon).
  final Widget? prefixIcon;

  /// Trailing widget (e.g. an IconButton or toggle).
  final Widget? suffixIcon;

  /// Optional static text prefix.
  final String? prefixText;

  /// Optional static text suffix.
  final String? suffixText;

  /// The visual variant style. Defaults to [TectaTextFieldVariant.outlined].
  final TectaTextFieldVariant variant;

  /// The size density. Defaults to [TectaTextFieldSize.medium].
  final TectaTextFieldSize size;

  // ===========================================================================
  // SELECT (DROPDOWN) SPECIFIC FIELDS
  // ===========================================================================

  /// List of dropdown items. If provided, the widget acts as a dropdown select.
  final List<DropdownMenuItem<T>>? items;

  /// The currently selected value of the dropdown.
  final T? selectedValue;

  /// Callback when a dropdown item is selected.
  final ValueChanged<T?>? onSelectChanged;

  /// Dropdown validation callback.
  final FormFieldValidator<T>? selectValidator;

  // ===========================================================================
  // DYNAMIC STYLE OVERRIDES
  // ===========================================================================

  /// Custom active border color override.
  final Color? activeBorderColorOverride;

  /// Custom inactive border color override.
  final Color? inactiveBorderColorOverride;

  /// Custom background fill color override.
  final Color? fillColorOverride;

  /// Custom border radius override.
  final double? borderRadiusOverride;

  /// Custom label text style override.
  final TextStyle? labelStyleOverride;

  /// Custom input text style override.
  final TextStyle? textStyleOverride;

  /// Custom prefix icon color override.
  final Color? prefixIconColorOverride;

  /// Custom suffix icon color override.
  final Color? suffixIconColorOverride;

  /// Custom error color override.
  final Color? errorColorOverride;

  /// Creates a [TectaTextField] input text field component.
  const TectaTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.variant = TectaTextFieldVariant.outlined,
    this.size = TectaTextFieldSize.medium,
    this.items,
    this.selectedValue,
    this.onSelectChanged,
    this.selectValidator,
    this.activeBorderColorOverride,
    this.inactiveBorderColorOverride,
    this.fillColorOverride,
    this.borderRadiusOverride,
    this.labelStyleOverride,
    this.textStyleOverride,
    this.prefixIconColorOverride,
    this.suffixIconColorOverride,
    this.errorColorOverride,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = activeBorderColorOverride ?? TectaColors.primaryMain;
    final inactiveColor = inactiveBorderColorOverride ?? TectaColors.grey300;
    final errorColor = errorColorOverride ?? TectaColors.errorMain;
    final double radius = borderRadiusOverride ?? 8.0;

    // Density content padding depending on variant and size
    EdgeInsets contentPadding;
    if (variant == TectaTextFieldVariant.standard) {
      contentPadding = size == TectaTextFieldSize.small
          ? const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0)
          : const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0);
    } else if (variant == TectaTextFieldVariant.filled) {
      // Flutter's InputDecorator uses contentPadding to compute floating label
      // position. For filled style, top must be large enough to accommodate the
      // floated label (12px label + gap). Standard Material values work best.
      contentPadding = size == TectaTextFieldSize.small
          ? const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0)
          : const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0);
    } else {
      contentPadding = size == TectaTextFieldSize.small
          ? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0)
          : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0);
    }

    // Dynamic label and text styling
    final TextStyle defaultLabelStyle = TectaTypography.body2.copyWith(
      color: TectaColors.grey500,
    );
    final TextStyle defaultTextStyle = TectaTypography.body2.copyWith(
      color: TectaColors.grey800,
    );

    final resolvedLabelStyle = labelStyleOverride ?? defaultLabelStyle;
    final resolvedTextStyle = textStyleOverride ?? defaultTextStyle;

    // Build borders
    InputBorder inputBorder;
    InputBorder focusedInputBorder;
    InputBorder errorInputBorder;

    switch (variant) {
      case TectaTextFieldVariant.outlined:
        inputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: inactiveColor, width: 1.0),
        );
        focusedInputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: activeColor, width: 1.5),
        );
        errorInputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: errorColor, width: 1.5),
        );
        break;
      case TectaTextFieldVariant.filled:
        // OutlineInputBorder with BorderSide.none keeps the floating label
        // inside the filled background box and rounds all 4 corners.
        inputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        );
        focusedInputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        );
        errorInputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        );
        break;
      case TectaTextFieldVariant.standard:
        inputBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: inactiveColor, width: 1.0),
        );
        focusedInputBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: activeColor, width: 1.5),
        );
        errorInputBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: errorColor, width: 1.5),
        );
        break;
    }

    // Resolve Prefix & Suffix Icon Colors
    Widget? resolvedPrefix;
    if (prefixIcon != null) {
      resolvedPrefix = IconTheme.merge(
        data: IconThemeData(
          color: prefixIconColorOverride ?? TectaColors.grey500,
          size: size == TectaTextFieldSize.small ? 20.0 : 22.0,
        ),
        child: prefixIcon!,
      );
    }

    Widget? resolvedSuffix;
    if (suffixIcon != null) {
      resolvedSuffix = IconTheme.merge(
        data: IconThemeData(
          color: suffixIconColorOverride ?? TectaColors.grey500,
          size: size == TectaTextFieldSize.small ? 20.0 : 22.0,
        ),
        child: suffixIcon!,
      );
    }

    // Resolve Background Fill
    final bool isFilled = variant == TectaTextFieldVariant.filled;
    final Color defaultFill = isFilled && errorText != null
        ? TectaColors.errorLighter.withValues(alpha: 0.5)
        : TectaColors.grey200;
    final Color? resolvedFillColor = isFilled ? (fillColorOverride ?? defaultFill) : null;

    final decoration = InputDecoration(
      labelText: label,
      labelStyle: resolvedLabelStyle,
      // For filled, use a smaller floating label so it sits neatly above the text
      floatingLabelStyle: (labelStyleOverride ?? TectaTypography.caption).copyWith(
        color: errorText != null ? errorColor : activeColor,
      ),
      hintText: placeholder,
      hintStyle: TectaTypography.body2.copyWith(color: TectaColors.grey400),
      helperText: helperText,
      helperStyle: TectaTypography.caption.copyWith(color: TectaColors.grey500),
      errorText: errorText,
      errorStyle: TectaTypography.caption.copyWith(color: errorColor),
      contentPadding: contentPadding,
      filled: isFilled,
      fillColor: resolvedFillColor,
      prefixIcon: resolvedPrefix,
      suffixIcon: resolvedSuffix,
      prefixText: prefixText,
      suffixText: suffixText,
      prefixStyle: TectaTypography.body2.copyWith(color: TectaColors.grey500),
      suffixStyle: TectaTypography.body2.copyWith(color: TectaColors.grey500),
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: focusedInputBorder,
      errorBorder: errorInputBorder,
      focusedErrorBorder: errorInputBorder,
    );

    Widget fieldWidget;

    // If dropdown select options are provided, render DropdownButtonFormField
    if (items != null) {
      fieldWidget = DropdownButtonFormField<T>(
        items: items,
        initialValue: selectedValue,
        onChanged: enabled ? onSelectChanged : null,
        validator: selectValidator,
        style: resolvedTextStyle,
        decoration: decoration,
        icon: Icon(
          Icons.expand_more,
          color: TectaColors.grey500,
          size: size == TectaTextFieldSize.small ? 20.0 : 24.0,
        ),
        dropdownColor: TectaColors.white,
        borderRadius: BorderRadius.circular(radius),
      );
    } else {
      // Otherwise, render standard TextFormField
      fieldWidget = TextFormField(
        controller: controller,
        initialValue: initialValue,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        autofocus: autofocus,
        readOnly: readOnly,
        enabled: enabled,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        validator: validator,
        style: resolvedTextStyle,
        decoration: decoration,
      );
    }

    return Opacity(opacity: enabled ? 1.0 : 0.48, child: fieldWidget);
  }
}
