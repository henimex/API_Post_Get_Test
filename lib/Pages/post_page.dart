import 'package:base_api_prj/Services/comment_service.dart';
import 'package:flutter/material.dart';

import '../Entities/Comment.dart';

class PostDataPage extends StatefulWidget {
  const PostDataPage({super.key});

  @override
  State<PostDataPage> createState() => _PostDataPageState();
}

class _PostDataPageState extends State<PostDataPage> {

  //There should be something like DirectiveForms, LF Better solution. Separate controllers don't fit best practices !!!
  TextEditingController postIdController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  CommentService commentService = CommentService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: Text("Post Id")),
                Expanded(child: TextField(controller: postIdController)),
              ],
            ),
            Row(
              children: [
                const Expanded(child: Text("Id")),
                Expanded(child: TextField(controller: idController)),
              ],
            ),
            Row(children: [
              const Expanded(child: Text("Name")),
              Expanded(child: TextField(controller: nameController)),
            ]),
            Row(
              children: [
                const Expanded(child: Text("Email")),
                Expanded(child: TextField(controller: emailController)),
              ],
            ),
            Row(
              children: [
                const Expanded(child: Text("Body")),
                Expanded(child: TextField(controller: bodyController)),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  sendData();
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }

  void sendData() async {
    CommentModel model = CommentModel(
      postId: int.parse(postIdController.text),
      id: int.parse(idController.text),
      name: nameController.text,
      body: bodyController.text,
      email: emailController.text
    );

    final response = await commentService.postComment(model);
    
    if(response.statusCode == 201){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post Method Success")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Unknown eRROR")));
    }
  }
}
