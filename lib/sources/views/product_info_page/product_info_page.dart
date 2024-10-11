import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/color_asset/colors.dart';
import '../../model/translation_ko.dart';
import 'subview/product_count_bottom_sheet.dart';
import '../../model/arguments/product_info_arguments.dart';

class ProductInfoPage extends StatefulWidget {
  const ProductInfoPage({super.key});

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  @override
  Widget build(BuildContext context) {
    final ProductInfoArguments args = ModalRoute.of(context)?.settings.arguments as ProductInfoArguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CsColors.cs.accentColor,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 9 / 16,
              child: Image.network(args.product.image,
                fit: BoxFit.contain,
              ),
            ),
            // Container(width: double.infinity, height: 1, color: CsColors.cs.accentColor),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(CategoryKo[args.product.category] ?? args.product.category,
                    style: GoogleFonts.notoSans(
                      fontSize: 10,
                      color: Colors.grey
                    ),
                  ),
                  Text(args.product.title,
                    style: GoogleFonts.notoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.star, size: 16, color: args.product.rating.rate.round()>0 ? CsColors.cs.accentColor : Colors.grey,),
                      Icon(Icons.star, size: 16, color: args.product.rating.rate.round()>1 ? CsColors.cs.accentColor : Colors.grey,),
                      Icon(Icons.star, size: 16, color: args.product.rating.rate.round()>2 ? CsColors.cs.accentColor : Colors.grey,),
                      Icon(Icons.star, size: 16, color: args.product.rating.rate.round()>3 ? CsColors.cs.accentColor : Colors.grey,),
                      Icon(Icons.star, size: 16, color: args.product.rating.rate.round()>4 ? CsColors.cs.accentColor : Colors.grey,),
                      Text(' (${args.product.rating.count})',
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: Colors.grey[700]
                        ),
                      )
                    ],
                  ),
                  Text('\$ ${args.product.price}',
                    style: GoogleFonts.notoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Container(width: double.infinity, height: 1, color: CsColors.cs.darkAccentColor),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(args.product.description,
                style: GoogleFonts.notoSans(
                  fontSize: 18,
                  color: CsColors.cs.darkAccentColor
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CsColors.cs.accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          )
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (context) {
                    return ProductCountBottomSheet(product: args.product, isBuyOnly: true);
                  });
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width / 2) - 32,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1,1),
                      )
                    ],
                    color: Colors.white
                  ),
                  child: Center(
                    child: Text('구매하기',
                      style: GoogleFonts.notoSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: CsColors.cs.darkAccentColor
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 24 ),
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (context) {
                    return ProductCountBottomSheet(product: args.product, isBuyOnly: false);
                  });
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width / 2) - 32,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1,1),
                      )
                    ],
                    color: Colors.white
                  ),
                  child: Center(
                    child: Text('장바구니',
                      style: GoogleFonts.notoSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: CsColors.cs.darkAccentColor
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
