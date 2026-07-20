import 'package:flutter/material.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/localization/app_assets.dart';

/// Overlays [child] with a bar pinned to the keyboard's top edge, holding
/// a "done" button that dismisses focus.
///
/// The ancestor [Scaffold] must set `resizeToAvoidBottomInset: false` so
/// `viewInsets.bottom` reflects the raw keyboard height rather than space
/// already consumed by a resized layout.
class KeyboardDoneBar extends StatelessWidget {
  const KeyboardDoneBar({super.key, required this.child});

  final Widget child;

  static const double _barHeight = 44;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0;

    return Stack(
      children: [
        child,
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomInset,
          height: _barHeight,
          child: IgnorePointer(
            ignoring: !isKeyboardVisible,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: isKeyboardVisible ? 1 : 0,
              child: ColoredBox(
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextButton(
                      onPressed: () => FocusScope.of(context).unfocus(),
                      child: Text(
                        AppAssets.of(context)!.done,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
