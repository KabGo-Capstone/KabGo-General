import 'package:driver/firebase/auth/google_sign_in.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/widgets/bottom_menu.dart';
import 'package:driver/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    handleSignOut() {
    GoogleSignInController.signOut().then((value) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.clear().then((value) {
          context.go(LoginScreen.path);
        });
      });
    });
  }

    openMenu() {
      return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return BottomMenu(
            height: (100.0 + (41.0 * 3)),
            label: const Text(
              'Hành động',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget: Column(
              children: [
                const Divider(
                  height: 0.5,
                  color: Colors.black12,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: InkWell(
                    onTap: handleSignOut,
                    child: const Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.powerOff,
                          size: 18,
                          color: Color.fromARGB(255, 216, 62, 51),
                        ),
                        SizedBox(width: 13),
                        Text(
                          'Đăng xuất',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 216, 62, 51),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: WButton(
                    width: double.infinity,
                    radius: 50,
                    shadow: const BoxShadow(
                      color: Colors.transparent,
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black12,
                      backgroundColor: Colors.black12,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Đóng',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: openMenu,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FaIcon(FontAwesomeIcons.ellipsisVertical),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
