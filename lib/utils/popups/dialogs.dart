import 'package:farm_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class Dialogs{
  information(BuildContext context, String title, String description){
    return  showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),

            content: SingleChildScrollView(
              child: ListBody(

                children: <Widget>[
                  Text(description)
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'))
            ],

          );
        }
    );
  }
  waiting(BuildContext context, String title, String description){
    return  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),

            content: SingleChildScrollView(
              child: ListBody(

                children: <Widget>[
                  Text(description)
                ],
              ),
            ),

          );
        }
    );
  }

  _confirmAction(bool isConfirmed, BuildContext context){
    if(isConfirmed){

    }else{
      print('No');
      Navigator.pop(context);
    }
  }
  confirm(BuildContext context, String title, String description, Function function){
    return  showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),

            content: SingleChildScrollView(
              child: ListBody(

                children: <Widget>[
                  Text(description)
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: (){
                    print('yes');
                    function();
                    Navigator.pop(context);
                  },
                  child: Text('Yes')
              ),
              TextButton(
                  onPressed: (){
                    print('No');
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')
              )
            ],

          );
        }
    );
  }
}