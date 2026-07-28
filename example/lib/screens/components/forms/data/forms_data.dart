import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../home_screen.dart';
import '../showcase/button_showcase_screen.dart';
import '../showcase/checkbox_showcase_screen.dart';
import '../showcase/radio_showcase_screen.dart';
import '../showcase/switch_showcase_screen.dart';
import '../showcase/text_field_showcase_screen.dart';
import '../showcase/upload_showcase_screen.dart';
import '../showcase/segmented_control_showcase_screen.dart';
import '../showcase/rating_showcase_screen.dart';
import '../showcase/slider_showcase_screen.dart';
import '../showcase/picker_showcase_screen.dart';

ShowcaseCategory buildFormsCategory() {
  return ShowcaseCategory(
    title: 'FORMS',
    items: [
      ShowcaseItem(
        title: 'Buttons',
        description: 'Interactive actions',
        icon: Icons.smart_button_outlined,
        iconColor: TectaColors.successMain,
        builder: (context) => const ButtonShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Checkbox',
        description: 'Selection controls',
        icon: Icons.check_box_outlined,
        iconColor: TectaColors.warningMain,
        builder: (context) => const CheckboxShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Radio Button',
        description: 'Single selection controls',
        icon: Icons.radio_button_checked,
        iconColor: TectaColors.infoMain,
        builder: (context) => const RadioShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Switch',
        description: 'Toggle selections',
        icon: Icons.toggle_on_outlined,
        iconColor: TectaColors.successMain,
        builder: (context) => const SwitchShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Text Field',
        description: 'Text and select inputs',
        icon: Icons.edit_note_rounded,
        iconColor: TectaColors.warningMain,
        builder: (context) => const TextFieldShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Upload',
        description: 'File upload fields',
        icon: Icons.upload_file_outlined,
        iconColor: TectaColors.infoMain,
        builder: (context) => const UploadShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Segmented Control',
        description: 'Custom switch tabs',
        icon: Icons.splitscreen_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const SegmentedControlShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Rating',
        description: 'Premium feedback stars',
        icon: Icons.star_rate_rounded,
        iconColor: TectaColors.warningMain,
        builder: (context) => const RatingShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Slider',
        description: 'Custom slider values',
        icon: Icons.linear_scale_rounded,
        iconColor: TectaColors.successMain,
        builder: (context) => const SliderShowcasePage(),
      ),
      ShowcaseItem(
        title: 'DatePicker & TimePicker',
        description: 'Premium calendar dialogs',
        icon: Icons.calendar_month_outlined,
        iconColor: TectaColors.infoMain,
        builder: (context) => const PickerShowcasePage(),
      ),
    ],
  );
}
