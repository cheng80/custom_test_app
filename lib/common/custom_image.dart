import 'package:flutter/material.dart';

/// 커스텀 Image.asset 위젯 클래스
/// Image.asset의 자주 사용하는 속성들을 기본값으로 설정하여 간편하게 사용할 수 있습니다.
///
/// 사용 예시:
/// - 기본 사용: CustomImage("assets/images/logo.png")
/// - 크기 지정: CustomImage("assets/images/logo.png", width: 100, height: 100)
/// - fit 지정: CustomImage("assets/images/logo.png", fit: BoxFit.cover)
class CustomImage extends StatelessWidget {
  /// 이미지 경로 (필수)
  final String path;

  /// 이미지 너비
  final double? width;

  /// 이미지 높이
  final double? height;

  /// 이미지 크기 조정 방식 (기본값: BoxFit.contain)
  final BoxFit? fit;

  /// 이미지가 로드되지 않을 때 표시할 위젯
  final Widget? errorWidget;

  /// 이미지가 로드 중일 때 표시할 위젯
  final Widget? loadingWidget;

  /// 이미지 색상 필터
  final Color? color;

  /// 이미지 색상 블렌드 모드
  final BlendMode? colorBlendMode;

  /// 이미지 반복 방식
  final ImageRepeat? repeat;

  /// 이미지 정렬 방식
  final AlignmentGeometry? alignment;

  const CustomImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.loadingWidget,
    this.color,
    this.colorBlendMode,
    this.repeat,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      path,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      color: color,
      colorBlendMode: colorBlendMode,
      repeat: repeat ?? ImageRepeat.noRepeat,
      alignment: alignment ?? Alignment.center,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey[300],
              child: Icon(
                Icons.broken_image,
                color: Colors.grey[600],
                size: (width != null && height != null)
                    ? (width! < height! ? width! * 0.5 : height! * 0.5)
                    : 48,
              ),
            );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        if (frame == null && loadingWidget != null) {
          return loadingWidget!;
        }
        return child;
      },
    );

    // width나 height가 지정된 경우 SizedBox로 감싸기
    if (width != null || height != null) {
      image = SizedBox(width: width, height: height, child: image);
    }

    return image;
  }
}
