import 'package:base_api_prj/Pages/post_page.dart';
import 'package:base_api_prj/Services/comment_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ApiTests());
}

class ApiTests extends StatelessWidget {
  const ApiTests({super.key});

  @override
  Widget build(BuildContext context) {
    CommentService service = CommentService();
    service.getComments();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: service.getComments(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var viewData = snapshot.data![index];
                          return Text(
                              "${viewData.id.toString()} - ${viewData.name}");
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PostDataPage(),
                                ),
                              );
                            },
                            child: Text("Send Data")),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
