import 'package:flutter/material.dart';
import 'package:machamp/src/core/constants/app_color.dart';

enum PrimaryButtonVariant { filled, ghost }

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PrimaryButtonVariant.filled,
    this.icon,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final PrimaryButtonVariant variant;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      PrimaryButtonVariant.filled => _FilledButton(
        label: label,
        onPressed: onPressed,
        icon: icon,
        color: color ?? AppColors.purple,
      ),
      PrimaryButtonVariant.ghost => _GhostButton(
        label: label,
        onPressed: onPressed,
        icon: icon,
      ),
    };
  }
}

class _FilledButton extends StatelessWidget {
  const _FilledButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.color = AppColors.purple,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;
    final gradientColors = isDisabled
        ? [color.withValues(alpha: 0.3), color.withValues(alpha: 0.15)]
        : [
            Color.lerp(Colors.white, color, 0.35)!,
            color,
            Color.lerp(Colors.black, color, 0.65)!,
          ];

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(26),
            boxShadow: isDisabled
                ? null
                : [
                    BoxShadow(
                      color: color.withValues(alpha: 0.45),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(26),
            splashColor: Colors.white.withValues(alpha: 0.2),
            highlightColor: Colors.white.withValues(alpha: 0.1),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: AppColors.white),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkSurface,
          disabledBackgroundColor: AppColors.darkSurface.withValues(alpha: 0.5),
          foregroundColor: AppColors.monoWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
