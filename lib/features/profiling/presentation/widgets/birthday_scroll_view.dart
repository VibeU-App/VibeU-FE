import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class BirthdayScrollView extends StatefulWidget {
  final ValueChanged<DateTime> onBirthdayChanged;

  const BirthdayScrollView({
    super.key,
    required this.onBirthdayChanged,
  });
  
  @override
  State<BirthdayScrollView> createState() => _BirthdayState();
}

class _BirthdayState extends State<BirthdayScrollView> {
  static const yearsOffset = 1900;
  static const monthCount = 12;
  late int yearCount;
  late final ValueNotifier<int> dayCount;
  late final FixedExtentScrollController daysController;
  late final FixedExtentScrollController monthsController;
  late final FixedExtentScrollController yearsController;
  
  @override
  void initState() {
    super.initState();
    final date = DateTime.now();

    yearCount = date.year - yearsOffset;
    dayCount = ValueNotifier<int>(_daysInMonth(monthCount, yearCount));

    daysController = FixedExtentScrollController(
      initialItem: date.day - 1,
    );
    monthsController = FixedExtentScrollController(
      initialItem: date.month - 1,
    );
    yearsController = FixedExtentScrollController(
      initialItem: date.year,
    );
  }

  @override
  void dispose() {
    daysController.dispose();
    monthsController.dispose();
    yearsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSizes.s8,
      children: [
        Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            _label("Day"),
            _label("Month"),
            _label("Year"),
          ],
        ),

        Stack(
          alignment: .center,
          children: [
            Container(
              height: AppTypography.h2.fontSize! * AppTypography.h2.height!,
              margin: .symmetric(vertical: AppTypography.h2.height!),
              decoration: const BoxDecoration(
                color: AppColors.surface600,
                borderRadius: .all(.circular(AppSizes.r12)),
              )
            ),

            SizedBox(
              height: 225,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: dayCount,
                    builder: (_, days, _) {
                      return _DateScrollView(
                        childCount: days,
                        controller: daysController,
                        onSelectedItemChanged: (_) { _updateBirthday(); },
                      );
                    }
                  ),

                  _DateScrollView(
                    childCount: monthCount,
                    controller: monthsController,
                    onSelectedItemChanged: (_) {
                      dayCount.value = _daysInMonth(
                        monthsController.selectedItem + 1,
                        yearsController.selectedItem + yearsOffset,
                      );
                      _updateBirthday();
                    },
                  ),

                  _DateScrollView(
                    offset: yearsOffset,
                    childCount: yearCount,
                    controller: yearsController,
                    onSelectedItemChanged: (_) {
                      dayCount.value = _daysInMonth(
                        monthsController.selectedItem + 1,
                        yearsController.selectedItem + yearsOffset,
                      );
                      _updateBirthday();
                    },
                  ),
                ]
              )
            )
          ]
        )
      ]
    );
  }

  void _updateBirthday() {
    widget.onBirthdayChanged(
      DateTime(
        yearsController.selectedItem + yearsOffset,
        monthsController.selectedItem + 1,
        daysController.selectedItem + 1,
      )
    );
  }

  Widget _label(String label) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: AppTypography.h1,
        )
      )
    );
  }

  int _daysInMonth(int monthCount, int yearCount) {
    return DateTime(yearCount, monthCount + 1, 0).day;
  }
}

class _DateScrollView extends StatelessWidget {
  final int offset;
  final int childCount;
  final ScrollController controller;
  final ValueChanged<int> onSelectedItemChanged;

  const _DateScrollView({
    this.offset = 0,
    required this.childCount,
    required this.controller,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        itemExtent: 75,
        controller: controller,
        useMagnifier: true,
        magnification: 1.2,
        onSelectedItemChanged: onSelectedItemChanged,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: childCount,
          builder: (_, i) {
            return Center(
              child: Text(
                '${i + 1 + offset}',
                style: AppTypography.h2,
              )
            );
          }
        )
      )
    );
  }
}
