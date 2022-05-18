class ParcelModel {
  String id;
  String receiverName;
  double longitude;
  double latitude;
  String sendingDate;
  String address;
  String receiverContact;
  String status;
  double parcelWeight;
  String senderName;
  String senderContact;
  String parcelType;
  String size;
  String deliveryType;
  String recievedBy = "";
  String recievedByNum = "";
  String recievedByEmail = "";
  String recievedByID = "";
  String senderAddress = "";
  int destinationNo;
  ParcelModel(
      {required this.id,
      required this.receiverName,
      required this.longitude,
      required this.latitude,
      required this.sendingDate,
      required this.address,
      required this.receiverContact,
      required this.status,
      required this.parcelWeight,
      required this.senderName,
      required this.senderContact,
      required this.parcelType,
      required this.size,
      required this.deliveryType,
      required this.destinationNo});
}
