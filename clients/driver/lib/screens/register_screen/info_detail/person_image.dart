import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/driver_provider.dart';
import 'package:driver/providers/status_provider.dart';
import 'package:driver/screens/register_screen/remind_info/remind_person_infor.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonImage extends ConsumerStatefulWidget {
  const PersonImage({super.key});

  @override
  ConsumerState<PersonImage> createState() => _PersonImageState();
}

class _PersonImageState extends ConsumerState<PersonImage> {
  File? image;
  late String? idDriver;
  bool isLoading = false;

  handleRegister() async {
    idDriver = ref.watch(driverInfoRegisterProvider).id ?? '6';
    image = ref.watch(driverProvider).personImage;
    print(idDriver);
    print(image);

    if (image != null) {
      setState(() {
        isLoading = true;
      });
      var dataSend = FormData.fromMap({
        'image': [await MultipartFile.fromFile(image!.path)],
        'id': idDriver
      });

      try {
        final dioClient = DioClient();

        final response = await dioClient.request(
          '/upload/personal-img',
          options: Options(method: 'POST'),
          data: dataSend,
        );
        print(response.data);

        if (response.statusCode == 200) {
          ref.read(statusProvider.notifier).setImgPerdon(true);
          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        } else {
          // Handle error
        }
      } catch (e) {
        // Handle error
      }
    } else {
      print('Image is null!');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    print('id_person rebuild');
    image = ref.watch(driverProvider).personImage;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(title: ''),
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Cập nhật hình nền trên ứng dụng. ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Bắt buộc!',
                        style: TextStyle(
                            color: kOrange, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/register/info_v1.png',
                        width: screenWidth *
                            0.8, // Đặt chiều rộng của ảnh là 80% chiều rộng màn hình
                      ),
                    ],
                  ),
                  const Center(
                      child: Text(
                    'Xin chào!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 64,
                          foregroundImage:
                              image != null ? FileImage(image!) : null,
                          child: image == null
                              ? const Icon(
                                  Icons.picture_in_picture_sharp,
                                  size: 50,
                                  color: COLOR_GRAY,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        onPressed: () async {
                          // await pickImage(context: context, setImage: _setImage);
                          // context.pushNamed('remind_person_image');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RemindPersonImage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Tải ảnh lên',
                          style: TextStyle(color: COLOR_TEXT_MAIN),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: () async {
            handleRegister();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kOrange),
          ),
          child: const Text(
            'Lưu',
            style: TextStyle(
              fontSize: 16,
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
