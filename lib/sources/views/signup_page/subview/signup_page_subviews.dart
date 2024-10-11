import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../resources/color_asset/colors.dart';

ThemeData signInFieldTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5))
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 2, color: CsColors.cs.accentColor)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 2, color: CsColors.cs.accentColor)
    ),
    isDense: true,
    contentPadding: EdgeInsets.fromLTRB(21, 20, 20, 12),
  )
);

renderTextFormField({
  required BuildContext context,
	required String label,
	required FormFieldSetter onSaved,
	required FormFieldValidator validator,
  bool isLast = false,
  bool? isHidden,
  Widget? visableSuffixIcon,
  TextInputType keyboardType = TextInputType.text,
  String? placeholder,
  List<TextInputFormatter>? textFormat 
}) {
	return Column(
		crossAxisAlignment: CrossAxisAlignment.start,
		children:[
			Text(label),
      SizedBox(height: 4),
			TextFormField(
				// onSaved: onSaved,
        onChanged: onSaved,
				validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: CsColors.cs.accentColor,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        onFieldSubmitted: (value) {
          if(isLast){
            FocusScope.of(context).unfocus();
          } else{
            FocusScope.of(context).nextFocus();
          }
        },
        obscureText: isHidden ?? false,
        decoration: InputDecoration(
          suffixIcon: visableSuffixIcon,
          suffixIconColor: CsColors.cs.accentColor,
          hintText: placeholder
        ),
        keyboardType: keyboardType,
        inputFormatters: textFormat,
			)
		]
	);
}

class PhoneFormatter extends TextInputFormatter{
  final String sample;
  final String separator;

  PhoneFormatter({
    required this.sample,
    required this.separator
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text. length > 0) {
      if(newValue.text.length > oldValue.text.length){
        if(newValue.text.length > sample.length) return oldValue;
        if(newValue.text.length < sample.length && sample[newValue.text.length - 1] == separator){
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1
            )
          );
        }
      }
    }
    return newValue;
  }
}