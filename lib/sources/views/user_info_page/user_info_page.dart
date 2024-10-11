import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../subviews/app_dialoges.dart';

class UserInfoPage extends ConsumerWidget {
	const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    double imgLength = MediaQuery.of(context).size.width / 6;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: imgLength, height: imgLength,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(imgLength/2),
                            color: Colors.grey
                          ),
                          child: Icon(Icons.person, color: Colors.white, size: imgLength - 30),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("USERNAME 님", style: GoogleFonts.notoSans(
                              fontSize: 18
                            )),
                            SizedBox(height: 6,),
                            Text("email@gmail.com", style: GoogleFonts.notoSans(
                              fontSize: 12
                            ))
                          ],
                        ),
                        Expanded(child: Container()),
                        Icon(Icons.chevron_right, color: Colors.grey,),
                      ],),
                    ],
                  ),
                ),
              ),
              onTap: (){},
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.list),
                title: Text("주문내역", style: GoogleFonts.notoSans(
                  fontSize: 16
                )),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(CupertinoIcons.cart),
                title: Text("장바구니", style: GoogleFonts.notoSans(
                  fontSize: 16
                )),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("문의내역", style: GoogleFonts.notoSans(
                  fontSize: 16
                )),
              ),
            ),
            GestureDetector(
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("로그아웃", style: GoogleFonts.notoSans(
                    fontSize: 16
                  )),
                ),
              ),
              onTap: (){
                logoutDialog(context: context, ref: ref);
              }
            ),
          ],
        ),
      )
    );
  }
}