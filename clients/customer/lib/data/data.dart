import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/location_model.dart';

List<LocationModel> proposalArrivalData = [
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
    'icon': FontAwesomeIcons.house,
    'title': 'Nhà',
    'location': LocationModel(
      placeId: 'ChIJEzDP7kYldTERmF-E3bGdo6w',
      structuredFormatting: StructuredFormatting(
          mainText: '25 Đào Trí', secondaryText: 'Phú Thuận, Quận 7, TP.HCM'),
      postion: const LatLng(10.7143033, 106.7430681),
    ),
  },
  {
    'icon': FontAwesomeIcons.briefcase,
    'title': 'Cơ quan',
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
    'icon': FontAwesomeIcons.solidHeart,
    'title': 'Cà phê',
    'location': LocationModel(
      placeId: 'ChIJybh1lrcvdTERAVt6EpkLlEE',
      structuredFormatting: StructuredFormatting(
          mainText: 'Chuk Tea & Coffee',
          secondaryText: 'Đường An Dương Vương, phường 3, Quận 5, TP.HCM'),
      postion: const LatLng(10.7586445, 106.6775209),
    )
  },
  {'icon': FontAwesomeIcons.solidHeart, 'title': 'Mới'},
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

const hotLocation = [
  {
    'name': 'Chợ Bến Thành',
    'location': {'lat': 10.772601107458549, 'long': 106.69802079568974},
    'image': 'lib/assets/hot_location_images/hot_location_1.jpeg',
  },
  {
    'name': 'Dinh Độc Lập',
    'location': {'lat': 10.777089045802247, 'long': 106.69531282452509},
    'image': 'lib/assets/hot_location_images/hot_location_2.jpeg',
  },
  {
    'name': 'Nhà thờ Đức Bà',
    'location': {'lat': 10.77991196343021, 'long': 106.69896525151267},
    'image': 'lib/assets/hot_location_images/hot_location_3.webp',
  },
  {
    'name': 'Bảo tàng Lịch sử Thành phố Hồ Chí Minh',
    'location': {'lat': 10.788174095262406, 'long': 106.7047193668545},
    'image': 'lib/assets/hot_location_images/hot_location_4.jpeg',
  },
  {
    'name': 'Địa đạo Củ Chi',
    'location': {'lat': 11.141982794238555, 'long': 106.46245525016892},
    'image': 'lib/assets/hot_location_images/hot_location_5.jpeg',
  },
  {
    'name': 'Phố đi bộ Nguyễn Huệ',
    'location': {'lat': 10.774022543913913, 'long': 106.70359725151263},
    'image': 'lib/assets/hot_location_images/hot_location_6.webp',
  },
  {
    'name': 'Thảo Cầm Viên',
    'location': {'lat': 10.787764713225958, 'long': 106.70526913801908},
    'image': 'lib/assets/hot_location_images/hot_location_7.jpeg',
  },
  {
    'name': 'Artinus 3D Art Museum',
    'location': {'lat': 10.743198938077613, 'long': 106.6947052956893},
    'image': 'lib/assets/hot_location_images/hot_location_8.jpeg',
  },
  {
    'name': 'Tòa Nhà BITEXCO',
    'location': {'lat': 10.771715747500199, 'long': 106.70433012452519},
    'image': 'lib/assets/hot_location_images/hot_location_9.jpeg',
  },
  {
    'name': 'Công viên nước Đầm Sen',
    'location': {'lat': 10.76905239610597, 'long': 106.63657292306297},
    'image': 'lib/assets/hot_location_images/hot_location_10.jpeg',
  },
];
