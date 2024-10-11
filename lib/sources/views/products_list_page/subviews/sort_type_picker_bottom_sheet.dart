import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../resources/color_asset/colors.dart';
import '../../../model/translation_ko.dart';
import '../../../service/procucts_provider.dart';

class SortTypePickerBottomSheet extends ConsumerStatefulWidget {
	const SortTypePickerBottomSheet({super.key, required this.controller});

  final ScrollController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SortTypePickerBottomSheet();
}

class _SortTypePickerBottomSheet extends ConsumerState<SortTypePickerBottomSheet> {
  FixedExtentScrollController _controller = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    final sortType = ref.watch(sortTypeProvider);
    _controller = FixedExtentScrollController(initialItem: sortType.idx);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).padding.bottom,
      ),
      child: SizedBox(
        height: 330,
        child: Column(
          children: [
            SizedBox(
              height: 250,
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
                children: [0,1,2,3,4].map((e){
                  return Center(
                    child: Text(sortTypeKo[SortType.getByIndex(e).str] ?? SortType.getByIndex(e).str,
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
                onTap: () async{
                  ref.read(sortTypeProvider.notifier).update((state) => SortType.getByIndex(_controller.selectedItem));
                  ref.invalidate(productsRef);
                  // widget.controller.jumpTo(0);
                  Navigator.pop(context);
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