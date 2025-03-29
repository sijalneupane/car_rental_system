import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage({super.key});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {},
        // ),
        actions: [
          CustomNoBorderIconButton(
            onPressed: () {},
            icon: Icons.favorite_outlined,
          ),
          SizedBox(width: 10),
        ],
        title: CustomText(data: carDetailStr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://www.pngmart.com/files/22/Audi-Q7-PNG.png',
                height: 200,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomText(
                  data: "360",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data: "Audi Q7 50 Quattro",
                  ),
                  Row(
                    children: [
                      CustomText(
                        data: "Audi",
                      ),
                      Spacer(),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      CustomText(data: " 4.5")
                    ],
                  ),
                  SizedBox(height: 10),
                  TabBarSection(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            data: "Jenny Doe",
                          ),
                          CustomText(
                            data: "Owner",
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.phone, color: Colors.orange),
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    data: descriptionStr,
                  ),
                  CustomText(
                    data:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CustomText(
                        data: "\$88",
                      ),
                      CustomText(
                        data: perDayStr,
                      ),
                      Spacer(),
                      CustomElevatedbutton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: CustomText(
                            data: rentNowStr,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: "About"),
              Tab(text: "Gallery"),
              Tab(text: "Review"),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
