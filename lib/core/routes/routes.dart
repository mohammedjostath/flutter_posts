import 'package:flutter_posts/features/posts/presentation/pages/post_details_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_posts/features/posts/presentation/pages/posts_page.dart';

import '../../features/posts/domain/entities/post.dart';

class Routes {
  const Routes._();

  static const String homePage = '/home_page';
  static const String postDetailsPage = '/post_details_page';
  static const String addUpdatePostPAge = '/add_update_post_page';
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.homePage,
    routes: [
      GoRoute(
        path: Routes.homePage,
        builder: (context, state) => const PostsPage(),
      ),
      GoRoute(
        path: Routes.postDetailsPage,
        builder: (context, state) {
          final post = state.extra as Post;
          return PostDetailPage(post: post);
        },
      ),
    ],
  );
}
