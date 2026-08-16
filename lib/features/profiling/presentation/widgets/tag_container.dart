import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

import 'tag_template.dart';

class TagContainerController extends ChangeNotifier {
  TagContainerController({required this._tags});
  List<String> _tags;
  List<String> get tags => _tags;

  void add(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  void remove(String tag) {
    if (_tags.remove(tag)) {
      notifyListeners();
    }
  }

  void setTags(List<String> tags) {
    _tags = List.of(tags);
    notifyListeners();
  }

  void clear() {
    _tags.clear();
    notifyListeners();
  }
}

class TagContainer extends StatelessWidget {
  const TagContainer({
    super.key,
    this.readOnly = false,
    this.enableBorderStrut = true,
    required this.tagBuilder,
    required this.controller,
  });

  final TagContainerController controller;
  final TagTemplate Function(String) tagBuilder;
  final bool readOnly;
  final bool enableBorderStrut;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      padding: enableBorderStrut
        ? const .symmetric(vertical: AppSizes.s8, horizontal: AppSizes.s16)
        : null,
      decoration: enableBorderStrut
        ? BoxDecoration(
          color: Colors.white,
          borderRadius: const .all(.circular(AppSizes.r20)),
          border: .all(width: 1.0, color: AppColors.surface800),
        )
        : null,
      child: ListenableBuilder(
        listenable: controller,
        builder: (_, _) {
          return AnimationLimiter(
            child: Wrap(
              direction: .horizontal,
              spacing: AppSizes.s8,
              runSpacing: AppSizes.s8,
              children: AnimationConfiguration.toStaggeredList(
                childAnimationBuilder: (w) {
                  return ScaleAnimation(
                    duration: const Duration(milliseconds: 400),
                    delay: const Duration(milliseconds: 50),
                    child: w,
                  );
                },
                children: controller.tags.map(tagBuilder).toList(),
              )
            )
          );
        }
      )
    );
  }
}
