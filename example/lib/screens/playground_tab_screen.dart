import 'package:flutter/material.dart';
import 'playground/foundation/colors/colors_playground.dart';
import 'playground/display/card/card_playground.dart';
import 'playground/forms/button/button_playground.dart';
import 'playground/feedback/alert/alert_playground.dart';
import 'playground/forms/text_field/text_field_playground.dart';
import 'playground/foundation/typography/typography_playground.dart';
import 'playground/foundation/shadows/shadows_playground.dart';
import 'playground/foundation/icons/icons_playground.dart';
import 'playground/forms/checkbox/checkbox_playground.dart';
import 'playground/forms/switch/switch_playground.dart';
import 'playground/forms/slider/slider_playground.dart';
import 'playground/forms/picker/picker_playground.dart';
import 'playground/forms/segmented_control/segmented_control_playground.dart';
import 'playground/feedback/skeleton/skeleton_playground.dart';
import 'playground/feedback/progress/progress_playground.dart';
import 'playground/display/accordion/accordion_playground.dart';
import 'playground/display/timeline/timeline_playground.dart';
import 'playground/display/tabs/tabs_playground.dart';
import 'playground/display/label/label_playground.dart';
import 'playground/overlays/dialog/dialog_playground.dart';
import 'playground/overlays/bottom_sheet/bottom_sheet_playground.dart';
import 'playground/overlays/snackbar/snackbar_playground.dart';
import 'playground/overlays/tooltip/tooltip_playground.dart';
import 'playground/overlays/dropdown_menu/dropdown_menu_playground.dart';

class PlaygroundTabScreen extends StatefulWidget {
  const PlaygroundTabScreen({super.key});

  @override
  State<PlaygroundTabScreen> createState() => _PlaygroundTabScreenState();
}

class _PlaygroundTabScreenState extends State<PlaygroundTabScreen> {
  String _selectedTemplate = 'Color';

  void _onTemplateChanged(String template) {
    setState(() {
      _selectedTemplate = template;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedTemplate == 'Color') {
      return ColorsPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Card') {
      return CardPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Button') {
      return ButtonPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Alert') {
      return AlertPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'TextField') {
      return TextFieldPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Typography') {
      return TypographyPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Shadows') {
      return ShadowsPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Icons') {
      return IconsPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Checkbox') {
      return CheckboxPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Switch') {
      return SwitchPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Slider') {
      return SliderPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Picker') {
      return PickerPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'SegmentedControl') {
      return SegmentedControlPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Skeleton') {
      return SkeletonPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Progress') {
      return ProgressPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Accordion') {
      return AccordionPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Timeline') {
      return TimelinePlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Tabs') {
      return TabsPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Label') {
      return LabelPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Dialog') {
      return DialogPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'BottomSheet') {
      return BottomSheetPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Snackbar') {
      return SnackbarPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Tooltip') {
      return TooltipPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'DropdownMenu') {
      return DropdownMenuPlayground(onTemplateChanged: _onTemplateChanged);
    }

    // Dynamic fallback widget for other modules/placeholder
    return Scaffold(
      backgroundColor: const Color(0xFF161616),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.code, color: Color(0xFFFF8C42), size: 48),
              const SizedBox(height: 12),
              Text(
                '$_selectedTemplate Playground',
                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'This component does not have an active playground module yet.',
                style: TextStyle(fontSize: 12, color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
