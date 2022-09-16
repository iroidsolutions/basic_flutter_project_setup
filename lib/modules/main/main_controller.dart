



import 'package:align_flutter_app/modules/main/tabs/history/history_view.dart';
import 'package:align_flutter_app/modules/main/tabs/home/home_view.dart';
import 'package:align_flutter_app/modules/main/tabs/notification/notification_view.dart';
import 'package:align_flutter_app/modules/main/tabs/setting/setting_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../api/api_repository.dart';

class MainController extends GetxController {
  final ApiRepository apiRepository;
  MainController({required this.apiRepository});

  var currentTabIndex = 0.obs;
  var pageIndex = 0.obs;
  var pageList = <Widget>[].obs;
  DateTime currentBackPressTime = DateTime.now();
  Widget? homePage;
  Widget? historyPage;
  Widget? notificationPage;
  Widget? settingPage;
  void switchTab(int index) async {
    currentTabIndex.value = index;
    switch (index) {
      case 0:
        if (!pageList.contains(homePage)) {
          pageList.add(homePage!);
        }
        pageIndex.value = pageList.indexOf(homePage);
        break;
      case 1:
        if (!pageList.contains(historyPage)) {
          pageList.add(historyPage!);
        }

        pageIndex.value = pageList.indexOf(historyPage);
        break;
      case 2:
        Container();
        break;
      case 3:
        if (!pageList.contains(notificationPage)) {
          pageList.add(notificationPage!);
        }
        pageIndex.value = pageList.indexOf(notificationPage);
        break;
      case 4:
        if (!pageList.contains(settingPage)) {
          pageList.add(settingPage!);
        }
        pageIndex.value = pageList.indexOf(settingPage);
        break;

      default:
    }
  }

  @override
  void onInit() {
    homePage = HomeView();
    historyPage = HistoryView();
    notificationPage = NotificationView();
    settingPage = SettingView();
    pageList.add(homePage!);
    super.onInit();
  }
}


// class MainController extends GetxController {
//   final ApiRepository apiRepository;
//
//   MainController({required this.apiRepository});
//   final prefs = Get.find<SharedPreferences>();
//   var currentTabIndex = 0.obs;
//   var pageIndex = 0.obs;
//   var pageList = <String>[].obs;
//
//   DateTime? currentBackPressTime;
//   String? profilePage;
//   String? locationPage;
//   String? notificationPage;
//   String? searchPage;
//   String? messagePage;
//   void switchTab(int index) async {
//     currentTabIndex.value = index;
//     switch (index) {
//       case 0:
//         if (!pageList.contains(profilePage)) {
//           pageList.add(profilePage!);
//         }
//         pageIndex.value = pageList.indexOf(profilePage);
//         break;
//       case 1:
//         if (!pageList.contains(locationPage)) {
//           pageList.add(locationPage!);
//         }
//
//         pageIndex.value = pageList.indexOf(locationPage);
//         break;
//
//       case 2:
//         if (!pageList.contains(searchPage)) {
//           pageList.add(searchPage!);
//         }
//         pageIndex.value = pageList.indexOf(searchPage);
//         break;
//       case 3:
//         if (!pageList.contains(messagePage)) {
//           pageList.add(messagePage!);
//         }
//         pageIndex.value = pageList.indexOf(messagePage);
//         break;
//       case 4:
//         if (!pageList.contains(notificationPage)) {
//           pageList.add(notificationPage!);
//         }
//         pageIndex.value = pageList.indexOf(notificationPage);
//         break;
//       default:
//     }
//   }
//
//   Route? onGenerateRoute(RouteSettings settings, String tabItem) {
//     if (tabItem == Routes.PROFILE) {
//       return getPageRoute(
//         settings,
//         Scaffold(
//             body: Center(
//           child: BaseText(text: "text"),
//         )),
//         // binding: ProfileBinding(),
//       );
//     }
//     // } else if (tabItem == Routes.LOCATION) {
//     //   return getPageRoute(
//     //     settings,
//     //     LocationView(),
//     //     binding: LocationBinding(),
//     //   );
//     // } else if (tabItem == Routes.SEARCH) {
//     //   return getPageRoute(
//     //     settings,
//     //     SearchView(),
//     //     binding: SearchBinding(),
//     //   );
//     // } else if (tabItem == Routes.CHAT) {
//     //   return getPageRoute(
//     //     settings,
//     //     MessageView(),
//     //     binding: MessageBinding(),
//     //   );
//     // } else if (tabItem == Routes.NOTIFICATION) {
//     //   return getPageRoute(
//     //     settings,
//     //     NotificationView(),
//     //     binding: NotificationBinding(),
//     //   );
//     // }
//     return null;
//   }
//
//   GetPageRoute getPageRoute(RouteSettings routeSettings, Widget page,
//       {Bindings? binding}) {
//     return GetPageRoute(
//       settings: routeSettings,
//       page: () => page,
//       binding: binding,
//     );
//   }
//
//   @override
//   void onInit() {
//     profilePage = Routes.PROFILE;
//
//     // locationPage = Routes.LOCATION;
//     // searchPage = Routes.SEARCH;
//     // messagePage = Routes.CHAT;
//     // notificationPage = Routes.NOTIFICATION;
//     pageList.add(profilePage!);
//     super.onInit();
//   }
//
//   Future<bool> onWillPop() {
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
//       currentBackPressTime = now;
//       EasyLoading.showToast(StringConstant.pressthebackbuttontoexit);
//       return Future.value(false);
//     }
//     return Future.value(true);
//   }
// }