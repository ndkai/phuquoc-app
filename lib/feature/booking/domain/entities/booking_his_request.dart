class BookingHisRequest{
  final String? unitId;
  final String? status;
  final String? from ;
  final String? to;
  final String? doctorId;

  BookingHisRequest(
      {this.unitId, this.status, this.from, this.to, this.doctorId});
}