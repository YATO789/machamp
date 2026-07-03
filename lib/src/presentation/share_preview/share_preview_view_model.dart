import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' show Rect;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'share_preview_view_model.freezed.dart';
part 'share_preview_view_model.g.dart';

@freezed
abstract class SharePreviewState with _$SharePreviewState {
  const factory SharePreviewState({
    @Default(false) bool isSharing,
  }) = _SharePreviewState;
}

@riverpod
class SharePreviewViewModel extends _$SharePreviewViewModel {
  @override
  SharePreviewState build() => const SharePreviewState();

  Future<void> share(Uint8List imageBytes, Rect origin) async {
    state = state.copyWith(isSharing: true);
    try {
      final tempFile = File(
        '${Directory.systemTemp.path}/workout_share_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await tempFile.writeAsBytes(imageBytes);

      await Share.shareXFiles(
        [XFile(tempFile.path)],
        sharePositionOrigin: origin,
      );
    } finally {
      state = state.copyWith(isSharing: false);
    }
  }
}
