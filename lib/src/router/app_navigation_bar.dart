import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:machamp/src/core/constants/app_color.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: _FloatingNavBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

class _FloatingNavBar extends StatefulWidget {
  const _FloatingNavBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const _items = [
    (icon: Icons.home, activeIcon: Icons.home, label: 'Home'),
    (icon: Icons.list_outlined, activeIcon: Icons.list, label: 'Menu'),
    (icon: Icons.history_outlined, activeIcon: Icons.history, label: 'Log'),
    (icon: Icons.person, activeIcon: Icons.person, label: 'Profile'),
  ];

  @override
  State<_FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<_FloatingNavBar> {
  double? _dragLeft;

  void _onDragEnd(double itemWidth) {
    final index = (_dragLeft! / itemWidth).round().clamp(
      0,
      _FloatingNavBar._items.length - 1,
    );
    setState(() => _dragLeft = null);
    widget.onDestinationSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: (bottomPadding - 8).clamp(0.0, double.infinity),
      ),
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth =
                constraints.maxWidth / _FloatingNavBar._items.length;
            final maxLeft = constraints.maxWidth - itemWidth;
            final pillLeft = _dragLeft ?? itemWidth * widget.selectedIndex;
            final isDragging = _dragLeft != null;

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragStart: (_) {
                setState(() => _dragLeft = itemWidth * widget.selectedIndex);
              },
              onHorizontalDragUpdate: (details) {
                setState(
                  () => _dragLeft = (_dragLeft! + details.delta.dx).clamp(
                    0.0,
                    maxLeft,
                  ),
                );
              },
              onHorizontalDragEnd: (_) => _onDragEnd(itemWidth),
              onHorizontalDragCancel: () => setState(() => _dragLeft = null),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: isDragging
                        ? Duration.zero
                        : const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    left: pillLeft,
                    top: 4,
                    bottom: 4,
                    width: itemWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.white10,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(_FloatingNavBar._items.length, (
                      index,
                    ) {
                      final item = _FloatingNavBar._items[index];
                      final isSelected = index == widget.selectedIndex;
                      return Expanded(
                        child: _NavItem(
                          icon: item.icon,
                          activeIcon: item.activeIcon,
                          label: item.label,
                          isSelected: isSelected,
                          onTap: () => widget.onDestinationSelected(index),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const color = AppColors.monoWhite;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isSelected ? activeIcon : icon, color: color, size: 26),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
