import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

/// Mở bottom sheet chỉnh Date of Birth.
/// Trả về [DateTime] mới nếu user bấm Save, null nếu cancel.
Future<DateTime?> showDobBottomSheet(
  BuildContext context, {
  required DateTime? initialDate,
}) {
  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _DobBottomSheet(initialDate: initialDate),
  );
}

class _DobBottomSheet extends StatefulWidget {
  final DateTime? initialDate;
  const _DobBottomSheet({required this.initialDate});

  @override
  State<_DobBottomSheet> createState() => _DobBottomSheetState();
}

class _DobBottomSheetState extends State<_DobBottomSheet> {
  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;

  late final FixedExtentScrollController _dayController;
  late final FixedExtentScrollController _monthController;
  late final FixedExtentScrollController _yearController;

  final int _minYear = 1950;
  final int _maxYear = DateTime.now().year;

  bool _isChanged = false;

  @override
  void initState() {
    super.initState();
    final date = widget.initialDate ?? DateTime(2006, 7, 7);
    _selectedDay = date.day;
    _selectedMonth = date.month;
    _selectedYear = date.year;

    _dayController = FixedExtentScrollController(initialItem: _selectedDay - 1);
    _monthController =
        FixedExtentScrollController(initialItem: _selectedMonth - 1);
    _yearController =
        FixedExtentScrollController(initialItem: _selectedYear - _minYear);
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _checkChanged() {
    final original = widget.initialDate ?? DateTime(2006, 7, 7);
    final changed = _selectedDay != original.day ||
        _selectedMonth != original.month ||
        _selectedYear != original.year;
    if (_isChanged != changed) {
      setState(() {
        _isChanged = changed;
      });
    }
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  String _getZodiacSign(int day, int month) {
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return "Aries";
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return "Taurus";
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return "Gemini";
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return "Cancer";
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return "Leo";
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return "Virgo";
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return "Libra";
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return "Scorpius";
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return "Sagittarius";
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return "Capricorn";
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return "Aquarius";
    return "Pisces";
  }

  @override
  Widget build(BuildContext context) {
    final age = DateTime.now().year - _selectedYear;
    final zodiac = _getZodiacSign(_selectedDay, _selectedMonth);

    return Container(
      height: 500, // Adjusted height for bottom sheet
      decoration: const BoxDecoration(
        color: AppColors.surface50,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.r12),
        ),
        border: Border(
          top: BorderSide(color: AppColors.surface700, width: 1),
          left: BorderSide(color: AppColors.surface700, width: 1),
          right: BorderSide(color: AppColors.surface700, width: 1),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSizes.s16),
          // Drag handle
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.surface600,
              borderRadius: BorderRadius.circular(AppSizes.r999),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s24,
              vertical: AppSizes.s16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                Text(
                  'Date of Birth',
                  style: AppTypography.h2.copyWith(color: AppColors.textBody500),
                ),
                GestureDetector(
                  onTap: _isChanged
                      ? () {
                          Navigator.of(context).pop(
                            DateTime(_selectedYear, _selectedMonth, _selectedDay),
                          );
                        }
                      : null,
                  child: Text(
                    'Save',
                    style: AppTypography.h3.copyWith(
                      color: _isChanged
                          ? AppColors.textPrimary500
                          : AppColors.textMuted500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Warning text
          RichText(
            text: TextSpan(
              style: AppTypography.bodySmall.copyWith(color: AppColors.textBody500),
              children: [
                const TextSpan(text: 'You can change DOB only '),
                TextSpan(
                  text: '1 time',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.primary500),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSizes.s32),

          // Column Headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Day',
                    textAlign: TextAlign.center,
                    style: AppTypography.h1.copyWith(color: AppColors.textBody900),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Month',
                    textAlign: TextAlign.center,
                    style: AppTypography.h1.copyWith(color: AppColors.textBody900),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Year',
                    textAlign: TextAlign.center,
                    style: AppTypography.h1.copyWith(color: AppColors.textBody900),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.s16),

          // Picker area
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Highlight box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surface600,
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                    ),
                  ),
                ),
                
                // Pickers
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
                  child: Row(
                    children: [
                      // Day Picker
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: _dayController,
                          itemExtent: 48,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedDay = index + 1;
                            });
                            _checkChanged();
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: _getDaysInMonth(_selectedYear, _selectedMonth),
                            builder: (context, index) {
                              final day = index + 1;
                              final isSelected = day == _selectedDay;
                              return Center(
                                child: Text(
                                  day.toString(),
                                  style: isSelected
                                      ? AppTypography.h2.copyWith(color: AppColors.textBody900)
                                      : AppTypography.bodyStd.copyWith(color: AppColors.textBody900),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      
                      // Month Picker
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: _monthController,
                          itemExtent: 48,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedMonth = index + 1;
                              // Adjust day if month has fewer days
                              final daysInMonth = _getDaysInMonth(_selectedYear, _selectedMonth);
                              if (_selectedDay > daysInMonth) {
                                _selectedDay = daysInMonth;
                                _dayController.jumpToItem(_selectedDay - 1);
                              }
                            });
                            _checkChanged();
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 12,
                            builder: (context, index) {
                              final month = index + 1;
                              final isSelected = month == _selectedMonth;
                              return Center(
                                child: Text(
                                  month.toString(),
                                  style: isSelected
                                      ? AppTypography.h2.copyWith(color: AppColors.textBody900)
                                      : AppTypography.bodyStd.copyWith(color: AppColors.textBody900),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Year Picker
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: _yearController,
                          itemExtent: 48,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedYear = index + _minYear;
                              // Adjust day if leap year changes
                              final daysInMonth = _getDaysInMonth(_selectedYear, _selectedMonth);
                              if (_selectedDay > daysInMonth) {
                                _selectedDay = daysInMonth;
                                _dayController.jumpToItem(_selectedDay - 1);
                              }
                            });
                            _checkChanged();
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: _maxYear - _minYear + 1,
                            builder: (context, index) {
                              final year = index + _minYear;
                              final isSelected = year == _selectedYear;
                              return Center(
                                child: Text(
                                  year.toString(),
                                  style: isSelected
                                      ? AppTypography.h2.copyWith(color: AppColors.textBody900)
                                      : AppTypography.bodyStd.copyWith(color: AppColors.textBody900),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSizes.s16),
          
          // Bottom text: 20 years old, Scorpius
          Text(
            '$age years old, $zodiac',
            style: AppTypography.caption.copyWith(color: AppColors.textBody900),
          ),
          
          const SizedBox(height: AppSizes.s48),
        ],
      ),
    );
  }
}
