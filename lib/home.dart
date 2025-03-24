import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_caroverview_container.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_icon_button.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_searchBar.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TopBrandCars> topBrandCarsList = [
    TopBrandCars(
        "https://www.carlogos.org/car-logos/tesla-logo-2007-full-640.png",
        "Tesla"),
    TopBrandCars(
        "https://www.carlogos.org/car-logos/bmw-logo-2020-gray.png", "BMW"),
    TopBrandCars(
        "https://www.carlogos.org/car-logos/audi-logo-2016-640.png", "Audi"),
    TopBrandCars(
        "https://www.carlogos.org/logo/Lexus-symbol-1988-1920x1080.png",
        "Lexus"),
    TopBrandCars(
        "https://www.carlogos.org/logo/Mercedes-Benz-logo-2009-1920x1080.png",
        "Mercedes"),
    TopBrandCars(
        "https://www.carlogos.org/car-logos/toyota-logo-2020-europe-640.png",
        "Toyota"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        CustomText(
                          data: locationStr,
                          fontSize: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomIcons(
                              icon: Icons.location_on_outlined,
                              color: primaryColor,
                            ),
                            CustomText(data: "New York, USA")
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    CustomIconButton(
                      icon: Icons.notifications_none_outlined,
                      onPressed: () {},
                      // color: primaryColor,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 6,
                        child: CustomSearchbar(
                          hintText: searchCarBarStr,
                        ),
                      ),
                      // CustomIconButton(
                      //   icon: Icons.filter_list_alt,
                      //   onPressed: () {},
                      //   color: primaryColor,
                      // )
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CustomIconButton(
                                icon: Icons.filter_list_alt,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                onPressed: () {
                                  print("Filter button pressed");
                                })),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomText(
                  data: topBrandsStr,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topBrandCarsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(97, 223, 176, 176),
                              radius: 30,
                              child:
                                  Image.network(topBrandCarsList[index].image),
                            ),
                            CustomText(data: topBrandCarsList[index].name)
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.035,
                // ),
                CustomText(
                  data: popularCarStr,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    itemCount: carDetailsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomCarOverviewContainer(
                            carName: carDetailsList[index].carName,
                            carImageUrl: carDetailsList[index].carImageUrl,
                            logoUrl: carDetailsList[index].logoUrl,
                            rating: carDetailsList[index].rating.toString(),
                            fuelCapacity: carDetailsList[index].fuelCapacity,
                            isManual: carDetailsList[index].isManual,
                            numberOfPeople:
                                carDetailsList[index].numberOfPeople,
                            price: carDetailsList[index].price.toString()
                            //  price: '200',
                            ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<CarDetails> carDetailsList = [
  CarDetails(
      "Tesla Model S",
      "https://www.tesla.com/sites/default/files/modelsx-new/social/model-s-hero-social.jpg",
      "https://www.tesla.com/sites/default/files/favicon.ico",
      "4.8",
      "100 kWh",
      false,
      4,
      88),
  CarDetails(
      "BMW i8",
      "https://www.bmwusa.com/content/dam/bmwusa/i8/2020/BMW-MY20-i8-Coupe-Overview-01.jpg",
      "https://www.bmwusa.com/etc/designs/bmwusa/images/favicon.ico",
      "4.5",
      "11.6 gallons",
      false,
      5,
      120),
  CarDetails(
      "Audi R8",
      "https://www.audi.com/content/dam/ci/2020/1920x1080-stage/1920x1080_Audi_R8_Coupe_V10_performance_quattro_2020_157.jpg",
      "https://www.audi.com/etc/designs/audi/favicon.ico",
      "4.7",
      "19.3 gallons",
      true,
      2,
      200),
  CarDetails(
      "Lexus LC",
      "https://www.lexus.com/cm-img/gallery/2021/LC/2021-Lexus-LC-Gallery-001.jpg",
      "https://www.lexus.com/etc/designs/lexus/images/favicon.ico",
      "4.6",
      "21.7 gallons",
      true,
      2,
      200),
  CarDetails(
      "Mercedes-Benz S-Class",
      "https://www.mbusa.com/content/dam/mb-nafta/us/myco/my21/s/sedan/class-page/2021-S-SEDAN-CLASS-HERO-1-DR.jpg",
      "https://www.mbusa.com/etc/designs/mb-nafta/us/favicon.ico",
      "4.9",
      "22.5 gallons",
      false,
      7,
      200),
  CarDetails(
      "Toyota Supra",
      "https://www.toyota.com/imgix/responsive/images/mlp/colorizer/2021/supra/3P0/1.png",
      "https://www.toyota.com/etc/designs/toyota/images/favicon.ico",
      "4.4",
      "13.7 gallons",
      true,
      8,
      200),
  CarDetails(
      "Ford Mustang",
      "https://www.ford.com/cmslibs/content/dam/brand_ford/en_us/brand/cars/mustang/2021/collections/dm/21_FRD_MST_wdmp_200505_01_2160x1080.jpg",
      "https://www.ford.com/etc/designs/ford/images/favicon.ico",
      "4.3",
      "16 gallons",
      false,
      2,
      200),
  CarDetails(
      "Chevrolet Camaro",
      "https://www.chevrolet.com/content/dam/chevrolet/na/us/english/index/vehicles/2021/performance/camaro/mov/01-images/2021-camaro-masthead-01.jpg",
      "https://www.chevrolet.com/etc/designs/chevrolet/images/favicon.ico",
      "4.2",
      "19 gallons",
      false,
      6,
      200),
  CarDetails(
      "Porsche 911",
      "https://files.porsche.com/filestore/image/multimedia/none/992-carrera-modelimage-sideshot/thumbwhite/7e9b7e4b-4b1e-11e9-80c4-005056bbdc38;sJ;twebp/porsche-thumbwhite.webp",
      "https://www.porsche.com/favicon.ico",
      "4.9",
      "16.9 gallons",
      true,
      4,
      200),
  CarDetails(
      "Nissan GT-R",
      "https://www.nissanusa.com/content/dam/Nissan/us/vehicles/gtr/2021/overview/2021-nissan-gtr-50th-anniversary-edition.jpg",
      "https://www.nissanusa.com/etc/designs/nissan/images/favicon.ico",
      "4.8",
      "19.5 gallons",
      false,
      5,
      200),
];

class CarDetails {
  String carName;
  String carImageUrl;
  String logoUrl;
  bool isManual;
  int numberOfPeople;
  String rating;
  String fuelCapacity;
  double? price;
  CarDetails(this.carName, this.carImageUrl, this.logoUrl, this.rating,
      this.fuelCapacity, this.isManual, this.numberOfPeople, this.price);
}

class TopBrandCars {
  String image;
  String name;
  TopBrandCars(this.image, this.name);
}
