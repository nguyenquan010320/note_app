import 'package:go_router/go_router.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/screens/post_page.dart';
import 'package:note_app/services/auth_service.dart';

final authService = AuthService();

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final isLoggedIn = await authService.isLoggedIn();

    if (!isLoggedIn && state.uri.toString() == '/home') {
      return '/login';
    }

    if (isLoggedIn && state.uri.toString() == '/login') {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/add', builder: (context, state) => AddNoteScreen()),
    GoRoute(path: '/posts', builder: (context, state) => PostPage()),
  ],
);
