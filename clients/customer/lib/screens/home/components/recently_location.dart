import 'package:customer/data/data.dart';
import 'package:customer/widgets/recently_arrival_item.dart';
import 'package:flutter/material.dart';

class RecentlyLocation extends StatelessWidget {
  const RecentlyLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          ...recentlyArrivalData.take(3).map(
                (e) => InkWell(
                  onTap: () {
                    // ref
                    //     .read(arrivalLocationProvider.notifier)
                    //     .setArrivalLocation(e);
                    // chooseArrival();
                  },
                  child: RecentlyArrivalItem(
                    padding: 16,
                    data: e,
                  ),
                ),
              )
        ],
      ),
    );
  }
}
