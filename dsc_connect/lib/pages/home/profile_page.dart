import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [

            const ProfilePic(),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "User Name",
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            const Text(
              "Phone Number",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
            ),



            LogOutButton()



          ],
        ),
      ),
    );
  }

}

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key? key}) : super(key: key);

  editProfile(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Implementation pending"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 100,
        height: 125,
        child: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFFE7E9EC),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    "assets/images/user.png",
                  )
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          editProfile(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(
                                side: BorderSide(color: Color(0xFF06313F), width: 4)
                            ),
                            minimumSize: const Size(50, 50)
                        ),
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              )
            ]
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF06313f)
      ),
      child: Row(
        children: const [
          Icon(Icons.arrow_back, color: Colors.white,),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0,0,0,0),
            child: Text(
              "Log Out",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}


