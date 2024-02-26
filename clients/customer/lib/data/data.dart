import 'dart:ui';

import 'package:customer/screens/menu_screen/account_information/account_information.dart';
import 'package:customer/screens/menu_screen/booking_history/booking_history.dart';
import 'package:customer/screens/menu_screen/discount/discount.dart';
import 'package:customer/screens/menu_screen/notification/notification.dart';
import 'package:customer/screens/menu_screen/payment_method/payment_method.dart';
import 'package:customer/screens/menu_screen/prefer_location/prefer_location.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/location_model.dart';

List<LocationModel> recentlyArrivalData = [
  LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'Trường Đại Học Khoa Học Tự Nhiên',
          secondaryText: '227 Nguyễn Văn Cừ, phường 4, quận 5, TP.HCM')),
  LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'Bệnh Viện Đại Học Y Dược TP.HCM',
          secondaryText: '215 Hồng Bàng, phường 11, quận 5, TP. HCM')),
  LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'CGV - Landmark 81',
          secondaryText:
              '772 Điện Biên Phủ, phường 12, quận Bình Thạnh, TP. HCM')),
  LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'Trường Đại Học Khoa Học Tự Nhiên',
          secondaryText: '227 Nguyễn Văn Cừ, phường 4, quận 5, TP.HCM')),
  LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'Bệnh Viện Đại Học Y Dược TP.HCM',
          secondaryText:
              '215 Hồng Bàng, phường 11, quận 5, TP. HCM 215 Hồng Bàng, phường 11, quận 5, TP. HCM')),
                LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'Trường Đại Học Khoa Học Tự Nhiên',
          secondaryText: '227 Nguyễn Văn Cừ, phường 4, quận 5, TP.HCM')),
  LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'Bệnh Viện Đại Học Y Dược TP.HCM',
          secondaryText: '215 Hồng Bàng, phường 11, quận 5, TP. HCM')),
  LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'CGV - Landmark 81',
          secondaryText:
              '772 Điện Biên Phủ, phường 12, quận Bình Thạnh, TP. HCM')),
  LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'Trường Đại Học Khoa Học Tự Nhiên',
          secondaryText: '227 Nguyễn Văn Cừ, phường 4, quận 5, TP.HCM')),
  LocationModel(
      placeId: '',
      structuredFormatting: StructuredFormatting(
          mainText: 'Bệnh Viện Đại Học Y Dược TP.HCM',
          secondaryText:
              '215 Hồng Bàng, phường 11, quận 5, TP. HCM 215 Hồng Bàng, phường 11, quận 5, TP. HCM')),
              
];

List<Map<String, Object>> favoriteLocationData = [
  {
    'icon': const FaIcon(
      FontAwesomeIcons.house,
      color: Color(0xff4891FE),
    ),
    'title': 'Home',
    'location': LocationModel(
      placeId: 'ChIJEzDP7kYldTERmF-E3bGdo6w',
      structuredFormatting: StructuredFormatting(
          mainText: '25 Đào Trí', secondaryText: 'Phú Thuận, Quận 7, TP.HCM'),
      postion: const LatLng(10.7143033, 106.7430681),
    ),
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.briefcase,
      color: Color(0xffF8C647),
    ),
    'title': 'Office',
    'location': LocationModel(
      placeId: 'ChIJEQnz-MIndTERzRrJ-HNQrDY',
      structuredFormatting: StructuredFormatting(
          mainText: 'Landmark 81',
          secondaryText:
              'Đường Điện Biên Phủ, Vinhomes Tân Cảng, Phường 22, Bình Thạnh, TP.HCM'),
      postion: const LatLng(10.7949932, 106.7218215),
    )
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.school,
      color: Color(0xffFF2E2E),
    ),
    'title': 'School',
    'location': LocationModel(
      placeId: 'ChIJ3eH0BhwvdTERPZpT1PEAOQQ',
      structuredFormatting: StructuredFormatting(
          mainText:
              'Trường Đại học Khoa học Tự nhiên - Đại học Quốc gia TP.HCM',
          secondaryText: 'Đường Nguyễn Văn Cừ, phường 4, Quận 5, TP.HCM'),
      postion: const LatLng(10.7628356, 106.6824824),
    )
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.heart,
      color: Color(0xffFC77FF),
    ),
    'title': 'Favor',
    'location': LocationModel(
      placeId: 'ChIJybh1lrcvdTERAVt6EpkLlEE',
      structuredFormatting: StructuredFormatting(
          mainText: 'Chuk Tea & Coffee',
          secondaryText: 'Đường An Dương Vương, phường 3, Quận 5, TP.HCM'),
      postion: const LatLng(10.7586445, 106.6775209),
    )
  },
];

