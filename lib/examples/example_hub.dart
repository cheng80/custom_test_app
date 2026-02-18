import 'package:flutter/material.dart';
import '../custom/widgets.dart';
import '../theme/app_theme_colors.dart';

// UI Examples
import 'ui/text_field_example.dart';
import 'ui/list_view_example.dart';
import 'ui/dialog_example.dart';
import 'ui/bottom_sheet_example.dart';
import 'ui/navigation_widgets_example.dart';
import 'ui/layout_widgets_example.dart';
import 'ui/tab_bar_example.dart';
import 'ui/picker_grid_example.dart';
import 'ui/snackbar_action_sheet_example.dart';

// Util Examples
import 'util/storage_example.dart';
import 'util/collection_example.dart';
import 'util/timer_example.dart';
import 'util/json_util_example.dart';
import 'util/network_example.dart';
import 'util/address_example.dart';
import 'util/log_example.dart';
import 'util/json_api_example.dart';
import 'util/xml_api_example.dart';
import 'util/xml_util_example.dart';

class ExampleHub extends StatelessWidget {
  const ExampleHub({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: '커스텀 위젯 & 유틸 예제',
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: CustomColumn(
          spacing: 24,
          children: [
            _buildSection(
              context,
              title: 'UI Components',
              icon: Icons.widgets,
              color: Colors.blue,
              items: [
                _ExampleItem('TextField', const TextFieldExample()),
                _ExampleItem('ListView', const ListViewExample()),
                _ExampleItem('Dialog', const DialogExample()),
                _ExampleItem('BottomSheet', const BottomSheetExample()),
                _ExampleItem('Navigation', const NavigationWidgetsExample()),
                _ExampleItem('Layout', const LayoutWidgetsExample()),
                _ExampleItem('TabBar', const TabBarExample()),
                _ExampleItem('Pickers & Grid', const PickerGridExample()),
                _ExampleItem(
                  'SnackBar & ActionSheet',
                  const SnackBarActionSheetExample(),
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Utility Classes',
              icon: Icons.build,
              color: Colors.green,
              items: [
                _ExampleItem('Storage', const StorageExample()),
                _ExampleItem('Collection', const CollectionExample()),
                _ExampleItem('Timer', const TimerExample()),
                _ExampleItem('JSON Util', const JsonUtilExample()),
                _ExampleItem('XML Util', const XmlUtilExample()),
                _ExampleItem('Network', const NetworkExample()),
                _ExampleItem('Address', const AddressExample()),
                _ExampleItem('Logger', const LogExample()),
                _ExampleItem('JSON API Parsing', const JsonApiExample()),
                _ExampleItem('XML API Parsing', const XmlApiExample()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<_ExampleItem> items,
  }) {
    return CustomColumn(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 8),
            CustomText(title, fontSize: 20, fontWeight: FontWeight.bold),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CustomButton(
              btnText: item.title,
              backgroundColor: color.withOpacity(0.1),
              foregroundColor: color,
              onCallBack: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item.page),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _ExampleItem {
  final String title;
  final Widget page;
  _ExampleItem(this.title, this.page);
}
