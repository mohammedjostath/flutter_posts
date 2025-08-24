import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';

import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../pages/posts_page.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: Icon(Icons.delete_outline),
      label: Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddUpdateDeletePostBloc,
              AddUpdateDeletePostState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => PostsPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }
}
