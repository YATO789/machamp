import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/share_preview/share_preview_args.dart';
import 'package:machamp/src/presentation/share_preview/share_preview_view_model.dart';
import 'package:machamp/src/presentation/share_preview/widgets/workout_summary_share_card.dart';

class SharePreviewScreen extends HookConsumerWidget {
  const SharePreviewScreen({super.key, required this.args});

  final SharePreviewArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSharing = ref.watch(
      sharePreviewViewModelProvider.select((s) => s.isSharing),
    );
    final notifier = ref.read(sharePreviewViewModelProvider.notifier);

    final repaintKey = useMemoized(GlobalKey.new);
    final shareButtonKey = useMemoized(GlobalKey.new);

    Future<void> onShare() async {
      final box =
          shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
      final screenSize = MediaQuery.of(context).size;
      final origin = box != null
          ? box.localToGlobal(Offset.zero) & box.size
          : Rect.fromCenter(
              center: screenSize.center(Offset.zero),
              width: 1,
              height: 1,
            );

      final boundary =
          repaintKey.currentContext!.findRenderObject()!
              as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      await notifier.share(byteData.buffer.asUint8List(), origin);
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RepaintBoundary(
                key: repaintKey,
                child: WorkoutSummaryShareCard(
                  backgroundImage: args.backgroundImage,
                  workoutName: args.workoutName,
                  totalVolume: args.totalVolume,
                  totalSets: args.totalSets,
                  date: args.date,
                  durationMinutes: args.durationMinutes,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 52,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: isSharing ? null : context.pop,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        side: const BorderSide(color: AppColors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.monoWhite,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      key: shareButtonKey,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isSharing ? null : onShare,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: isSharing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.monoWhite,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                AppAssets.of(context)!.share,
                                style: const TextStyle(
                                  color: AppColors.monoWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
