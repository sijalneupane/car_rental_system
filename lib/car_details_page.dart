import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/route_const.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/home.dart';
import 'package:car_rental_system/model/car.dart';
import 'package:car_rental_system/widgets/custom_app_bar.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_circle_avatar.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_image_assets.dart';
import 'package:car_rental_system/widgets/custom_image_network.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_review_container.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/padding_for_all_pages.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatefulWidget {
 Car carDetail;
   CarDetailsPage({super.key,required this.carDetail});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  FocusNode focusNode = FocusNode();
  // State to manage the selected tab
  final List<bool> _selectedTabs = [true, false, false];
  final List<String> _tabs = [aboutStr, galleryStr, reviewStr];
  int _activeIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  // var carDetail=ModalRoute.of(context)?.settings.arguments as Car;
    return Scaffold(
      body: SafeArea(
        child: PaddingForAllPages (
          bottomPadding: 14,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                hasBackButton: true,
                middleChild: CustomText(data: carDetailStr,isPageTitle: true,),
              ),
              Hero(
                transitionOnUserGestures: true,
                tag: "car-image-${widget.carDetail.carName}",
                child: CustomImageNetwork(
                  name:widget.carDetail.imageUrl!,
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width,
                ),
              ),CustomSizedBox(height: 0.01), 
              Center(
                child: CircleAvatar(
                  backgroundColor: primaryColor,
                  child: CustomText(data: "360°", color: Colors.white),
                ),
              ),
              CustomSizedBox(height: 0.01), // Spacer, // Spacer
          
              // Car Title and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    data: widget.carDetail.carName!,
                    fontSize: 24,
                  ),
                  Row(
                    children: [
                      CustomIcons(icon: Icons.star),
                      CustomText(data: "4.5"),
                    ],
                  ),
                ],
              ),
              CustomSizedBox(height: 0.01),
              CustomText(
                data: widget.carDetail.carBrand!,
                textAlign: TextAlign.left,
              ),
              CustomSizedBox(height: 0.01), // Spacer
              // Tabs (About, Gallery, Review) using ToggleButtons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_tabs.length, (index) {
                  final bool isActive = _activeIndex == index;
          
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeIndex = index;
                      });
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOutCubicEmphasized,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOutCubicEmphasized,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isActive
                                ? primaryColor
                                : greyColor.withValues(alpha: .81),
                            width: 2.0,
                          ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.305,
                      alignment: Alignment.center,
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: isActive ? primaryColor : greyColor,
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              CustomSizedBox(height: 0.02), // Spacer, // Spacer
          
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _activeIndex = index;
                    });
                  },
                  children: [
                    _aboutCarBox(context),
                    _galleryPage(),
                    _reviewTab(context)
                  ],
                ),
              ),
              CustomSizedBox(height: 0.01),
              // Price and Rent Now Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: priceStr,
                        color: greyColor,
                      ),
                      Row(
                        children: [
                          CustomText(data: "\$ ${widget.carDetail.rentPrice}"),
                          CustomText(
                            data: perDayStr,
                            color: greyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomElevatedbutton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const Text(rentNowStr),
                    onPressed: () {
                      RouteGenerator.navigateToPage(context,Routes.carBookingRoute,arguments: widget.carDetail);
                      // Add your rent now logic here
                    },
                  ),
                ],
              ) // Spacer
            ],
          ),
        ),
      ),
    );
  }
}

//about tab
Widget _aboutCarBox(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        data: rentPartnerStr,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      CustomSizedBox(height: 0.02), // Spacer
      // Rent Partner Section
      Row(
        children: [
          CustomCircleAvatar(
            backgroundImage: const NetworkImage(
              'https://randomuser.me/api/portraits/men/85.jpg',
            ),
          ),
          CustomSizedBox(width: 0.02), // Spacer
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(data: "Jenny Doe"),
              CustomText(
                data: "Owner",
                color: greyColor,
              ),
            ],
          ),
          const Spacer(),
          CustomSizedBox(width: 0.01), // Spacer
          CustomBorderIconButton(
            icon: Icons.message,
            onPressed: () {},
          ),
          CustomSizedBox(width: 0.02), // Spacer, // Spacer

          CustomBorderIconButton(
            icon: Icons.phone,
            onPressed: () {},
          ),
        ],
      ),

      CustomSizedBox(height: 0.02),
      // Description Section
      CustomText(
        data: descriptionStr,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      CustomSizedBox(height: 0.02), // Spacer,
      CustomText(
        data:
            "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry's standard dummy text.",
      ),
    ],
  );
}

//gallery page
Widget _galleryPage() {
  final List<String> images = List.generate(
    20,
    (index) => 'https://picsum.photos/seed/$index/200/300',
  );
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // Number of columns
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ),
    itemCount: images.length,
    itemBuilder: (context, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(images[index], fit: BoxFit.cover),
      );
    },
  );
}

Widget _reviewTab(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        data: reviewStr,
        fontSize: 20,
      ),
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 5,
          itemBuilder: (context, index) {
            return CustomReviewContainer(
                reviewerName: "Ram ji",
                reviewerInfo: "Manager at abc ",
                reviewedDateTime: "01-01-2025");
          },
        ),
      )
    ],
  );
}
