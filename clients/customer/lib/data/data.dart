import 'dart:ui';
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
    'title': 'Nhà',
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
    'title': 'Văn phòng',
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
    'title': 'Trường học',
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
      FontAwesomeIcons.solidHeart,
      color: Color(0xffFC77FF),
    ),
    'title': 'Điểm đến yêu thích',
    'location': LocationModel(
      placeId: 'ChIJybh1lrcvdTERAVt6EpkLlEE',
      structuredFormatting: StructuredFormatting(
          mainText: 'Chuk Tea & Coffee',
          secondaryText: 'Đường An Dương Vương, phường 3, Quận 5, TP.HCM'),
      postion: const LatLng(10.7586445, 106.6775209),
    )
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.plus,
      size: 28,
      color: Color(0xff6A6A6A),
    ),
  },
];

List<Map<String, String>> listCarCard = [
  {
    'image': 'lib/assets/images/motorbike_1.png',
    'name': 'Xe máy',
    'description': 'Tối đa 1 chỗ ngồi',
    'price/m': '5.5',
  },
  {
    'image': 'lib/assets/images/motorbike_2.png',
    'name': 'Xe tay ga',
    'description': 'Tối đa 1 chỗ ngồi',
    'price/m': '6.3',
  },
  {
    'image': 'lib/assets/images/oto_mini.png',
    'name': 'Xe Ô tô con',
    'description': 'Từ 2 - 4 chỗ ngồi',
    'price/m': '11.8',
  },
  {
    'image': 'lib/assets/images/oto.png',
    'name': 'Xe Ô tô',
    'description': 'Từ 7 - 9 chỗ ngồi',
    'price/m': '13.8',
  },
];

List<Map<String, String>> paymentMethodList = [
  {
    'image': 'lib/assets/images/cash_icon.png',
    'name': 'Tiền mặt',
    'description': 'Mặc định',
  },
  {
    'image': 'lib/assets/images/master_card_icon.png',
    'name': 'Thẻ ngân hàng',
    'description': '',
  },
  {
    'image': 'lib/assets/images/zalo_pay_icon.png',
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

const bottomNavs = [
  {
    'solid-icon': 'lib/assets/nav_icons/solid/circle-location-arrow.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/circle-location-arrow.svg',
    'width': 22,
    'title': 'Trang chủ',
  },
  {
    'solid-icon': 'lib/assets/nav_icons/solid/bell.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/bell.svg',
    'width': 20,
    'title': 'Thông báo',
  },
  {
    'solid-icon': 'lib/assets/nav_icons/solid/badge-percent.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/badge-percent.svg',
    'width': 22,
    'title': 'Ưu đãi',
  },
  {
    'solid-icon': 'lib/assets/nav_icons/solid/money-check-dollar-pen.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/money-check-dollar-pen.svg',
    'width': 25,
    'title': 'Thanh toán',
  },
  {
    'solid-icon': 'lib/assets/nav_icons/solid/circle-user.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/circle-user.svg',
    'width': 22,
    'title': 'Tài khoản',
  }
];
