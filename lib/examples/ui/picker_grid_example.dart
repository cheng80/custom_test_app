import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// Picker 및 Grid 위젯 사용 예제 페이지
class PickerGridExample extends StatefulWidget {
  const PickerGridExample({super.key});

  @override
  State<PickerGridExample> createState() => _PickerGridExampleState();
}

class _PickerGridExampleState extends State<PickerGridExample> {
  DateTime? _selectedDate;
  DateTime _cupertinoDate = DateTime.now();
  String? _selectedPickerItem;
  final List<String> _pickerItems = ['옵션 1', '옵션 2', '옵션 3', '옵션 4', '옵션 5'];

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: "Picker & Grid 예시",
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: CustomPadding.all(
          16.0,
          child: CustomColumn(
            spacing: 24,
            children: [
              CustomText(
                "Picker 및 Grid 종합 예시",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),

              // DatePicker 섹션
              CustomCard(
                padding: const EdgeInsets.all(20),
                child: CustomColumn(
                  spacing: 16,
                  children: [
                    CustomText(
                      "📅 DatePicker 예시",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomButton(
                      btnText: "날짜 선택",
                      minimumSize: const Size(double.infinity, 48),
                      onCallBack: () async {
                        final date = await CustomDatePicker.show(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                        );
                        if (date != null) setState(() => _selectedDate = date);
                      },
                    ),
                    if (_selectedDate != null)
                      CustomText(
                        "선택된 날짜: ${_selectedDate!.toString().split(' ')[0]}",
                        fontSize: 16,
                        color: p.primary,
                      ),
                  ],
                ),
              ),

              // CupertinoDatePicker 섹션
              CustomCard(
                padding: const EdgeInsets.all(20),
                child: CustomColumn(
                  spacing: 16,
                  children: [
                    CustomText(
                      "🍎 CupertinoDatePicker 예시",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomCupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: _cupertinoDate,
                      onDateTimeChanged: (dateTime) =>
                          setState(() => _cupertinoDate = dateTime),
                    ),
                    CustomText(
                      "선택된 날짜/시간: ${_cupertinoDate.toString().split('.')[0]}",
                      fontSize: 16,
                      color: p.primary,
                    ),
                  ],
                ),
              ),

              // PickerView 섹션
              CustomCard(
                padding: const EdgeInsets.all(20),
                child: CustomColumn(
                  spacing: 16,
                  children: [
                    CustomText(
                      "📋 PickerView 예시",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomPickerView<String>(
                        items: _pickerItems,
                        selectedItem: _selectedPickerItem,
                        onItemSelected: (item) =>
                            setState(() => _selectedPickerItem = item),
                      ),
                    ),
                  ],
                ),
              ),

              // GridView 섹션
              CustomCard(
                padding: const EdgeInsets.all(20),
                child: CustomColumn(
                  spacing: 16,
                  children: [
                    CustomText(
                      "📊 GridView 예시",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 300,
                      child: CustomGridView(
                        itemCount: 10,
                        crossAxisCount: 2,
                        spacing: 12,
                        itemBuilder: (context, index) {
                          return CustomCard(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: CustomText(
                                "항목 ${index + 1}",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
