import 'dart:convert';

import '../Constants/environments.dart';
import '../Entities/Comment.dart';
import 'package:http/http.dart' as http;

class CommentService {
  Future<List<CommentModel>> getComments() async {
    var baseApi = Uri.parse(api);
    final result = await http.get(baseApi);

    List<dynamic> responseList = jsonDecode(result.body);
    List<CommentModel> data = [];

    for (var i = 0; i < responseList.length; i++) {
      data.add(CommentModel.fromJson(responseList[i]));
    }
    return data;
  }

  Future<http.Response> postComment(CommentModel model) async {
    var baseApi = Uri.parse(api);
    final response = await http.post(
      baseApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        model.toJson(),
      ),
    );
    return response;
  }
}
