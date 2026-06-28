import 'package:go_router/go_router.dart';
import 'package:machamp/core/extensions/string_extensions.dart';
import 'package:machamp/presentation/activity_log/activity_log_screen.dart';
import 'package:machamp/presentation/home/home_screen.dart';
import 'package:machamp/presentation/menu/menu_screen.dart';
import 'package:machamp/presentation/menu_create/menu_create_screen.dart';
import 'package:machamp/presentation/menu_detail/menu_detail_screen.dart';
import 'package:machamp/presentation/profile/profile_screen.dart';
import 'package:machamp/router/app_navigation_bar.dart';

enum AppRoutes {
  home,
  menu,
  activityLog,
  profile;

  String get path => switch (this) {
    AppRoutes.activityLog => '/activity_log',
    _ => '/$pathName',
  };

  String get pathName => name.toSnakeCase();
}

final router = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppNavigationBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.menu.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const MenuScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.activityLog.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ActivityLogScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/menu/create',
      builder: (context, state) => const MenuCreateScreen(),
    ),
    GoRoute(
      path: '/menu/:id',
      builder: (context, state) =>
          MenuDetailScreen(menuId: state.pathParameters['id']!),
      routes: [
        GoRoute(
          path: 'edit',
          builder: (context, state) =>
              MenuCreateScreen(menuId: state.pathParameters['id']),
        ),
      ],
    ),
  ],
);
