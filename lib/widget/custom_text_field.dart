import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text, 
    this.isPassword=false, 
    this.maxLines=1, 
    this.border=const OutlineInputBorder(), 
    this.controller, 
    this.maxLength, this.isError=false,
  });
  final bool isError;
  final String text;
  final bool isPassword;
  final int? maxLines ;
  final int? maxLength ;
  final InputBorder? border;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(1, 1),
            color: Colors.grey.withOpacity(0.1)
          )
        ]
      ),
      child: TextField(
        controller: controller,
        // keyboardType: TextInputType.emailAddress,//kalvyenin mail tipinde açılmasını sağlar
        autofocus: true,
        
        maxLines: maxLines,
        maxLength: maxLength,
        // autofillHints: [AutofillHints.email],//ne ile tamamlanacağını belirler
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: text,
          
          // labelText: text,
          border: border,
          counterText: "",
        ),
      ),
    );
  }
}