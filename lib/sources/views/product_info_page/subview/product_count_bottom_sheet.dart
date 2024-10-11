import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/products.dart';
import '../../../../resources/color_asset/colors.dart';


class ProductCountBottomSheet extends StatefulWidget {
  final Product product;
  final bool isBuyOnly; //true: 바로구매 / false: 장바구니

  const ProductCountBottomSheet({super.key,
    required this.product,
    required this.isBuyOnly
  });

  @override
  State<ProductCountBottomSheet> createState() => _ProductCountBottomSheetState();
}

class _ProductCountBottomSheetState extends State<ProductCountBottomSheet> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).padding.bottom,
        horizontal: 20
      ),
      child: SizedBox(
        height: 181,
        child: Column(
          children: [
            Text(widget.product.title,
              style: GoogleFonts.notoSans(
                fontSize: 20,
                fontWeight:FontWeight.bold
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Container()),
                Text("\$ ${widget.product.price * count} ",
                  style: GoogleFonts.notoSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CsColors.cs.accentColor
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CsColors.cs.accentColor,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white, size: 24,),
                        onPressed: (){
                          if(count>1){
                            setState(() {
                              count -= 1;
                            });
                          }
                        },
                      ),
                      Container(
                        width: 60, height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Center(
                          child: Text('${count}',
                            style: GoogleFonts.notoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CsColors.cs.darkAccentColor
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white, size: 24,),
                        onPressed: (){
                          setState(() {
                            count += 1;
                          });
                        },
                      )
                    ],
                  ),
                ),// -1+
              ],
            ),
            SizedBox(height: 16),
             GestureDetector(
              onTap:(){},
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CsColors.cs.accentColor,
                ),
                child: Center(
                  child: Text(widget.isBuyOnly ? '구매하기' : '장바구니',
                      style: GoogleFonts.notoSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Colors.white
                      ),
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}