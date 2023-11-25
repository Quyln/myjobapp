class SenderApplyJobDto {
  String sendername;
  String senderphone;
  String creatorid;
  String jobposition;
  String khuvuchuyen;
  String khuvuctinh;

  SenderApplyJobDto({
    required this.sendername,
    required this.senderphone,
    required this.creatorid,
    required this.jobposition,
    required this.khuvuchuyen,
    required this.khuvuctinh,
  });

  static Map<String, dynamic> toJson(SenderApplyJobDto data) {
    return {
      'sendername': data.sendername,
      'senderphone': data.senderphone,
      'creatorid': data.creatorid,
      'jobposition': data.jobposition,
      'khuvuctinh': data.khuvuctinh,
      'khuvuchuyen': data.khuvuchuyen,
    };
  }
}
