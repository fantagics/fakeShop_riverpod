import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../resources/color_asset/colors.dart';
import '../../../model/translation_ko.dart';
import '../../../service/procucts_provider.dart';

class CategoryPickerBottomSheet extends ConsumerStatefulWidget {
	const CategoryPickerBottomSheet({super.key, required this.controller});

  final ScrollController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryPickerBottomSheet();
}

class _CategoryPickerBottomSheet extends ConsumerState<CategoryPickerBottomSheet> {
  FixedExtentScrollController _controller = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    final selected = ref.watch(selectedCategoryProvider);
    List<String> allCategory = ['all']..addAll(categories);
    int initalIdx = allCategory.indexWhere((element) => element == selected);
    _controller = FixedExtentScrollController(initialItem: initalIdx == -1 ? 0 : initalIdx);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).padding.bottom
      ),
      child: SizedBox(
        height: (MediaQuery.of(context).size.height * 2 / 7) + 34 + 8 + 8 + 42,
        child: Column(
          children: [
            Text('카테고리',
              style: GoogleFonts.notoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 7,
              child: CupertinoPicker(
                selectionOverlay: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CsColors.cs.accentColor.withOpacity(0.2)
                    ),
                  ),
                ),
                scrollController: _controller,
                itemExtent: 50,
                onSelectedItemChanged: (idx){},
                children: allCategory.map((e){
                  return Center(
                    child: Text( CategoryKo[e] ?? e,
                      style: GoogleFonts.notoSans(
                        fontSize: 20,
                        color: CsColors.cs.darkAccentColor
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 42,
              child: GestureDetector(
                onTap: (){
                  ref.read(sortTypeProvider.notifier).update((state) => SortType.recent); //선택
                  ref.read(selectedCategoryProvider.notifier).update((state) => allCategory[_controller.selectedItem]);
                  ref.invalidate(productsRef);
                  Navigator.pop(context);
                  // widget.controller.jumpTo(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CsColors.cs.accentColor,
                  ),
                  child: Center(
                    child: Text('적용하기',
                      style: GoogleFonts.notoSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}