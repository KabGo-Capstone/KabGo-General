import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 64,
            width: 60,
            child: TextField(
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.titleLarge,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      color: Colors.grey), // Màu border khi không focus
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      color: Colors.orange), // Màu border khi focus
                ),
              ),
            ),
          ),
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.headlineLarge,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      color: Colors.grey), // Màu border khi không focus
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      color: Colors.orange), // Màu border khi focus
                ),
              ),
            ),
          ),
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.headlineLarge,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      color: Colors.grey), // Màu border khi không focus
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      color: Colors.orange), // Màu border khi focus
                ),
              ),
            ),
          ),
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.headlineLarge,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      color: Colors.grey), // Màu border khi không focus
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      color: Colors.orange), // Màu border khi focus
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
