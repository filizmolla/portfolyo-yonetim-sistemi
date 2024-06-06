import 'package:get/get.dart';

import '../core/constants/routes.dart';


class SideMenuController extends GetxController {
  static SideMenuController instance = Get.find();
  var activeItem = dashboard.obs;
  var hoverItem = ''.obs;
  void changeActiveItemTo(String itemName) => activeItem.value = itemName;

  changeActiveitemTo(String itemName) {
      activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) {
      hoverItem.value = itemName;
    }
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHovering(String itemName) => hoverItem.value == itemName;

}
