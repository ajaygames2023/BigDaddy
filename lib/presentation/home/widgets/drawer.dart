import 'package:casino/global_widgets/text.dart';
import 'package:casino/presentation/home/controller.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({required this.controller, super.key});
  final ItemsController controller;

  Widget getText(String title) {
    return CasinoText(
        text: title,
        align: TextAlign.start,
       // textStyle: GoogleFonts.ibmPlexSans(),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: CasinoColors.primary);
  }

  Widget getIcon(String image, {bool? isAssetImage}) {
      return Image.asset(
        image,
        scale: 3.8,
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: CasinoColors.secondary,
        width: MediaQuery.of(context).size.width * 0.5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: GetBuilder<ItemsController>(builder: (context) {
          return Column(
            children: [
              const SizedBox(height: 40,),
              // Expanded(
              //   child: DrawerHeader(
              //     decoration: BoxDecoration(
              //       borderRadius: const BorderRadius.only(
              //           topRight: Radius.circular(20),
              //           bottomLeft: Radius.circular(20),
              //           bottomRight: Radius.circular(20)),
              //       gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [
              //           Colors.black26,
              //           Colors.black26,
              //         ],
              //       ),
              //     ),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Stack(
              //           alignment: Alignment.center,
              //           children: [
              //             Container(
              //                 height: 50,
              //                 width: 50,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(98),
              //                  // color: GamzeyColors.pink,
              //                 ),
              //                 child: Image.asset('assets/images/profile.png')),
              //             //   child: Image.network('https://testfantasy.gamezdaddy.com/fantasy_sports/app/assets/images/Steven.png',scale: 0.7,)),
              //             Container(
              //               height: 55,
              //               width: 55,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(100),
              //                 border: Border.all(
              //                     color: Colors.white, width: 5),
              //                 color: Colors.transparent,
              //               ),
              //             ),
              //           ],
              //         ),
              //         // const SizedBox(width: 10),
              //         // Column(
              //         //   mainAxisAlignment: MainAxisAlignment.center,
              //         //   crossAxisAlignment: CrossAxisAlignment.start,
              //         //   children: [
              //         //     Flexible(
              //         //       child: Text(
              //         //         controller.myProfile?.screenName ?? '',
              //         //         style: GoogleFonts.ibmPlexSans(
              //         //         color: GamzeyColors.base, fontSize: 18),
              //         //       ),
              //         //     ),
              //         //     const SizedBox(
              //         //       height: 2,
              //         //     ),
              //         //     GestureDetector(
              //         //         onTap: () {
              //         //           controller.drawerActions('view_profile');
              //         //         },
              //         //         child: GDText(
              //         //           text: 'View Profile',
              //         //           textStyle: GoogleFonts.ibmPlexSans(
              //         //             color: GamzeyColors.base,
              //         //             fontSize: 12,
              //         //             decoration: TextDecoration.underline,
              //         //           ),
              //         //         )),
              //         //   ],
              //         // )
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 3,
                child: ListView(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    minLeadingWidth: 20,
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -1),
                    // leading: getIcon(
                    //     '${Urls.cdnbase}/fantasy_sports/app/assets/images/Icon%20awesome-wallet.svg'),
                    title: getText('Tarrif'),
                    onTap: () {
                     // controller.drawerActions('Tarrif');
                    },
                  ),
                  // ListTile(
                  //   minLeadingWidth: 20,
                  //   dense: true,
                  //   visualDensity: const VisualDensity(vertical: -1),
                  //   leading: getIcon('assets/images/contest_tickets.png',isAssetImage: true),
                  //   title: getText('Contest Tickets'),
                  //   onTap: () {
                  //    controller.navigateToWallet();
                  //   },
                  // ),
                  ListTile(
                    minLeadingWidth: 20,
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -1),
                    // leading: getIcon(
                    //     "${Urls.cdnbase}/fantasy_sports/app/assets/images/Icon%20material-account-circle.svg"),
                    title: getText("Chips"),
                    onTap: () {
                      Get.back();
                   //   controller.drawerActions('Chips');
                    },
                  ),
                  ListTile(
                    minLeadingWidth: 20,
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -1),
                    // leading: getIcon(
                    //     '${Urls.cdnbase}/fantasy_sports/app/assets/images/Icon%20material-slideshow.svg'),
                    title: getText("Others"),
                    onTap: () {
                  //    controller.drawerActions('Contact');
                    },
                  ),
              ]),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    ListTile(
                      minLeadingWidth: 20,
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -1),
                      // leading: Image.network(
                      //     '${Urls.cdnbase}/fantasy_sports/app/assets/images/log-out.png'),
                      title: getText('Logout'),
                      onTap: () {
                     //   controller.drawerActions('logout');
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
