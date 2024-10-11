import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../resources/color_asset/colors.dart';
import '../../model/translation_ko.dart';
import '../../model/products.dart';
import '../../model/arguments/product_info_arguments.dart';
import 'subviews/category_picker_bottom_sheet.dart';
import 'subviews/sort_type_picker_bottom_sheet.dart';
import '../subviews/circle_progress_indicator_widget.dart';
import '../../service/procucts_provider.dart';

class ProductsListPage extends ConsumerStatefulWidget {
	const ProductsListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsListPage();
}

class _ProductsListPage extends ConsumerState<ProductsListPage> {
  late ScrollController _controller;
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(nextLoad);
  }

  @override
  Widget build(BuildContext context) {
    const double cellAxisSpace = 16;
    final double cellWidth = (MediaQuery.of(context).size.width - (cellAxisSpace * 3)) / 2;
    final double cellHeight = cellWidth + 85;
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final getProductsList = ref.watch(productsRef);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CsColors.cs.accentColor,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: GestureDetector(
          onTap: (){
            showModalBottomSheet(context: context, 
              builder: (context) {
                return CategoryPickerBottomSheet(controller: _controller);
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1.4,
                color: Colors.white
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 3),
              child: Text("${CategoryKo[selectedCategory] ?? selectedCategory} ▾",
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.0,
                )
              ),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.cart, color: Colors.white,),
            onPressed: (){
            }
          ),
          SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 56),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(width: 8),
                Expanded(child: TextField(
                  controller: _textController,
                  onSubmitted: (v){
                    ref.read(searchTextProvider.notifier).update((state) => v);
                    ref.invalidate(productsRef);
                    // _controller.jumpTo(0);
                  },
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    filled: true, fillColor: Colors.white,
                    hintText: "제품명을 검색하세요.",
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 8),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: _textController.clear,
                    ),
                  ),
                  cursorColor: CsColors.cs.accentColor,
                )),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    ref.read(searchTextProvider.notifier).update((state) => _textController.text);
                    ref.invalidate(productsRef);
                    // _controller.jumpTo(0);
                  },
                  child: circleAppBarButton(
                    child: Icon(Icons.search, color: CsColors.cs.accentColor,)
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(context: context, 
                      builder: (context) {
                        return SortTypePickerBottomSheet(controller: _controller);
                      },
                    );
                  },
                  child: circleAppBarButton(
                    child: Icon(CupertinoIcons.line_horizontal_3_decrease, color: CsColors.cs.accentColor,)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          ref.invalidate(productsRef);
          // _controller.jumpTo(0);
        },
        child: getProductsList.when(
          data: (data) {
            return Padding(
              padding: EdgeInsets.all(cellAxisSpace),
              // height: ((cellHeight + cellAxisSpace) * ((showProducts.length + 1) / 2)) + 60,
              child: GridView.builder(
                controller: _controller,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: cellAxisSpace,
                  crossAxisSpacing: cellAxisSpace,
                  crossAxisCount: 2,
                  childAspectRatio: cellWidth / cellHeight,
                ), 
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Product product = data[index];
                  return Padding(
                    padding: EdgeInsets.all(1),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/product',
                          arguments: ProductInfoArguments(product)
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 0)
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: cellWidth - 8 - 2, height: cellWidth - 8 - 2,
                              child: Image.network(product.image, fit: BoxFit.contain,),
                            ),
                    
                            SizedBox(height: 4),
                            Text(product.title,
                              style: GoogleFonts.notoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Expanded(child: Container()),
                                Text("⭐️ ${product.rating.rate} / 🛒 ${product.rating.count}",
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Container()),
                                Text("\$ ${product.price}",
                                  style: GoogleFonts.notoSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                  );
                },
              ),
            );
          },
          error: (error, stackTrace){
            print('ERROR : ${error} \n${stackTrace}');
            return Container();
          },
          loading: () => CircleProgerssIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(nextLoad);
    super.dispose();
  }


  void nextLoad() async{
    final received = ref.watch(recProducts);
    //controller.position.extentAfter 스크롤 남은 영역 크기
    if(_controller.position.extentAfter < 50 && 8 < received.length){
      print("pagination!");
    }
  }
}

circleAppBarButton({required Widget child}){
  return Container(
    width: 36, height: 36,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: CsColors.cs.darkAccentColor.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(1, 1)
          )
        ],
    ),
    child: child,
  );
}
