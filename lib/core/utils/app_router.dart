import 'package:go_router/go_router.dart';

import '../../features/login/presentation/views/login_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginView(),
      ),
    ],
  );
}
