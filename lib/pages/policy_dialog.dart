import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyDialog extends StatelessWidget {
   PolicyDialog({
    Key? key,  
    this.radius=8, 
    required this.mdFileName
    }):assert(mdFileName.contains(".md"),"The file must contain the .md extension")
    ,super(key: key);
  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius),bottomRight: Radius.circular(radius))),
      child: Column(
        children:  [
          Expanded(child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 158)).then((value) {
              return rootBundle.loadString("assets/$mdFileName");
            }),
            builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Markdown(data: snapshot.data.toString(),);
            }
            return Center(child: CircularProgressIndicator() ,);
          },),),
          Padding(
            padding: EdgeInsets.all(8.0),            
            child: Container(
              alignment: Alignment.center,
              height: 58,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: TextButton(
                  onPressed: () { Navigator.of(context).pop(); },
                  child: Text('Close',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                  
                ),
            ),
          ),
        )
        ],
      ),
    );
  }
}