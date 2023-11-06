abstract class Urls {
  static const adminUrl = "http://65.2.0.31";
  static const webserver = "$adminUrl:3020";
  static const userLogin = "$webserver/adminLogin";
  static const login = "$webserver/users/loginv2";
  static const validateOtp = "$webserver/users/otpValidatev2";
  static const pancardUpload = '$webserver/users/pancard/upload';
  static const aadharUpload = "$webserver/users/aadharcard/upload";
  static const panCardDetails = '$webserver/users/pancard';
  static const aadharCardDetails = '$webserver/users/aadharcard';
  static const logout = '$webserver/admin/logout';
  static const getInvoice = '$webserver/getInvoice';
  static const generateInvoice =  '$webserver/users/generateInvoice';
  static const kycStatus =  '$webserver/users/getKycStatus';
  static const profileUpdate = '$webserver/users/update';
  static const myProfile = '$webserver/users/getbyid';
  static const pdf = 'https://bigdaddy-casino.s3.ap-south-1.amazonaws.com/invoices/invoice_2.pdf';
  static const pdfLink = 'https://drive.google.com/uc?export=download&id=18SNJJWUJsRxg2Qa1RMZn5M54xygKC9KP';
}
