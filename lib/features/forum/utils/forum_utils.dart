import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:stuverse/features/forum/forum.dart';

class ForumUtils {
  static // Define a function that takes a list of threads, a parent id, and a new thread as parameters
      void getNewCommentsState(List<ThreadComment> comments, int? parentId,
          ThreadComment newComment) {
    if (parentId == null || comments.isEmpty) {
      return;
    }
    // Loop through the threads
    for (var comment in comments) {
      // If the thread id matches the parent id
      if (comment.id == parentId) {
        // Append the new thread to the children of the thread
        comment.children!.add(newComment);
        // Return the updated threads
      }
      // Otherwise, recursively call the function on the children of the thread
      else {
        getNewCommentsState(comment.children!, parentId, newComment);
      }
    }
  }

  // A recursive function to convert a ThreadComment object to a TreeNode<ThreadComment> object
  static TreeNode<ThreadComment> threadCommentToTreeNode(
      ThreadComment comment) {
    if (comment.children == null) {
      return TreeNode<ThreadComment>(
        key: comment.id
            .toString(), // using the toString() method of the int object
        data: comment, // using the comment object itself as the data
      );
    }
    return TreeNode<ThreadComment>(
      key: comment.id
          .toString(), // using the toString() method of the int object
      data: comment, // using the comment object itself as the data
    )..addAll(comment.children!
        .map(threadCommentToTreeNode)); // using the addAll() and map() methods
  }
}
