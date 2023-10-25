class CardDetails {
  int? userId;
  String? name;
  String? state;
  String? aadharNumber;
  String? aadharCardFrontimage;
  String? aadharCardBackimage;
  String? status;
  String? remarks;
  String? panNumber;
  String? panCardimage;

  CardDetails(
      {this.userId,
      this.name,
      this.state,
      this.aadharNumber,
      this.aadharCardFrontimage,
      this.aadharCardBackimage,
      this.status,
      this.remarks,
      this.panNumber,
      this.panCardimage});

  CardDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    state = json['state'];
    aadharNumber = json['aadharNumber'].toString();
    aadharCardFrontimage = json['aadharCardFrontimage'];
    aadharCardBackimage = json['aadharCardBackimage'];
    status = json['status'];
    remarks = json['remarks'];
    panNumber = json['panNumber'];
    panCardimage = json['panCardimage'];
  }
}