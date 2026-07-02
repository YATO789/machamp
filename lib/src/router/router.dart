import 'package:go_router/go_router.dart';
import 'package:machamp/src/core/extensions/string_extensions.dart';
import 'package:machamp/src/infrastructures/repository/auth_repository.dart';
import 'package:machamp/src/presentation/activity_log/activity_log_screen.dart';
import 'package:machamp/src/presentation/home/home_screen.dart';
import 'package:machamp/src/presentation/login/login_screen.dart';
import 'package:machamp/src/presentation/menu/menu_screen.dart';
import 'package:machamp/src/presentation/menu_editor/menu_editor_screen.dart';
import 'package:machamp/src/presentation/profile/profile_screen.dart';
import 'package:machamp/src/presentation/workout/workout_screen.dart';
import 'package:machamp/src/presentation/workout/workout_view_model.dart';
import 'package:machamp/src/presentation/workout_summary/workout_summary_screen.dart';
import 'package:machamp/src/router/app_navigation_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

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

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final goRouter = GoRouter(
    initialLocation: AppRoutes.home.path,
    redirect: (context, state) {
      final authState = ref.read(authStateChangesProvider);
      if (authState.isLoading) return null;

      final user = authState.asData?.value;
      final isOnLoginPage = state.matchedLocation == '/login';

      if (user == null && !isOnLoginPage) return '/login';
      if (user != null && isOnLoginPage) return AppRoutes.home.path;
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
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
        builder: (context, state) => const MenuEditorScreen(),
      ),
      GoRoute(
        path: '/menu/:id',
        builder: (context, state) =>
            MenuEditorScreen(menuId: state.pathParameters['id']!),
        routes: [
          GoRoute(
            path: 'workout',
            builder: (context, state) =>
                WorkoutScreen(menuId: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: 'summary',
                builder: (context, state) => WorkoutSummaryScreen(
                  workoutState: state.extra! as WorkoutState,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.listen(authStateChangesProvider, (_, __) {
    goRouter.refresh();
  });

  return goRouter;
}
