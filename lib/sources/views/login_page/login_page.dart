import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/auth_provider.dart';
import 'subview/login_labels.dart';
import 'subview/login_form.dart';
import '../subviews/circle_progress_indicator_widget.dart';


class LogInPage extends ConsumerStatefulWidget{
  const LogInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInPage();
}

class _LogInPage extends ConsumerState<LogInPage>{
  TextEditingController idTextFieldControl = TextEditingController();
  TextEditingController pwTextFieldControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(authLoading);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              onTap: (){ FocusScope.of(context).unfocus(); },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: (MediaQuery.of(context).size.height / 2) - 157 - MediaQuery.of(context).padding.top,
                        child: Center(
                          child:  SizedBox(
                            width: double.infinity,
                            child: welcomeTitle(),
                          )
                        ),
                      ),
                      SizedBox(height: 6),
                      loginForm(context, ref, idTextFieldControl, pwTextFieldControl),
                      SizedBox(height: (MediaQuery.of(context).size.height / 2) - 250 - MediaQuery.of(context).padding.bottom)
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading ? CircleProgerssIndicator() : Container(),
        ],
      )
    );
  }
}