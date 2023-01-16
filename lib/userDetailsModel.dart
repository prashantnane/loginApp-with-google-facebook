class UserDetails{
  String? displayName;
  String? email;
  String? photoURL;

  UserDetails({this.displayName, this.email, this.photoURL});

  UserDetails.fromJson(Map<String, dynamic> json)
  {
    displayName = json["displayName"];
    photoURL = json["photoURL"];
    email = json["email"];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> mapData = new Map<String, dynamic>();

    mapData["displayName"] = this.displayName;
    mapData["email"] = this.email;
    mapData["photoURL"] = this.photoURL;

    return mapData;

  }



}