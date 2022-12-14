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

    String token='eyJhbGciOiJSUzI1NiIsImtpZCI6InRCME0yQSJ9.eyJpc3MiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGUuY29tLyIsImF1ZCI6Im1hcmxvLWJhbmstZGV2IiwiaWF0IjoxNjcwOTUzMTE0LCJleHAiOjE2NzIxNjI3MTQsInVzZXJfaWQiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiZW1haWwiOiJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIiwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIiwidmVyaWZpZWQiOmZhbHNlfQ.rvEUsssYUY2JydJQuF5_KObUbc-bHpDOCBImXYMLzaJvxG-HASKq5ANR7kFNglg1_jmo8QpgeFJFfT96il_MPZ7p52jvj4lPCOsP5-6REmxC91dIlT27wa6B101hxiAnKQhPK6IbCHwi1vE3wKTN1rlllKicW9w5wcVydrf8ARSzZP1L_EG-XEfV1E3BCgyGs3pR4yQJ7-BL7XhTdE5hVK9WEvOjGvuE4ytKWI42drco3UGjdn9vDJQxELlmX2u47QrAYp1aTERvlW5hKS-e0hfDwLqIVeJjTvCw7sy_IWKXInUx-VDwG2KuZUPwB_JwSi5AE95bvjMSdXqqHAkuqg';
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

    String token='eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk3OGI1NmM2NmVhYmIwZDlhNmJhOGNhMzMwMTU2NGEyMzhlYWZjODciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY3MDk0NTM3MywidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjcwOTQ1MzczLCJleHAiOjE2NzA5NDg5NzMsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.ECgI95_X8tVgeXi-rB4YQjPLkBngWL--FJopVMd1oUVBp7k3rb3axSlUGdXHZ7RLZ9k01xiQQp3FZrLOzzF8YE8lrO9vrbRnTO_RmxvGoFJcyDx7liNaUvGJs3zyVXDr407KPworc98ThOIOlorGqQNKAdDnKFpQunK2kEI_3gHOjKmcEgbZBMogFDf2NsndyiUy69LrCLYhmOBQsdt1uoI_g7ThTqgAWyu1r5-U3yTWh-ovmIFfM6tSafH4VYlBd9k3o4GaAfxZpzaPyppmpa7G-WhK0kiw5ChfbO9JxLNYOUUZ9_T4jY7ajSO_lZiWLNNIcAPq7CkVf5Kv9QFjrg';
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
