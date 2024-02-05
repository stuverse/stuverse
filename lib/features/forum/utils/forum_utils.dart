import 'dart:developer';

import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:stuverse/features/forum/forum.dart';

class ForumUtils {
  // A recursive function to convert a ThreadComment object to a TreeNode<ThreadComment> object
// with a maximum recursion depth of 3
  // static TreeNode<ThreadComment> threadCommentToTreeNode(ThreadComment comment,
  //     [int level = 0]) {
  //   // create a new tree node with the comment data
  //   var node = TreeNode<ThreadComment>(
  //     key: comment.id
  //         .toString(), // using the toString() method of the int object
  //     data: comment, // using the comment object itself as the data
  //   );
  //   // if the level is less than 3, add the children nodes as descendants
  //   if (level < 2) {
  //     node.addAll(
  //         comment.children!.map((c) => threadCommentToTreeNode(c, level + 1)));
  //   }
  //   // otherwise, flatten the children nodes and add them as siblings
  //   else {
  //     List<ThreadComment> children = [];
  //     void flattenChildren(ThreadComment comment) {
  //       log('Flattening children of ${comment.content}');
  //       if (comment.children != null) {
  //         comment.children!.forEach((c) {
  //           children.add(c);
  //           flattenChildren(c);
  //         });
  //       }
  //     }

  //     flattenChildren(comment);
  //     log('Flattened children: $children');
  //     node.addAll(children.map((c) => threadCommentToTreeNode(c, level)));
  //   }
  //   // return the node
  //   return node;
  // }

  // A recursive function to convert a ThreadComment object to a TreeNode<ThreadComment> object
  static TreeNode<ThreadComment> threadCommentToTreeNode(
      ThreadComment comment) {
    return TreeNode<ThreadComment>(
      key: comment.id
          .toString(), // using the toString() method of the int object
      data: comment, // using the comment object itself as the data
    )..addAll(comment.children!
        .map(threadCommentToTreeNode)); // using the addAll() and map() methods
  }
}
