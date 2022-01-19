import 'package:get/get.dart';
import 'package:onmarket_test/Services/cart_services.dart';
import 'package:onmarket_test/Services/most_selling_services.dart';
import 'package:onmarket_test/Services/recently_viewed_services.dart';
import './Services/top_rated_services.dart';
import './Controllers/bottom_bar_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationBarModel());
    Get.lazyPut(() => TopRatedServices());
    Get.lazyPut(() => RecentlyViewedServices());
    Get.lazyPut(() => MostSellingServices());
    Get.lazyPut(() => CartController());
  }
}
