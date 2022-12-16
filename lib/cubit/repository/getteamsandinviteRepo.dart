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

  String token='eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk3OGI1NmM2NmVhYmIwZDlhNmJhOGNhMzMwMTU2NGEyMzhlYWZjODciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY3MTE2NTcyMSwidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjcxMTY1NzIxLCJleHAiOjE2NzExNjkzMjEsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.lK9gThrpeP3vnb4IxHdIR4oSrHGhgs6Top4ukR9bhZSk9otBneapz_0BKkUfr5ZnAUzFQcdJcbPWMx6CqpG2GyeNTiAe9471rPnoXOTu_qckP701XbN4k452kkCmqZ5W_amHD8JS1eJ9PgCtxtfSUcrf5k2MhpUkddkCqPu60W2etQ7_-VojUqc-2VcpJ1ToeLVdJWx-3LCFh8C42I6pEtgEsgkex19UEo3QZ5V5ILAFFOyI5y1FXorSFPSg9RdxWpsHXlafIvG8u6JY--keS6oyysMSC4WN1Bsr60ruRZM2iXZeEe4MaCXB1IrCYT3Hcwar-HegyDpG_GNzyq_Wdg';

  @override
  Future<Result> GetTeams() async {


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
