import 'package:customer/screens/authen/login/function/submit_authen.dart';
import 'package:flutter/material.dart';

class LoginItem extends StatelessWidget {
  const LoginItem({
    super.key,
    required this.item,
  });

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: SizedBox(
        height: 54,
        child: Opacity(
          opacity: 1,
          child: ElevatedButton(
            style: ButtonStyle(
              textStyle:
                  MaterialStateProperty.all(Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            onPressed: () {
              handleSubmit(context: context, action: item['key']);
            },
            child: Row(
              children: [
                Image.asset(
                  item['icon'],
                  fit: BoxFit.contain,
                  width: 24,
                  height: 24,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      item['title'] ?? '',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
