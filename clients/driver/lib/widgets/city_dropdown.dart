import 'package:flutter/material.dart';
import 'package:driver/constants/colors.dart';

class CustomDropdown extends StatefulWidget {
  final String dataDefault;
  final List<String> data;

  const CustomDropdown({
    super.key,
    required this.dataDefault,
    required this.data,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedCity;
  @override
  void initState() {
    super.initState();
    selectedCity = widget.dataDefault;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kGrey2, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCity,
              onChanged: (newValue) {
                setState(() {
                  selectedCity = newValue!;
                });
              },
              hint: const Text('Chọn giá trị'),
              itemHeight: 48, // Chiều cao của mỗi item trong dropdown
              items: widget.data.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: COLOR_BLACK),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
