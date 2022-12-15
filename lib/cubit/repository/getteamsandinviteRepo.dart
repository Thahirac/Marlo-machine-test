// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:result_type/result_type.dart';

import '../../networking/api_base_helper.dart';
import '../../networking/endpoints.dart';
import '../../response/response.dart';


abstract class Getteamsandinvite {

  Future<Result> GetTeams();
  Future<Result> Invitmember(String email,String role);

}

class GetTeamview extends Getteamsandinvite {
  ApiBaseHelper _helper = ApiBaseHelper();


  @override
  Future<Result> GetTeams() async {

    String token='eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk3OGI1NmM2NmVhYmIwZDlhNmJhOGNhMzMwMTU2NGEyMzhlYWZjODciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY3MTExNjAwMiwidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjcxMTE2MDAyLCJleHAiOjE2NzExMTk2MDIsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.Pve1SSaLR8jMnUNETA1Kwg0Zwec5XePqKNuVN_mmXPXAdbZmKjTqxTac1olbwq_LrYSOEdnDpSBnQ9920a7rCRQIs6v6lThra_8dzfWmQOMSNtp7QIkB_UNPaSrrVbp0zzaQMtTxA6OZsaQJrBSHs9IUmFqYFbo2LaaK4I8HHsYLFihx3KCyWQBpPTn-3gZBzXjI5HmmqqDTtRbeobN8g78JTOlX_auiyWbfSBWMhcn0dSJ2IQJk3OsNYIJEo4hvWzoEJzzG_EjriYBJV3NaCwPJuxmQJ3n-aajrJMveX-3x4_Jx3-1aytGxLGvjVBQhnSG8vQh5eeimAk1J6C8wNg';
    String responseString = await (_helper.get(
        APIEndPoints.urlString(EndPoints.teamviewandinvitelist),token: token
    ));
    Response response = Response.fromJson(json.decode(responseString));
    if (response.error_flag == "SUCCESS") {

      return Success(response.data);
    } else {
      print(response.data);
      return Failure(response.message);
    }
  }




  @override
  Future<Result> Invitmember(String email,String role) async {

    String token='eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk3OGI1NmM2NmVhYmIwZDlhNmJhOGNhMzMwMTU2NGEyMzhlYWZjODciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY3MTExNjAwMiwidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjcxMTE2MDAyLCJleHAiOjE2NzExMTk2MDIsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.Pve1SSaLR8jMnUNETA1Kwg0Zwec5XePqKNuVN_mmXPXAdbZmKjTqxTac1olbwq_LrYSOEdnDpSBnQ9920a7rCRQIs6v6lThra_8dzfWmQOMSNtp7QIkB_UNPaSrrVbp0zzaQMtTxA6OZsaQJrBSHs9IUmFqYFbo2LaaK4I8HHsYLFihx3KCyWQBpPTn-3gZBzXjI5HmmqqDTtRbeobN8g78JTOlX_auiyWbfSBWMhcn0dSJ2IQJk3OsNYIJEo4hvWzoEJzzG_EjriYBJV3NaCwPJuxmQJ3n-aajrJMveX-3x4_Jx3-1aytGxLGvjVBQhnSG8vQh5eeimAk1J6C8wNg';
    String responseString = await (_helper.post(
        APIEndPoints.urlString(EndPoints.invitemember),email,role,
        token: token));

    Response response = Response.fromJson(json.decode(responseString));
    if (response.error_flag == "SUCCESS") {

      return Success(response.data);
    } else {
      print(response.data);
      return Failure(response.message);
    }
  }


}
