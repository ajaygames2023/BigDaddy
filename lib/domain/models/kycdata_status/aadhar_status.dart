class AadharData {
  int? userId;
  String? name;
  String? state;
  String? aadharNumber;
  String? aadharCardFrontimage;
  String? aadharCardBackimage;
  String? status;
  // Null? remarks;
  // Null? idfyRequestId;
  // Null? idfyStatus;
  String? createdAt;
  String? updatedAt;

  AadharData(
      {this.userId,
      this.name,
      this.state,
      this.aadharNumber,
      this.aadharCardFrontimage,
      this.aadharCardBackimage,
      this.status,
      // this.remarks,
      // this.idfyRequestId,
      // this.idfyStatus,
      this.createdAt,
      this.updatedAt});

  AadharData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    state = json['state'];
    aadharNumber = json['aadharNumber'].toString();
    aadharCardFrontimage = json['aadharCardFrontimage'];
    aadharCardBackimage = json['aadharCardBackimage'];
    status = json['status'];
    // remarks = json['remarks'];
    // idfyRequestId = json['idfyRequestId'];
    // idfyStatus = json['idfyStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}