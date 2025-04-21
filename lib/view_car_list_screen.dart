import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/dialog_box.dart';
import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/get_user_info.dart';
import 'package:car_rental_system/core/util/loading_and_error_builder.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/model/car.dart';
import 'package:car_rental_system/model/users.dart';
import 'package:car_rental_system/widgets/custom_app_bar.dart';
import 'package:car_rental_system/widgets/custom_circle_avatar.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_image_network.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_searchBar.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/padding_for_all_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ViewCarListScreen extends StatefulWidget {
  bool? fromHomePage;
  ViewCarListScreen({super.key, this.fromHomePage});

  @override
  State<ViewCarListScreen> createState() => _ViewCarListScreenState();
}

class _ViewCarListScreenState extends State<ViewCarListScreen> {
  bool loader = false;
  bool emptyList = false;
  List<Car> preCarsList = [];
  List<Car> carsList = [];
  Users? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCarDetails();
  }

  fetchCarDetails() {
    setState(() {
      loader = true;
    });

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      firestore.collection("cars").get().then((value) {
        if (value.docs.isNotEmpty) {
          setState(() {
            preCarsList = value.docs.map((doc) {
              var car = Car.fromJson(doc.data());
              car.id = doc.id; // Assuming the Car model has an 'id' field
              return car;
            }).toList();
            carsList = preCarsList;
            emptyList = false;
          });
        } else {
          setState(() {
            carsList = preCarsList = List.empty();
            emptyList = true;
          });
          // // ignore: use_build_context_synchronously
          // DisplaySnackbar.show(context, noCarFoudStr, isError: true);
        }
        setState(() {
          loader = false;
        });
      });
    } catch (e) {
      setState(() {
        loader = false;
      });
    }
  }

  fetchUserDetails() async {
    
    GetUserInfo getUserInfo = GetUserInfo();
    String? userId = await getUserInfo.getUserId();
    if (userId != null) {
      user = await getUserInfo.getUserDetails(userId);
    } else {
      user = null;
    }
  }

  Future<bool> deleteCarDetailsById(String docId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection("cars").doc(docId).delete();
      return true;
    } catch (e) {
      // print("Error deleting car: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 00,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          Positioned(
            top: 00,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(800))),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            // bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                  color: greyColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(300))),
            ),
          ),
          ui(context),
          loader ? Loader.backdropFilter(context) : const SizedBox(),
        ],
      ),
    );
  }

  Widget ui(BuildContext context) {
    // print(fromHomePage);
    return SafeArea(
      child: Column(
        children: [
          PaddingForAllPages(
            leftPadding: 12,
            topPadding: 4,
            child: CustomAppBar(
              hasBackButton: true,
              middleChild: CustomText(
                data: viewCarDetailsStr,
                isPageTitle: true,
                color: Colors.white,
              ),
              alignmentOfMiddleChild: Alignment.centerLeft,
            ),
          ),
          Expanded(
            child: SizedBox(
              child: PaddingForAllPages(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomSearchbar(
                        autofocus: widget.fromHomePage,
                        onChanged: (value) {
                          setState(() {
                            carsList = preCarsList
                                .where((car) =>
                                    (car.carName?.toLowerCase() ?? '')
                                        .contains(value.toLowerCase()) ||
                                    (car.carBrand?.toLowerCase() ?? '')
                                        .contains(value.toLowerCase()))
                                .toList();
                            if (carsList.isEmpty) {
                              emptyList = true;
                            } else {
                              emptyList = false;
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: emptyList
                          ? Center(
                              child: CustomText(
                                data: noCarFoudStr,
                                fontSize: 45,
                              ),
                            )
                          : RefreshIndicator.adaptive(
                              triggerMode: RefreshIndicatorTriggerMode.onEdge,
                              elevation:0 ,
                              onRefresh: () {
                                return Future.delayed(
                                    const Duration(seconds: 1), () {
                                  fetchCarDetails();
                                });
                              },
                              child: ListView.builder(
                                physics: const ScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                itemCount: carsList.length,
                                
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 4,
                                    margin: const EdgeInsets.only(bottom: 12.0),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Car Image and Name Row
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            textDirection: index % 2 == 0
                                                ? TextDirection.ltr
                                                : TextDirection.rtl,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  carsList[index].imageUrl ??
                                                      carPlaceholderImageUrl,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder:
                                                      LoadingAndErrorBuilder()
                                                          .customLoadingBuilder(),

                                                  // (context,
                                                  //     child, loadingProgress) {
                                                  //   if (loadingProgress ==
                                                  //       null) {
                                                  //     return child;
                                                  //   }
                                                  //   return Container( decoration: BoxDecoration(
                                                  //       color: greyColor
                                                  //     ),
                                                  //     width:
                                                  //         MediaQuery.of(context)
                                                  //                 .size
                                                  //                 .width *
                                                  //             0.5,
                                                  //     height:
                                                  //         MediaQuery.of(context)
                                                  //                 .size
                                                  //                 .height *
                                                  //             0.2,
                                                  //     child: Center(
                                                  //         child:
                                                  //             CircularProgressIndicator(
                                                  //       value: loadingProgress
                                                  //                   .expectedTotalBytes !=
                                                  //               null
                                                  //           ? loadingProgress
                                                  //                   .cumulativeBytesLoaded /
                                                  //               (loadingProgress
                                                  //                       .expectedTotalBytes ??
                                                  //                   1)
                                                  //           : null,
                                                  //     )),
                                                  //   );
                                                  // },
                                                  errorBuilder:
                                                      LoadingAndErrorBuilder()
                                                          .customErrorBuilder(),
                                                  // (context, error,
                                                  //     stackTrace) {
                                                  //   return Container(

                                                  //     width:
                                                  //         MediaQuery.of(context)
                                                  //                 .size
                                                  //                 .width *
                                                  //             0.5,
                                                  //     height:
                                                  //         MediaQuery.of(context)
                                                  //                 .size
                                                  //                 .height *
                                                  //             0.2,
                                                  //     color: Colors.grey[300],
                                                  //     child: const Icon(
                                                  //         Icons.error),
                                                  //   );
                                                  // },
                                                ),
                                              ),
                                              CustomSizedBox(width: 0.05),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      data: carsList[index]
                                                          .carName!,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    CustomSizedBox(
                                                        height: 0.004),
                                                    CustomText(
                                                      data: carsList[index]
                                                          .carBrand!,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: greyColor,
                                                    ),
                                                    CustomSizedBox(
                                                        height: 0.004),
                                                    Row(
                                                      children: [
                                                        CustomImageNetwork(
                                                          name:
                                                              "https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg",
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                        CustomSizedBox(
                                                            width: 0.008),
                                                        Row(
                                                          children: [
                                                            CustomIcons(
                                                                icon:
                                                                    Icons.star),
                                                            CustomText(
                                                              data: carsList[
                                                                      index]
                                                                  .carBrand!,
                                                              color: greyColor,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          CustomSizedBox(height: 0.01),
                                          GridView.count(
                                            crossAxisCount: 2,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            childAspectRatio: 3,
                                            crossAxisSpacing:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                            mainAxisSpacing: 5,
                                            children: [
                                              _buildInfoTile(
                                                  fuelCapacityLabelStr,
                                                  carsList[index].fuelCapacity,
                                                  Icons.local_gas_station),
                                              _buildInfoTile(
                                                  carTypeHintStr,
                                                  carsList[index].carType,
                                                  Icons.car_crash),
                                              _buildInfoTile(
                                                  seatsStr,
                                                  carsList[index]
                                                      .passengerCapacity,
                                                  Icons.people),
                                              _buildInfoTile(
                                                  priceStr,
                                                  carsList[index].rentPrice,
                                                  Icons.currency_rupee),
                                            ],
                                          ),

                                          const SizedBox(height: 12),

                                          // Owner Information
                                          Row(
                                            children: [
                                              CustomCircleAvatar(
                                                  backgroundImage:
                                                      const NetworkImage(
                                                          "https://randomuser.me/api/portraits/men/85.jpg")),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      // carsList[index].ownerName ??
                                                      data: "Unkwon User",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    CustomText(
                                                      // carsList[index].ownerName ??
                                                      data: "Registered: N/A ",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: greyColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 12),

                                          // Action Buttons
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomNoBorderIconButton(
                                                onPressed: () {
                                                  RouteGenerator.navigateToPage(
                                                      context,
                                                      Routes.addCarDetailsRoute,
                                                      arguments:
                                                          carsList[index]);
                                                  // DisplaySnackbar.show(context,
                                                  //     carsList[index].id!);
                                                },
                                                icon: Icons.edit,
                                                iconButtonColor:
                                                    Colors.lightBlue,
                                                iconColor: Colors.lightBlue,
                                              ),
                                              CustomNoBorderIconButton(
                                                onPressed: () {
                                                  DialogBox.showConfirmBox(
                                                    context: context,
                                                    title:
                                                        deleteCarConfirmTitleStr,
                                                    message:
                                                        deleteCarConfirmMessageStr +
                                                            (carsList[index]
                                                                .carName!),
                                                    onOkPressed: () async {
                                                      try {
                                                        // String deletinCarName=carsList[index]
                                                        //         .carName!;
                                                        bool success =
                                                            await deleteCarDetailsById(
                                                                carsList[index]
                                                                    .id!);
                                                        if (success) {
                                                          DisplaySnackbar.show(
                                                              context,
                                                              deleteCarSuccessMessageStr +
                                                                  carsList[
                                                                          index]
                                                                      .carName!,
                                                              isSuccess: true);
                                                          fetchCarDetails();
                                                        } else {
                                                          throw Exception(
                                                              deleteCarFailedStr);
                                                        }
                                                      } catch (e) {
                                                        DisplaySnackbar.show(
                                                            context,
                                                            e.toString(),
                                                            isError: true);
                                                      }
                                                    },
                                                  );
                                                },
                                                icon: Icons.delete,
                                                iconButtonColor: Colors.red,
                                                iconColor: Colors.red,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for info tiles
  Widget _buildInfoTile(String label, String? value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIcons(icon: icon),
            CustomSizedBox(width: 0.01),
            CustomText(
              data: label,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
          child: CustomText(data: value ?? "N/A"),
        ),
      ],
    );
  }
}
