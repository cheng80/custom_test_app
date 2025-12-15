import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom/util/json/custom_json_util.dart';
import '../custom/widgets.dart';
import '../theme/app_colors.dart';

/// 게임 데이터 JSON API 파싱 예제 페이지
class JsonApiExamplePage extends StatefulWidget {
  const JsonApiExamplePage({super.key});

  @override
  State<JsonApiExamplePage> createState() => _JsonApiExamplePageState();
}

class _JsonApiExamplePageState extends State<JsonApiExamplePage> {
  String _result = '';
  bool _isLoading = false;
  Map<String, dynamic>? _parsedData;
  final TextEditingController _searchController = TextEditingController();
  List<MapEntry<String, dynamic>> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: 'JSON API 파싱 예제',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: CustomPadding.all(
          16.0,
          child: CustomColumn(
            spacing: 16,
            children: [
              // 제목 섹션
              CustomColumn(
                spacing: 8,
                children: [
                  CustomText(
                    '게임 데이터 JSON API',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: p.textPrimary,
                  ),
                  CustomText(
                    'JSON API를 파싱하여 Map으로 변환하고 순환 출력하는 예제',
                    fontSize: 14,
                    color: p.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // API 정보 카드
              CustomCard(
                padding: const EdgeInsets.all(16),
                child: CustomColumn(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      '📡 API 정보',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      'URL: https://node.cheng80.synology.me/gamedata?folder=SQ1/68-4&gamename=story_quiz_68-4',
                      fontSize: 12,
                      color: p.textSecondary,
                    ),
                    CustomText(
                      '형식: JSON',
                      fontSize: 12,
                      color: p.textSecondary,
                    ),
                  ],
                ),
              ),

              // 버튼
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  btnText: _isLoading ? '로딩 중...' : 'API 데이터 가져오기',
                  backgroundColor: Colors.blue,
                  onCallBack: _isLoading
                      ? () {}
                      : () {
                          _fetchAndParseJson();
                        },
                ),
              ),

              // 결과 표시
              if (_result.isNotEmpty)
                CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: CustomColumn(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        '📊 파싱 결과',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SelectableText(
                          _result,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // 키 검색 섹션
              if (_parsedData != null)
                CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: CustomColumn(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        '🔍 키 검색',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomRow(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _searchController,
                              hintText: '검색할 키 입력 (예: name, type, src)',
                              onSubmitted: (value) {
                                _searchKey(value);
                              },
                            ),
                          ),
                          CustomButton(
                            btnText: '검색',
                            backgroundColor: Colors.blue,
                            minimumSize: const Size(80, 48),
                            onCallBack: () {
                              _searchKey(_searchController.text);
                            },
                          ),
                        ],
                      ),
                      if (_searchResults.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        CustomText(
                          '검색 결과: ${_searchResults.length}개',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          constraints: const BoxConstraints(maxHeight: 300),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final entry = _searchResults[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomColumn(
                                  spacing: 4,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      '키: ${entry.key}',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    ),
                                    CustomText(
                                      '값: ${_formatValue(entry.value)}',
                                      fontSize: 12,
                                      color: Colors.blue.shade800,
                                    ),
                                    const Divider(height: 8),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ] else if (_searchController.text.isNotEmpty &&
                          _parsedData != null) ...[
                        const SizedBox(height: 8),
                        CustomText(
                          '검색 결과가 없습니다.',
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ],
                  ),
                ),

              // Map 데이터 상세 표시
              if (_parsedData != null)
                CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: CustomColumn(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        '🗺️ Map 데이터 구조',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      _buildMapWidget(_parsedData!),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// JSON API를 가져와서 파싱하는 함수
  Future<void> _fetchAndParseJson() async {
    setState(() {
      _isLoading = true;
      _result = '요청 중...\n';
      _parsedData = null;
      _searchResults = [];
    });

    try {
      // API 요청
      final url = Uri.parse(
        'https://node.cheng80.synology.me/gamedata?folder=SQ1/68-4&gamename=story_quiz_68-4',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // UTF-8로 명시적으로 디코딩
        String jsonString;
        try {
          jsonString = utf8.decode(response.bodyBytes);
        } catch (e) {
          jsonString = response.body;
        }

        setState(() {
          _result = '═══════════════════════════════════════\n';
          _result += '✅ API 응답 성공\n';
          _result += '═══════════════════════════════════════\n\n';
          _result += '📊 상태 코드: ${response.statusCode}\n';
          _result += '📏 응답 길이: ${jsonString.length} bytes\n';
          _result += '📋 Content-Type: ${response.headers['content-type'] ?? 'N/A'}\n\n';

          // JSON 검증
          if (CustomJsonUtil.isValid(jsonString)) {
            _result += '✅ 유효한 JSON입니다\n\n';

            // JSON을 Map으로 변환
            final map = CustomJsonUtil.decode(jsonString);
            if (map is Map<String, dynamic>) {
              _parsedData = map;
              _result += '✅ Map 변환 성공!\n\n';
              _result += '【Map 구조】\n';
              _result += '─────────────────────────────────────\n';
              _result += CustomJsonUtil.formatMap(map);
              _result += '\n\n【순환 출력】\n';
              _result += '─────────────────────────────────────\n';
              _result += _iterateMap(map);
            } else if (map is List) {
              _parsedData = {'data': map};
              _result += '✅ List 변환 성공! (Map으로 래핑)\n\n';
              _result += '📊 리스트 항목 수: ${map.length}개\n';
            } else {
              _result += '❌ Map 또는 List로 변환할 수 없습니다\n';
              _result += '타입: ${map.runtimeType}\n';
            }
          } else {
            _result += '❌ 유효하지 않은 JSON입니다\n';
            _result += '원본 JSON (처음 500자):\n';
            _result += jsonString.length > 500
                ? '${jsonString.substring(0, 500)}...'
                : jsonString;
          }
        });
      } else {
        // 에러 응답도 UTF-8로 디코딩
        String errorBody;
        try {
          errorBody = utf8.decode(response.bodyBytes);
        } catch (e) {
          errorBody = response.body;
        }

        setState(() {
          _result = '❌ API 요청 실패\n';
          _result += '상태 코드: ${response.statusCode}\n';
          _result += '응답: $errorBody';
        });
      }
    } catch (e) {
      setState(() {
        _result = '❌ 에러 발생\n';
        _result += '에러 메시지: $e\n';
        _result += '\n인터넷 연결을 확인해주세요.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Map을 순환하며 출력
  String _iterateMap(Map<String, dynamic> map) {
    final buffer = StringBuffer();
    int itemCount = 0;

    void iterate(dynamic data, String prefix) {
      if (data is Map<String, dynamic>) {
        for (final entry in data.entries) {
          final key = entry.key;
          final value = entry.value;

          // resources 배열 처리
          if (key == 'resources' && value is List) {
            buffer.writeln('\n--- 리소스 목록 (${value.length}개) ---\n');
            for (int i = 0; i < value.length; i++) {
              itemCount++;
              final item = value[i];
              if (item is Map<String, dynamic>) {
                buffer.writeln('[$itemCount] 리소스:');
                _printMapItem(item, buffer, prefix: '  ');
                buffer.writeln('');
              }
            }
          } else if (value is Map<String, dynamic>) {
            buffer.writeln('$prefix$key:');
            iterate(value, '$prefix  ');
          } else if (value is List) {
            buffer.writeln('$prefix$key: [리스트 ${value.length}개]');
            for (int i = 0; i < value.length; i++) {
              iterate(value[i], '$prefix  [$i] ');
            }
          } else {
            buffer.writeln('$prefix$key: $value');
          }
        }
      } else if (data is List) {
        for (int i = 0; i < data.length; i++) {
          iterate(data[i], '$prefix[$i] ');
        }
      }
    }

    iterate(map, '');
    if (itemCount > 0) {
      buffer.writeln('\n총 $itemCount개의 리소스를 찾았습니다.');
    }
    return buffer.toString();
  }

  /// Map 항목을 출력하는 헬퍼 함수
  void _printMapItem(Map<String, dynamic> item, StringBuffer buffer,
      {String prefix = ''}) {
    for (final entry in item.entries) {
      final key = entry.key;
      final value = entry.value;
      buffer.writeln('$prefix$key: $value');
    }
  }

  /// 키 검색 함수
  void _searchKey(String searchKey) {
    if (searchKey.trim().isEmpty || _parsedData == null) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final results = CustomJsonUtil.searchKeys(_parsedData!, searchKey);
    
    setState(() {
      _searchResults = results;
    });
  }

  /// 값을 포맷팅하는 헬퍼 함수
  String _formatValue(dynamic value) {
    if (value == null) {
      return 'null';
    } else if (value is Map) {
      return '{Map with ${value.length} keys}';
    } else if (value is List) {
      return '[List with ${value.length} items]';
    } else {
      return value.toString();
    }
  }

  /// Map 위젯을 재귀적으로 생성
  Widget _buildMapWidget(Map<String, dynamic> map) {
    return CustomColumn(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: map.entries.map((entry) {
        final key = entry.key;
        final value = entry.value;

        if (value is Map<String, dynamic>) {
          return ExpansionTile(
            title: CustomText(
              key,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: _buildMapWidget(value),
              ),
            ],
          );
        } else if (value is List) {
          return ExpansionTile(
            title: CustomText(
              '$key (${value.length}개)',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            children: value.asMap().entries.map((listEntry) {
              final index = listEntry.key;
              final item = listEntry.value;
              if (item is Map<String, dynamic>) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: ExpansionTile(
                    title: CustomText(
                      '[$index] 항목',
                      fontSize: 12,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: _buildMapWidget(item),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: CustomText(
                    '[$index]: $item',
                    fontSize: 12,
                  ),
                );
              }
            }).toList(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: CustomRow(
              spacing: 8,
              children: [
                CustomText(
                  '$key:',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                Expanded(
                  child: CustomText(
                    value.toString(),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }
      }).toList(),
    );
  }
}

