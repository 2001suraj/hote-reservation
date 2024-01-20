// ignore_for_file: public_member_api_docs, sort_constructors_first
class HotelModel {
  String? name;
  String? image;
  String? location;
  String? description;
  String? price;
  String? rating;
  String? person;

  String? status;
  String? checkin;
  String? checkout;
  List<dynamic>? photo;

  HotelModel({
    this.name,
    this.image,
    this.location,
    this.price,
    this.rating,
    this.person,

    this.status,
    this.description,
    this.checkin,
    this.checkout,
    this.photo,

  });
}
