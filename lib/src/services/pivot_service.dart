import 'package:firebase_auth/firebase_auth.dart';

class PivotService{





  Future<bool> hasLoginSession() async{
    User? user  = FirebaseAuth.instance.currentUser;

    if(user !=null){
      // Open Home page
    } else {
      //Open login page

    }


    return false;
  }
}