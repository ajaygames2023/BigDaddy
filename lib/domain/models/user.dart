class UserDetails {
  int? userId;
  String? screenName;
  String? userStatus;
  String? isMobileVerified;
  String? referredBy;
  String? token;
  String? dob;
  String? firstName;
 // Null? state;
  num? depositAmt;
  num? bonusAmt;
  num? winningAmt;
  bool? isNewUser;

  UserDetails(
      {this.userId,
      this.screenName,
      this.userStatus,
      this.isMobileVerified,
      this.referredBy,
      this.token,
      this.dob,
      this.firstName,
     // this.state,
      this.depositAmt,
      this.bonusAmt,
      this.winningAmt,
      this.isNewUser});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    screenName = json['screenName'];
    userStatus = json['userStatus'];
    isMobileVerified = json['isMobileVerified'];
    referredBy = json['referredBy'];
    token = json['token'];
    dob = json['dob'];
    firstName = json['firstName'];
  //  state = json['state'];
    depositAmt = json['depositAmt'];
    bonusAmt = json['bonusAmt'];
    winningAmt = json['winningAmt'];
    isNewUser = json['isNewUser'];
  }
}