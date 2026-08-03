import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

import 'tag_container.dart';
import 'tag_template.dart';

class TagListController extends ChangeNotifier {
  TagListController({
    List<String>? selectedTags,
    this.tagLimit = 10,
    required this._categories,
  })
  : _selectedTags = selectedTags == null
    ? HashSet<String>()
    : HashSet.from(selectedTags);

  final int tagLimit;
  final List<(String, List<String>)> _categories;
  final HashSet<String> _selectedTags;
  int _selectedCategory = 0;
  String get selectedCategory => _categories[_selectedCategory].$1;
  List<String> get selectedTags => _categories[_selectedCategory].$2;

  void enable(String tag) {
    if (_selectedTags.length >= tagLimit) return;
    _selectedTags.add(tag);
    notifyListeners();
  }

  void disable(String tag) {
    _selectedTags.remove(tag);
    notifyListeners();
  }

  void switchCategory(String category) {
    final index = _categories.indexWhere((c) => c.$1 == category);
    if (index == -1) return;
    _selectedCategory = index;
    notifyListeners();
  }
}

class TagList extends StatefulHookWidget {
  const TagList({
    super.key,
    this.onTagEnabled,
    this.onTagDisabled,
    required this.controller,
  });

  final TagListController controller;
  final void Function(String)? onTagEnabled;
  final void Function(String)? onTagDisabled;

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  late final TagContainerController tagContainer;

  @override
  void initState() {
    super.initState();
    tagContainer = TagContainerController(
      tags: widget.controller._categories[widget.controller._selectedCategory].$2
    );
  }

  @override
  void dispose() {
    tagContainer.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final selectedCategory = controller._selectedCategory;
    final categories = controller._categories;
    final selectedTags = controller._selectedTags;
    useListenable(widget.controller);

    return Column(
      children: [
        SizedBox(
          height: AppSizes.s32,
          child: ListView.builder(
            scrollDirection: .horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (_, index) {
              return Stack(
                children: [
                  _CategoryButton(
                    label: categories[index].$1,
                    toggle: index == selectedCategory,
                    onToggle: (c) {
                      if (c == controller.selectedCategory) return;
                      controller.switchCategory(c);
                      tagContainer.setTags(controller.selectedTags);
                    }
                  ),

                  if (selectedCategory == index)
                  Positioned(
                    right: 0.0,
                    top: 0.0,
                    child: _CountIcon(
                      count: categories[index].$2.length
                    )
                  )
                ]
              );
            },
          ),
        ),
        TagContainer(
          key: ValueKey('tag_container_$selectedCategory'),
          controller: tagContainer,
          enableBorderStrut: false,
          tagBuilder: (label) => TagTemplate(
            label: label,
            removeable: false,
            toggle: selectedTags.contains(label),
            onToggle: (toggle) {
              if (toggle) {
                controller.enable(label);
                if (widget.onTagEnabled != null) {
                  widget.onTagEnabled!(label);
                }
              }
              else {
                controller.disable(label);
                if (widget.onTagDisabled != null) {
                  widget.onTagDisabled!(label);
                }
              }
            }
          )
        )
      ]
    );
  }
}

class _CountIcon extends HookWidget {
  const _CountIcon({
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );
    
    useEffect(() {
      animation.forward();
      return null;
    }, const []);

    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.bounceOut,
      ),
      child: Container(
        height: AppSizes.s16,
        width: AppSizes.s16,
        decoration: BoxDecoration(
          borderRadius: const .all(.circular(AppSizes.s8)),
          color: AppColors.primary100,
        ),
        child: Center(
          child: Text(
            '$count',
            style: AppTypography.overline.copyWith(
              color: AppColors.textPrimary500,
            )
          )
        )
      )
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    required this.label,
    required this.onToggle,
    this.toggle = false,
  });

  final String label;
  final ValueChanged<String> onToggle;
  final bool toggle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () { onToggle(label); },
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Stack(
          key: ValueKey('${label}_${toggle}'),
          children: [
            Text(
              label,
              style: AppTypography.button.copyWith(
                color: toggle ? AppColors.primary500 : Colors.black
              ),
            ),
          ]
        )
      ),
    );
  }
}
