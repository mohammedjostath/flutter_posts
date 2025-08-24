import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts/core/widgets/loading_widget.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter_posts/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:flutter_posts/features/posts/presentation/widgets/posts_page/post_list_widget.dart';
import '../widgets/posts_page/message_display_widget.dart';
import 'package:flutter_posts/injection_container.dart' as di;


class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
      child: const PostsView(),
    );
  }
}


class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      floatingActionButton: PostsFloatingActionButton(),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return LoadingWidget();
          } else if (state is PostsLoadedState) {
            return PostListWidget(posts: state.posts);
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }
}

class PostsFloatingActionButton extends StatelessWidget {
  const PostsFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostAddUpdatePage(isUpdatePost: false),
          ),
        );
      },
      shape: CircleBorder(),
      child: Icon(Icons.add),
    );
  }
}
