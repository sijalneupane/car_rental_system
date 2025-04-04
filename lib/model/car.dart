class Car {
  String? passengerCapacity;
  String? carType;
  String? carBrand;
  String? carName;
  String? fuelCapacity;
  String? rentPrice;

  Car(
      {this.passengerCapacity,
      this.carType,
      this.carBrand,
      this.carName,
      this.fuelCapacity,
      this.rentPrice});

  Car.fromJson(Map<String, dynamic> json) {
    passengerCapacity = json['passengerCapacity'];
    carType = json['carType'];
    carBrand = json['carBrand'];
    carName = json['carName'];
    fuelCapacity = json['fuelCapacity'];
    rentPrice = json['rentPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['passengerCapacity'] = this.passengerCapacity;
    data['carType'] = this.carType;
    data['carBrand'] = this.carBrand;
    data['carName'] = this.carName;
    data['fuelCapacity'] = this.fuelCapacity;
    data['rentPrice'] = this.rentPrice;
    return data;
  }
}
