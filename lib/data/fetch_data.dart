import 'dart:convert';
import 'package:chatai/models/response.dart';
import 'package:chatai/utils/api_helper.dart';
import 'package:chatai/utils/common_functions.dart';
import 'package:http/http.dart' as http;

class FetchDataFromApi {
  Future<Response> postRequest(EndPointItem item, String jsonRequest,
      bool containsHeader, Map<String, String> _header) async {
    http.Response response;
    if (containsHeader) {
      response = await http.post(Uri.parse(item.url),
          body: jsonRequest, headers: _header);
    } else {
      response = await http.post(Uri.parse(item.url), body: jsonRequest);
    }

    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw FetchDataException(
          "An Error Occured with statusCode:- $statusCode");
    }
    print(response.body.toString());
    return Response.fromJson(json.decode(response.body), item);
  }

  Future<Response> getRequest(EndPointItem item, {String jsonRequest}) async {
    http.Response response = await http.get(Uri.parse(
        /*jsonRequest.isNotEmpty ? item.baseURL + jsonRequest : */item.url));
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw FetchDataException(
          "An Error Occurred with statusCode:- $statusCode");
    }
    print(response.body.toString());
    return Response.fromJson(json.decode(response.body), item);
  }
}
