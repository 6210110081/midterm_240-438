import 'package:flutter/cupertino.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('นายซอฟรอน  กูวะ')),
        SizedBox(
          height: 20,
        ),
        Center(child: Text('6210110081')),
      ],
    ));
  }
}
