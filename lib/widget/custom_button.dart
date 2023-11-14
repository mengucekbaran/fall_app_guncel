import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.title, this.onPressed, this.color=const Color.fromARGB(255, 25, 187, 251),this.textColor=Colors.white, this.verPadding, this.horPadding,
  });
  final String title;
  final Color color;
  final Color textColor;
  final double? verPadding;
  final double? horPadding;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:ButtonStyle(                    
                      backgroundColor: MaterialStateProperty.all(color),
                      
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))
                    ), 
                    child: Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 5),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: verPadding ?? 0,horizontal: horPadding ?? 0),
        child: Text(title,style: TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          color: textColor,
          ),),
      ),
    ));
  }
}
// ElevatedButton(style: ButtonStyle(                    
//                       backgroundColor: MaterialStateProperty.all(ColorApp.appBarColor),
//                       shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ))
//                     ),
                    
//                     onPressed: (){}, 
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 5),
//                       child: Text("Düzenle"),
//                     ))