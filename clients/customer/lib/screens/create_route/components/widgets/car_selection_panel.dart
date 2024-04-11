import 'package:customer/screens/create_route/components/book_car/book_car.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CarSelectionPanel extends StatelessWidget {
  const CarSelectionPanel({
    super.key,
    required this.bottomController,
    required this.panelController,
    required this.minHeightPanel,
    required this.maxHeightPanel,
  });

  final PanelController bottomController;
  final PanelController panelController;
  final double minHeightPanel;
  final double maxHeightPanel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlidingUpPanel(
        onPanelSlide: (position) {
          bottomController.animatePanelToPosition(1 - position,
              duration: Duration.zero);
        },
        backdropColor: Colors.black,
        backdropOpacity: 0.5,
        backdropEnabled: true,
        controller: panelController,
        minHeight: minHeightPanel,
        maxHeight: maxHeightPanel,
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(80, 217, 217, 217),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(1, 0),
          ),
        ],
        panelBuilder: (sc) => const BookCar(),
      ),
    );
  }
}