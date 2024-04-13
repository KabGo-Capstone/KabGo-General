import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChoosePhoneWidget extends StatefulWidget {
  const ChoosePhoneWidget({super.key});

  @override
  State<ChoosePhoneWidget> createState() => _ChoosePhoneWidgetState();
}

class _ChoosePhoneWidgetState extends State<ChoosePhoneWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FractionallySizedBox(
      heightFactor: 0.95,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xffEF773F),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const FaIcon(FontAwesomeIcons.xmark),
                ),
                const Spacer(),
                Text(
                  'Chọn quốc gia / khu vực',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                const Visibility(
                  visible: false,
                  child: FaIcon(FontAwesomeIcons.arrowLeftLong),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          Image.asset(
                            'lib/assets/images/vietnam_flag.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text('Vietnam'),
                        ],
                      ),
                      subtitle: const Text('+84'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
