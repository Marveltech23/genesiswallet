import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class CustomTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLength;

  const CustomTextField({
    Key? key,
    required this.onChanged,
    required this.keyboardType,
    this.obscureText = false,
    this.maxLength = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Msizes.borderRadiusSm),
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: MColors.subprimaryColor,
          prefixIconColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Msizes.borderRadiusSm),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        obscureText: obscureText,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
          if (keyboardType == TextInputType.number)
            FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