List<Map<String, String>> listCarCard = [
  {
    'image': 'lib/assets/motorbike_1.png',
    'name': 'Xe máy',
    'description': 'Tối đa 1 chỗ ngồi',
    'price/m': '5.5',
  },
  {
    'image': 'lib/assets/motorbike_2.png',
    'name': 'Xe tay ga',
    'description': 'Tối đa 1 chỗ ngồi',
    'price/m': '6.3',
  },
  {
    'image': 'lib/assets/oto_mini.png',
    'name': 'Xe Ô tô con',
    'description': 'Từ 2 - 4 chỗ ngồi',
    'price/m': '11.8',
  },
  {
    'image': 'lib/assets/oto.png',
    'name': 'Xe Ô tô',
    'description': 'Từ 7 - 9 chỗ ngồi',
    'price/m': '13.8',
  },
];

List<Map<String, String>> paymentMethodList = [
  {
    'image': 'lib/assets/cash_icon.png',
    'name': 'Tiền mặt',
    'description': 'Mặc định',
  },
  {
    'image': 'lib/assets/master_card_icon.png',
    'name': 'Thẻ ngân hàng',
    'description': '',
  },
  {
    'image': 'lib/assets/zalo_pay_icon.png',
    'name': 'Ví điện tử ZaloPay',
    'description': '',
  },
];

List<Map<String, String>> discountList = [
  {
    'name': 'Giảm 20% tối đa 25k',
    'time': 'T5 09-06-2023',
    'content':
        'Ưu đãi 20% tối đa 25k áp dụng cho loại xe máy, xe tay ga trong khung giờ 9h - 13h',
    'duration': '9h - 13h',
  },
  {
    'name': 'Giảm 30% tối đa 45k',
    'time': 'T5 09-06-2023',
    'content':
        'Ưu đãi 20% tối đa 25k áp dụng cho loại xe oto con, xe oto trong khung giờ 9h - 13h',
    'duration': '5h - 11h',
  },
  {
    'name': 'Giảm 50% tối đa 100k',
    'time': 'T5 09-06-2023',
    'content':
        'Ưu đãi 20% tối đa 25k áp dụng cho loại xe máy, xe tay ga trong khung giờ 9h - 13h',
    'duration': '20h - 22h',
  },
  {
    'name': 'Giảm 20% tối đa 25k',
    'time': 'T5 09-06-2023',
    'content':
        'Ưu đãi 20% tối đa 25k áp dụng cho loại xe máy, xe tay ga trong khung giờ 9h - 13h',
    'duration': '9h - 13h',
  }
];

    const menu_item = [
      {
        'page': AccountInformation(),
        'icon': FontAwesomeIcons.solidCircleUser,
        'title': 'Thông tin tài khoản',
      },
      {
        'page': PreferLocation(),
        'icon': FontAwesomeIcons.solidHeart,
        'title': 'Điểm đến yêu thích',
      },
      {
        'page': PaymentMethod(),
        'icon': FontAwesomeIcons.moneyCheckDollar,
        'title': 'Phương thức thanh toán',
      },
      {
        'page': Discount(),
        'icon': FontAwesomeIcons.tags,
        'title': 'Khuyến mãi',
      },
      {
        'page': NotificationPage(),
        'icon': FontAwesomeIcons.solidBell,
        'title': 'Thông báo',
      },
      {
        'page': BookingHistory(),
        'icon': FontAwesomeIcons.clockRotateLeft,
        'title': 'Lịch sử đi xe',
      },
      {
        'page': null,
        'icon': FontAwesomeIcons.leftLong,
        'title': 'Đăng xuất',
      },
    ];