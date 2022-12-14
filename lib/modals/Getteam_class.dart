class Contact {
  Contact({
    this.contactId,
    this.email,
    this.firstname,
    this.lastname,
    this.mobile,
    this.dob,
    this.contactAddressLine1,
    this.contactAddressLine2,
    this.city,
    this.countyId,
    this.countryId,
    this.isactive,
    this.role,
    this.roleName,
  });

  String? contactId;
  String? email;
  String? firstname;
  String? lastname;
  String? mobile;
  DateTime? dob;
  String? contactAddressLine1;
  String? contactAddressLine2;
  String? city;
  dynamic countyId;
  dynamic countryId;
  bool? isactive;
  int? role;
  String? roleName;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    contactId: json["contact_id"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    mobile: json["mobile"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    contactAddressLine1: json["contact_address_line_1"],
    contactAddressLine2: json["contact_address_line_2"],
    city: json["city"],
    countyId: json["county_id"],
    countryId: json["country_id"],
    isactive: json["isactive"],
    role: json["role"],
    roleName: json["role_name"],
  );

  Map<String, dynamic> toJson() => {
    "contact_id": contactId,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "mobile": mobile,
    "dob": dob,
    "contact_address_line_1": contactAddressLine1,
    "contact_address_line_2": contactAddressLine2,
    "city": city,
    "county_id": countyId,
    "country_id": countryId,
    "isactive": isactive,
    "role": role,
    "role_name": roleName,
  };
}


class Invite {
  Invite({
    this.inviteId,
    this.email,
    this.configName,
  });

  String? inviteId;
  String? email;
  String? configName;

  factory Invite.fromJson(Map<String, dynamic> json) => Invite(
    inviteId: json["invite_id"],
    email: json["email"],
    configName: json["config_name"],
  );

  Map<String, dynamic> toJson() => {
    "invite_id": inviteId,
    "email": email,
    "config_name": configName,
  };
}
