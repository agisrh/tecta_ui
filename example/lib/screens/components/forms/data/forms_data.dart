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
        description:
            'Interactive trigger elements used to perform actions, submit forms, or initiate key user flows.',
        icon: Icons.smart_button_outlined,
        iconColor: TectaColors.successMain,
        builder: (context) => const ButtonShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Checkbox',
        description:
            'Selection controls allowing users to select one or multiple independent options from a list.',
        icon: Icons.check_box_outlined,
        iconColor: TectaColors.warningMain,
        builder: (context) => const CheckboxShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Radio Button',
        description:
            'Single-select controls used when users must choose exactly one option from a mutually exclusive set.',
        icon: Icons.radio_button_checked,
        iconColor: TectaColors.infoMain,
        builder: (context) => const RadioShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Switch',
        description:
            'Binary toggle controls designed to instantly activate or deactivate settings and preferences.',
        icon: Icons.toggle_on_outlined,
        iconColor: TectaColors.successMain,
        builder: (context) => const SwitchShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Text Field',
        description:
            'Input controls enabling users to type, edit, and validate textual data with custom helper and error states.',
        icon: Icons.edit_note_rounded,
        iconColor: TectaColors.warningMain,
        builder: (context) => const TextFieldShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Upload',
        description:
            'File selection and dropzone components supporting file pickers, attachment previews, and upload states.',
        icon: Icons.upload_file_outlined,
        iconColor: TectaColors.infoMain,
        builder: (context) => const UploadShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Segmented Control',
        description:
            'Linear set of connected buttons used to toggle between closely related options or filter view modes.',
        icon: Icons.splitscreen_outlined,
        iconColor: TectaColors.primaryMain,
        builder: (context) => const SegmentedControlShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Rating',
        description:
            'Star-based evaluation controls allowing users to provide or view qualitative numeric reviews.',
        icon: Icons.star_rate_rounded,
        iconColor: TectaColors.warningMain,
        builder: (context) => const RatingShowcasePage(),
      ),
      ShowcaseItem(
        title: 'Slider',
        description:
            'Interactive track controls that enable smooth or stepped selection across a continuous range of values.',
        icon: Icons.linear_scale_rounded,
        iconColor: TectaColors.successMain,
        builder: (context) => const SliderShowcasePage(),
      ),
      ShowcaseItem(
        title: 'DatePicker & TimePicker',
        description:
            'Modal and inline pickers designed for intuitive date, range, and time selection across workflows.',
        icon: Icons.calendar_month_outlined,
        iconColor: TectaColors.infoMain,
        builder: (context) => const PickerShowcasePage(),
      ),
    ],
  );
}
