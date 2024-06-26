import 'package:riverpod/riverpod.dart';

import '../models/route_model.dart';

class RouteNotifier extends StateNotifier<RouteModel> {
  RouteNotifier() : super(RouteModel(distance: ''));

  void setRoute(RouteModel value) async {
    state = value;
  }

  void setPrice(String value) {
    state.price = value;
  }

  void setService(String value) {
    state.service = value;
  }

  void setPaymentMethod(String value) {
    state.paymentMethod = value;
  }

  void setCoupon(String value) {
    state.coupon = value;
  }
}

final routeProvider =
    StateNotifierProvider<RouteNotifier, RouteModel>((ref) => RouteNotifier());
