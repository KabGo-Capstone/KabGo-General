import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  static const path = '/splash';
  static const name = 'splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final VideoPlayerController _splashVideoController;
  late bool isLoggin = false;

  @override
  void initState() {
    super.initState();
    _initializeSplashVideoPlayer();
  }

  void _initializeSplashVideoPlayer() async {
    // _splashVideoController = VideoPlayerController.networkUrl(Uri.https(
    //     'res.cloudinary.com',
    //     '/dfs9f0qbp/video/upload/f_auto:video,q_auto/r4hpe6nrrdyzf9iyz5mu'));

    _splashVideoController = VideoPlayerController.asset('assets/animations/splash.mp4');

    try {
      await _splashVideoController.initialize();
    } catch (error) {
      if (kDebugMode) {
        print("Error initializing video: $error");
      }
    }

    if (mounted) {
      Future.delayed(const Duration(milliseconds: 600), () {
        setState(() {
          _splashVideoController.setLooping(true);
          _splashVideoController.addListener(() {
            if (!_splashVideoController.value.isLooping &&
                _splashVideoController.value.isCompleted) {
              _splashVideoController.pause();
              context.go('/login');
            }
          });
          _splashVideoController.play();
        });

        // trigger is login
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            isLoggin = true;
          });
        });
      });
    }
  }

  @override
  void dispose() {
    _splashVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSplashVideoLoaded = _splashVideoController.value.isInitialized;

    // if is loggin then stop animation and redirect to home
    if (isSplashVideoLoaded && isLoggin) {
      _splashVideoController.setLooping(false);
    }

    final Widget child = isSplashVideoLoaded
        ? AspectRatio(
            aspectRatio: _splashVideoController.value.aspectRatio,
            child: VideoPlayer(_splashVideoController),
          )
        : const CircularProgressIndicator(
            color: Colors.white,
          );

    return Container(
      color: Colors.white,
      child: Center(
        child: child,
      ),
    );
  }
}
