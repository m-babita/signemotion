import 'package:flutter/material.dart';

class CustomizedBtn extends StatelessWidget {
  final String? btnTxt;
  final Color? btnColor;
  final Color? txtColor;
  final VoidCallback? onPressed;

  const CustomizedBtn(
      {Key? key, this.btnTxt, this.btnColor, this.onPressed, this.txtColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: btnColor,
            border: Border.all(width: 1, color: Colors.purple),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              btnTxt!,
              style: TextStyle(
                fontSize: 20,
                color: txtColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
