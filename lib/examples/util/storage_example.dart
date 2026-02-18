import 'package:flutter/material.dart';

import '../../custom/external_util/storage/custom_storage_util.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// StorageUtil 사용 예제 페이지
class StorageExample extends StatefulWidget {
  const StorageExample({super.key});

  @override
  State<StorageExample> createState() => _StorageExampleState();
}

class _StorageExampleState extends State<StorageExample> {
  String? _username;
  int? _age;
  bool? _isDarkMode;
  List<String>? _tags;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final username = await CustomStorageUtil.getString('username');
    final age = await CustomStorageUtil.getInt('age');
    final isDarkMode = await CustomStorageUtil.getBool('isDarkMode');
    final tags = await CustomStorageUtil.getStringList('tags');

    setState(() {
      _username = username;
      _age = age;
      _isDarkMode = isDarkMode;
      _tags = tags;
    });
  }

  Future<void> _saveBasicTypes() async {
    await CustomStorageUtil.setString('username', '홍길동');
    await CustomStorageUtil.setInt('age', 25);
    await CustomStorageUtil.setBool('isDarkMode', true);
    await CustomStorageUtil.setStringList('tags', ['flutter', 'dart']);
    await _loadData();
    if (mounted) CustomSnackBar.showSuccess(context, message: '데이터가 저장되었습니다.');
  }

  Future<void> _clearAll() async {
    await CustomStorageUtil.clear();
    await _loadData();
    if (mounted) CustomSnackBar.showInfo(context, message: '모든 데이터가 삭제되었습니다.');
  }

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: 'StorageUtil 예제',
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: CustomPadding.all(
          16.0,
          child: CustomColumn(
            spacing: 24,
            children: [
              CustomCard(
                padding: const EdgeInsets.all(16),
                child: CustomColumn(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      '저장된 데이터',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const Divider(),
                    _buildItemRow('이름', _username ?? '없음'),
                    _buildItemRow('나이', _age?.toString() ?? '없음'),
                    _buildItemRow('다크모드', _isDarkMode?.toString() ?? '없음'),
                    _buildItemRow('태그', _tags?.join(', ') ?? '없음'),
                  ],
                ),
              ),
              CustomButton(
                btnText: '기본 데이터 저장',
                minimumSize: const Size(double.infinity, 50),
                onCallBack: _saveBasicTypes,
              ),
              CustomButton(
                btnText: '모든 데이터 삭제',
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
                onCallBack: _clearAll,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(label, fontWeight: FontWeight.bold),
          CustomText(value),
        ],
      ),
    );
  }
}
