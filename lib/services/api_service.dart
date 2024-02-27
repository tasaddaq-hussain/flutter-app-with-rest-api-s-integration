import 'package:http/http.dart' as http;
import 'package:meta_melon_task_app/config/constant.dart';
import 'package:meta_melon_task_app/model/posts_model.dart';
import 'package:meta_melon_task_app/services/exceptions/exception_handling.dart';
import 'package:meta_melon_task_app/services/responses/response.dart';

class ApiService {
  Future<List<PostModel>> getPostApi() async {
    var uri = Uri.parse(URL);
    try {
      var response = await http.get(uri);
      return Responses.processResponse(response);
    } catch (e) {
      throw ExceptionHandlers.getExceptionString(e);
    }
  }
}