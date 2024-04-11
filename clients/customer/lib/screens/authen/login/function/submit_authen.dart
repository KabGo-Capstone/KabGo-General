import 'package:customer/screens/authen/login/login_phone_screen.dart';
import 'package:flutter/material.dart';

Future<void> handleSubmit({required BuildContext context, required String action}) async {
  final theme = Theme.of(context);
  switch (action) {
    case 'authen_facebook':
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'Error Occured',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 20,
            ),
          ),
          content: const Text('Facebook login is not supported'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
      break;
    case 'authen_google':
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'Error Occured',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 20,
            ),
          ),
          content: const Text('Google login is not supported'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
      break;
    case 'authen_apple':
      await showDialog(
        context: context,
        builder: (ctx) => Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
            dialogBackgroundColor: Colors.white,
            dialogTheme: const DialogTheme(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
            ),
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text(
              'Error Occured',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 20,
              ),
            ),
            content: const Text('Apple login is not supported'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("OK"))
            ],
          ),
        ),
      );
      break;
    case 'authen_phone':
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPhoneScreen()));
      break;
    default:
  }
}
