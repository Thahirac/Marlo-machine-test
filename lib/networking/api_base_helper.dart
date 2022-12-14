import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'app_exception.dart';

class ApiBaseHelper {


  Future<dynamic> get(String url, {String? token}) async {
    print('Api get, url $url');
    var responseJson;

    try {
      final response = await http.get(Uri.parse(url), headers: {'authtoken': token??""});
      responseJson = _returnResponse(response);


      log("-----------GET-------------track lineStart--------------------------");
      log("-----------GET-------------track lineStart---------------------------");


    } on SocketException {

      Fluttertoast.showToast(
          msg: 'No Internet connection',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }





  Future<dynamic> post(String url,String email,String role, {String? token}) async {
    print('Api Post, url $url');
    var responseJson;

    try {
      final response = await http.post(Uri.parse(url),
          encoding: Encoding.getByName('utf-8'),
          body:{"email":email,
          "role":role
          }, headers: {'Content-Type':'application/x-www-form-urlencoded','authtoken':'$token'});
      responseJson = _returnResponse(response);

      log("------------POST------------track lineStart--------------------------");
      log("------------POST------------track lineStart-----------------------------");

      print(url);
      print(response.body);
    } on SocketException {
      Fluttertoast.showToast(
          msg: 'No Internet connection',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);

      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }



}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return response.body.toString();
    case 201:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return response.body.toString();
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
