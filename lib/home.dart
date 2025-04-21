import 'dart:developer';

import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/loading_and_error_builder.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/model/car.dart';
import 'package:car_rental_system/model/users.dart';
import 'package:car_rental_system/widgets/custom_caroverview_container.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_searchBar.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:car_rental_system/widgets/padding_for_all_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    fetchCarDetails();
   
  }

  List<Car> carsList = [];

  bool loader = false;

  // @override
  // void initState() {
  //   super.initState();
  // }

  void fetchCarDetails() {
    setState(() {
      loader = true;
    });

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection("cars").get().then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          carsList = value.docs.map((doc) {
            var car = Car.fromJson(doc.data());
            car.id = doc.id; // Assuming the Car model has an 'id' field
            return car;
          }).toList();
          // value.docs[0].data()  gets value of 0 index in json format
          // we have multiple value sp we  used for each loop
          //here is the for each loop like value.docs.map((doc)=>Car.fromJson(doc.data())).toList());
          //in above loop value.docs contains list of json of cars collection
          //doc is the name of variable
          //in doc.data() we have the value of 0 index of value.docs list which contain data in json format
          // by usnig CAR.fromJson fucntion we convert json format data to object of class named Car
          //so out carlist contains the list of objects of car class

          loader = false;
        });
      } else {
        setState(() {
          loader = false;
        });
        DisplaySnackbar.show(context, "No values");
      }
    }).catchError((e) {
      setState(() {
        loader = false;
      });
      DisplaySnackbar.show(context, e.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _ui(),
            loader ? Loader.backdropFilter(context) : SizedBox()
          ],
        ));
  }

  Widget _ui() {
    return SafeArea(
      child: SingleChildScrollView(
        child: PaddingForAllPages(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //just like app bar
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: locationStr,
                        fontSize: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomIcons(
                            icon: Icons.location_on_outlined,
                            color: primaryColor,
                          ),
                          CustomText(
                            data: "New York, USA",
                            fontSize: 16,
                          )
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  CustomBorderIconButton(
                    icon: Icons.notifications_none_outlined,
                    color: greyColor,
                    onPressed: () {},
                    // color: primaryColor,
                  ),
                ],
              ),
              //ended just like appbar

              Container(
                height: MediaQuery.of(context).size.height*0.08,
              padding: const EdgeInsets.only(top: 10.0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 6,
                      child: CustomSearchbar(
                        hintText: searchCarBarStr,
                        readOnly: true,
                        onTap: () {
                          bool fromSearchBar = true;
                          RouteGenerator.navigateToPage(
                              context, Routes.viewCarListRoute,
                              arguments: fromSearchBar);
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          height:double.infinity ,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: primaryColor
                          ),
                          child: CustomIcons(
                            icon: Icons.filter_list_alt,
                            color: Colors.white,
                          ),
                        ),
                            onTap: () {}),
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
                                const Color.fromARGB(96, 173, 172, 172),
                            radius: 30,
                            child: ClipOval(
                              child: Image.network(topBrandCarsList[index].image,
                              loadingBuilder: LoadingAndErrorBuilder().customLoadingBuilder(height:30 ),
                              errorBuilder: LoadingAndErrorBuilder().customErrorBuilder(height: 30,width: 30),),
                            ),
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
                height: MediaQuery.of(context).size.height * 0.47,
                child: ListView.builder(
                  itemCount: carsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomCarOverviewContainer(
                        carName: carsList[index].carName ?? "hello",
                        carImageUrl:
                            carsList[index].imageUrl ?? carPlaceholderImageUrl,
                        logoUrl:
                            "https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg",
                        rating: "4.5",
                        fuelCapacity: carsList[index].fuelCapacity ?? "",
                        carType: carsList[index].carType ?? "",
                        numberOfPeople: carsList[index].passengerCapacity ?? "",
                        price: carsList[index].rentPrice ?? "",
                        //  price: '200',
                        onPressed: () {
                          RouteGenerator.navigateToPage(
                              context, Routes.carDetailsRoute,
                              arguments: carsList[index]);
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//   Widget searchBar({bool? autofocus,void Function(String)? onChanged,void Function()? onTap,bool? readOnly,String? hintText }){
//     FocusNode _focusNode=FocusNode();
//     return TextFormField(
//       autofocus: autofocus ?? false,
//       focusNode: _focusNode,
//       onChanged: onChanged,
//       onTap: onTap,
//       readOnly: readOnly ?? false,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: const Color.fromARGB(255, 255, 255, 255),
//         hintText: hintText,
//         prefixIcon: CustomIcons(icon: Icons.search),
//         contentPadding: const EdgeInsets.all(8),
//         focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(width: 1, color: primaryColor)),
//         hintStyle: const TextStyle(color: greyColor),
//         alignLabelWithHint: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//       ),
//     );
//   }
}
// List<CarDetails> carDetailsList = [
//   CarDetails(
//       "Toyota Supra",
//       "https://content.presspage.com/uploads/1523/f2d90f57-531b-4e28-add8-90171eb0a345/1920_fe-001.jpg?x=1732560151998",
//       "https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg",
//       "4.4",
//       "13.7 ",
//       true,
//       8,
//       200),
//   CarDetails(
//       "Ford Mustang",
//       "https://www.vdm.ford.com/content/dam/na/ford/en_us/images/mustang/2025/jellybeans/Ford_Mustang_2025_700A_PG1_88A_89A_13K_COU_64R_67J_990_19X_18Z_91A_17P_44E_MAC_YZTAC_DEFAULT_EXT_4.png",
//       "https://images5.alphacoders.com/402/402829.jpg",
//       "4.3",
//       "16 ",
//       false,
//       2,
//       200),
//   CarDetails(
//       "Chevrolet Camaro",
//       "https://cdn-ds.com/media/3410/zmot/2023_Chevrolet_Blazer_Premier_-_Black.png",
//       "https://car-brand-names.com/wp-content/uploads/2015/08/Chevrolet-Logo.png",
//       "4.2",
//       "19 ",
//       false,
//       6,
//       200),
//   CarDetails(
//       "Porsche 911",
//       "https://media.zigcdn.com/media/model/2023/Feb/911.jpg",
//       "https://www.porsche.com/favicon.ico",
//       "4.9",
//       "16.9 ",
//       true,
//       4,
//       200),
//   CarDetails(
//       "Nissan GT-R",
//       "https://www.nissanusa.com/content/dam/Nissan/us/vehicles/gtr/2021/overview/2021-nissan-gtr-50th-anniversary-edition.jpg",
//       "https://p7.hiclipart.com/preview/58/113/73/nissan-car-logo-nissan.jpg",
//       "4.8",
//       "19.5 ",
//       false,
//       5,
//       200),
//   CarDetails(
//       "Toyota Supra",
//       "https://content.presspage.com/uploads/1523/f2d90f57-531b-4e28-add8-90171eb0a345/1920_fe-001.jpg?x=1732560151998",
//       "https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg",
//       "4.4",
//       "13.7",
//       true,
//       8,
//       200),
//   CarDetails(
//       "Ford Mustang",
//       "https://www.vdm.ford.com/content/dam/na/ford/en_us/images/mustang/2025/jellybeans/Ford_Mustang_2025_700A_PG1_88A_89A_13K_COU_64R_67J_990_19X_18Z_91A_17P_44E_MAC_YZTAC_DEFAULT_EXT_4.png",
//       "https://images5.alphacoders.com/402/402829.jpg",
//       "4.3",
//       "16 ",
//       false,
//       2,
//       200),
//   CarDetails(
//       "Chevrolet Camaro",
//       "https://cdn-ds.com/media/3410/zmot/2023_Chevrolet_Blazer_Premier_-_Black.png",
//       "https://car-brand-names.com/wp-content/uploads/2015/08/Chevrolet-Logo.png",
//       "4.2",
//       "19 ",
//       false,
//       6,
//       200),
//   CarDetails(
//       "Porsche 911",
//       "https://media.zigcdn.com/media/model/2023/Feb/911.jpg",
//       "https://www.porsche.com/favicon.ico",
//       "4.9",
//       "16.9 ",
//       true,
//       4,
//       200),
//   CarDetails(
//       "Nissan GT-R",
//       "https://www.nissanusa.com/content/dam/Nissan/us/vehicles/gtr/2021/overview/2021-nissan-gtr-50th-anniversary-edition.jpg",
//       "https://p7.hiclipart.com/preview/58/113/73/nissan-car-logo-nissan.jpg",
//       "4.8",
//       "19.5 ",
//       false,
//       5,
//       200),
// ];

// class CarDetails {
//   String carName;
//   String carImageUrl;
//   String logoUrl;
//   bool isManual;
//   int numberOfPeople;
//   String rating;
//   String fuelCapacity;
//   double? price;
//   CarDetails(this.carName, this.carImageUrl, this.logoUrl, this.rating,
//       this.fuelCapacity, this.isManual, this.numberOfPeople, this.price);
// }

class TopBrandCars {
  String image;
  String name;
  TopBrandCars(this.image, this.name);
}
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