enum EndPoints {
  teamviewandinvitelist,
  invitemember,
}

class APIEndPoints {

  ///development mode
  static String baseUrl = "https://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev/";

  static String urlString(EndPoints endPoint) {
    return baseUrl + endPoint.endPointString;
  }
}

extension EndPointsExtension on EndPoints {
  // ignore: missing_return
  String get endPointString {
    switch (this) {
      case EndPoints.teamviewandinvitelist:
        return "company/6dc9858b-b9eb-4248-a210-0f1f08463658/teams";
      case EndPoints.invitemember:
        return "invites";
    }
  }
}
