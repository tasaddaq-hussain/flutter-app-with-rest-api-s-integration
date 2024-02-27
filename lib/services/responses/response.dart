import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:meta_melon_task_app/model/posts_model.dart';
import 'package:meta_melon_task_app/services/exceptions/exception_handling.dart';

class Responses {
  Responses._();

  static dynamic processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        log(' body : ${response.body}');
        final jsonData = json.decode(response.body);
        List<PostModel> list = jsonData
            .map<PostModel>((json) => PostModel.fromJson(json))
            .toList();
        return list;
      case 400: //Bad request
        throw BadRequestException(jsonDecode(response.body)['message']);
      case 401: //Unauthorized
        throw UnAuthorizedException(jsonDecode(response.body)['message']);
      case 403: //Forbidden
        throw UnAuthorizedException(jsonDecode(response.body)['message']);
      case 404: //Resource Not Found
        throw NotFoundException(jsonDecode(response.body)['message']);
      case 500: //Internal Server Error
      default:
        throw FetchDataException(
            'Something went wrong! ${response.statusCode}');
    }
  }
}
