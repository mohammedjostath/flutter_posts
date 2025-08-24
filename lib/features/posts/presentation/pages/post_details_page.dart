import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import '../widgets/post_detail_page/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Body(post: post),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text("Post Detail"));
  }
}

class Body extends StatelessWidget {
  final Post post;

  const Body({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}
