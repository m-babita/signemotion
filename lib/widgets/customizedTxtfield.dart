import 'package:flutter/material.dart';

class CustomizedTextfield extends StatelessWidget {
  final TextEditingController myController;
  final String? hintText;
  final bool? isPass;
  const CustomizedTextfield(
      {Key? key, required this.myController, this.hintText, this.isPass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: TextField(
          keyboardType: isPass!
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress,
          enableSuggestions: isPass! ? false : true,
          autocorrect: isPass! ? false : true,
          obscureText: isPass ?? true,
          controller: myController,
          decoration: InputDecoration(
            suffixIcon: isPass!
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove_red_eye),
                    color: Colors.purple[400],
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.purple, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.purple[50],
            filled: true,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ));
  }
}
