import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/products.dart';
import '../../../model/translation_ko.dart';
import '../../../model/arguments/product_info_arguments.dart';
import '../../../service/procucts_provider.dart';

class RecommendsListTile extends ConsumerWidget {
	const RecommendsListTile({
    super.key,
    required this.category,
    required this.products,
    required this.imgLength
  });

  final String category;
  final List<Product> products;
  final double imgLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ListTile(
      title: Text(CategoryKo[category] ?? category,
        style: GoogleFonts.notoSans(
          color: Colors.black
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: 
        [
          previewMiniProduct(context: context, imgLength: imgLength, product: products[0]),
          previewMiniProduct(context: context, imgLength: imgLength, product: products[1]),
          previewMiniProduct(context: context, imgLength: imgLength, product: products[2]),
          GestureDetector(
            onTap: (){
              ref.read(sortTypeProvider.notifier).update((state) => SortType.recent);
              ref.read(searchTextProvider.notifier).update((state) => "");
              ref.read(selectedCategoryProvider.notifier).update((state) => category);
              Navigator.pushNamed(context, '/productsList');
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey
                    ),
                    width: imgLength - 20, height: imgLength - 20,
                    child: Icon(Icons.add, color: Colors.black,)
                  ),
                ),
                Text("더 보기\n\n",
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: Colors.black
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}


Widget previewMiniProduct({
  required BuildContext context,
  required Product product,
  required double imgLength
}){
  return Container(
    width: imgLength,
    child: GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/product',
        arguments: ProductInfoArguments(product)
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: imgLength - 20, height: imgLength - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1),
                  )
                ]
              ),
              child: Image.network(product.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(product.title,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: Colors.black
            ),
          ),
          Text("\$${product.price}",
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: Colors.black
            ),
          ),
          Text("⭐️ ${product.rating.rate} / 🛒 ${product.rating.count}",
            style: GoogleFonts.notoSans(
              fontSize: 10
            ),
          ),
        ],
      ),
    ),
  );
}
