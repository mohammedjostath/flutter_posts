import 'package:flutter_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddUpdateDeletePostBloc>(context).add(
              DeletePostEvent(id: postId),
            );
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
