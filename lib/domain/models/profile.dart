class MyProfile {
  String? screenName;
  int? userId;
  String? emailId;
  String? mobileNbr;
  String? isMobileVerified;
  String? isEmailVerified;
  String? isPanCardVerified;
  String? isAadharCardVerified;
  String? isBankDetailVerified;
  String? referralCode;
  String? referredBy;
  String? rafBonusOnAmtDeposit;
  String? rafBonusOnDocVerify;
  String? rafBonusOnSignup;
  String? source;
  String? firstName;
  String? dob;
  String? country;
  String? gender;
  String? state;
  String? city;
  String? pinCode;
  String? address;

  MyProfile(
      {this.screenName,
      this.userId,
      this.emailId,
      this.mobileNbr,
      this.isMobileVerified,
      this.isEmailVerified,
      this.isPanCardVerified,
      this.isAadharCardVerified,
      this.isBankDetailVerified,
      this.referralCode,
      this.referredBy,
      this.rafBonusOnAmtDeposit,
      this.rafBonusOnDocVerify,
      this.rafBonusOnSignup,
      this.source,
      this.firstName,
      this.dob,
      this.country,
      this.gender,
      this.state,
      this.city,
      this.pinCode,
      this.address});

  MyProfile.fromJson(Map<String, dynamic> json) {
    screenName = json['screenName'];
    userId = json['userId'];
    emailId = json['emailId'];
    mobileNbr = json['mobileNbr'];
    isMobileVerified = json['isMobileVerified'];
    isEmailVerified = json['isEmailVerified'];
    isPanCardVerified = json['isPanCardVerified'];
    isAadharCardVerified = json['isAadharCardVerified'];
    isBankDetailVerified = json['isBankDetailVerified'];
    referralCode = json['referralCode'];
    referredBy = json['referredBy'];
    rafBonusOnAmtDeposit = json['rafBonusOnAmtDeposit'];
    rafBonusOnDocVerify = json['rafBonusOnDocVerify'];
    rafBonusOnSignup = json['rafBonusOnSignup'];
    source = json['source'];
    firstName = json['firstName'];
    dob = json['dob'];
    country = json['country'];
    gender = json['gender'];
    state = json['state'];
    city = json['city'];
    pinCode = json['pinCode'];
    address = json['address'];
  }
}