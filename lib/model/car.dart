import 'package:car_rental_system/core/util/string_utils.dart';

class Car {
  String? id;
  String? passengerCapacity;
  String? carType;
  String? carBrand;
  String? carName;
  String? fuelCapacity;
  String? rentPrice;
  String? rating;
  String? userId;
  String? username;
  String? imageUrl;

  Car(
      {this.id,
      this.passengerCapacity,
      this.carType,
      this.carBrand,
      this.carName,
      this.fuelCapacity,
      this.rentPrice,
      this.rating,
      this.userId,
      this.username,
      this.imageUrl});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "Null";
    passengerCapacity = json['passengerCapacity'] ?? "N/A";
    carType = json['carType'] ?? "N/A";
    carBrand = json['carBrand'] ?? "N/A";
    carName = json['carName'] ?? "N/A";
    fuelCapacity = json['fuelCapacity'] ?? "N/A";
    rentPrice = json['rentPrice'] ?? "N/A";
    rating = json['rating'] ?? "N/A";
    userId = json['userId'] ?? "N/A";
    username = json['username'] ?? "N/A";
    imageUrl = json['imageUrl'] ?? carPlaceholderImageUrl;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['passengerCapacity'] = this.passengerCapacity;
    data['carType'] = this.carType;
    data['carBrand'] = this.carBrand;
    data['carName'] = this.carName;
    data['fuelCapacity'] = this.fuelCapacity;
    data['rentPrice'] = this.rentPrice;
    data['rating'] = this.rating;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
