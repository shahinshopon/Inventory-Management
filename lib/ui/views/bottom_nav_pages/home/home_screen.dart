import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamplates_app/const/app_colors.dart';
import 'package:tamplates_app/const/app_strings.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/inventory/inventory_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/product/products_screen.dart';

class HomeScreen extends StatelessWidget {
  int number;
  HomeScreen(this.number);
  final _pages = [
    const ProductsScreen(),
    const InventoryScreen(),
  ];
   
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    RxInt _currentIndex = number.obs;
    return Obx(() => Scaffold(
          // key: scaffoldKey,
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   automaticallyImplyLeading: false,
          //   leading: IconButton(onPressed: (){
          //   scaffoldKey.currentState?.openDrawer();
          //   }, icon: const Icon(Icons.menu,color: Colors.black,)),
          //   title: Text(_currentIndex.value==0?"All Products":"My Inventory(Add)",style: TextStyle(fontSize: 20.w,color: Colors.black),),
          //   actions: [
          //     IconButton(
          //         icon: const Icon(Icons.check_box,color: Colors.black,),
          //         onPressed: () {
          //           Get.to(Selectedscreen());
          //         }),
          //     // IconButton(
          //     //     icon: Icon(Icons.search,color: Colors.black),
          //     //     onPressed: () {
          //     //       showSearch(context: context, delegate: Search());
          //     //     })
          //   ],
          // ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedIconTheme:
                const IconThemeData(color: AppColors.greenAccent),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.border_color_outlined,
                  ),
                  label: AppString.allProducts),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                  ),
                  label: AppString.myInventory),
            ],
            currentIndex: _currentIndex.value.toInt(),
            onTap: (int index) {
              _currentIndex.value = index;
            },
          ),
          body: _pages[_currentIndex.value.toInt()],
          // drawer: Drawer(
          //   child: SingleChildScrollView(
          //     child: Padding(
          //       padding: EdgeInsets.only(top: 100.h, left: 20.w),
          //       child: Column(
          //         children: [
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Image.asset(
          //                 AppString.bookImage,
          //                 height: 50.h,
          //               ),
          //               SizedBox(
          //                 width: 15.w,
          //               ),
          //               Text(
          //                 AppString.myPrepper,
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.w500, fontSize: 20.sp),
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 40.h,
          //           ),
          //           const Divider(
          //             color: Colors.black,
          //           ),
          //           drawerItemMobile(
          //              Icons.drag_handle,
          //               AppString.user, () {
          //             Get.toNamed(user);
          //           }),
          //           drawerItemMobile(
          //               Icons.speaker_phone,
          //               AppString.assistant,
          //               () {}),
          //           SizedBox(
          //             height: 30.h,
          //           ),
          //           const Divider(
          //             color: Colors.black,
          //           ),
          //           drawerItemMobile(
          //               Icons.question_mark,
          //               AppString.about, () {
          //             Get.toNamed(about);
          //           }),
          //           drawerItemMobile(
          //               Icons.share,
          //               AppString.share,
          //               () {
          //                 LaunchReview.launch(
          //                   androidAppId: 'com.example.tamplates_app'
          //                 );
          //               }),
          //           SizedBox(
          //             height: 25.h,
          //           ),
          //           const Divider(
          //             color: Colors.black,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ));
  }
}
