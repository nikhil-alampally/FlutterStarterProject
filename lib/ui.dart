import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget customTextField(
    {TextEditingController? controller,
    String? labelText,
    String? errorText,
    String? hintText,
    int? maxLength,
    int maxLines = 1,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.name,
    TextInputAction textInputAction = TextInputAction.next,
    IconButton? prefixIcon,
    IconButton? suffixIcon,
    List<TextInputFormatter> inputFormatters = const [],
    Function(String)? onChanged,
    Function(String)? onSubmitted}) {
  return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelText!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              // Adding space between title and TextField
              TextField(
                obscureText: obscureText,
                controller: controller,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    errorText: errorText,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon),
                maxLength: maxLength,
                maxLines: maxLines,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
              ),
            ],
          ),
        ],
      ));
}

Widget customButton(VoidCallback? onPressed, Widget? child) {
  return Container(
      height: 55.0,
      decoration: BoxDecoration(
          color: const Color(0xff0050b4), borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: child,
      ));
}

Widget socialButtonCircle({ Function? onTap,required String assetName}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Container(width: 40,height: 40,child:Image(image: AssetImage(assetName)) ,) //
  );
}
