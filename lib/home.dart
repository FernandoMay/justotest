import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justotest/constants.dart';
import 'package:justotest/services.dart';
import 'package:provider/provider.dart';

enum Info { name, mail, birth, location, phone, pass }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Info _selectedSegment = Info.name;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false);
    user.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserProvider>(context);
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            leading: Icon(CupertinoIcons.person_2),
            largeTitle: Text('RandomUser', style: justoH3Blue),
            // trailing:
            //  CupertinoButton(onPressed: () {  },
            //  child: Icon(CupertinoIcons.add_circled)),
          ),
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(28.0),
                  child: CircleAvatar(
                    radius: 52,
                    backgroundColor: secondaryColor,
                    child: Center(
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: lightColor,
                        backgroundImage: NetworkImage(
                            data.user.results.first.picture.medium,
                            scale: 1),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 2.0),
                  child: CupertinoSlidingSegmentedControl<Info>(
                    backgroundColor: bgLightColor,
                    thumbColor: lightColor,
                    groupValue: _selectedSegment,
                    onValueChanged: (Info? value) {
                      if (value != null) {
                        setState(() {
                          _selectedSegment = value;
                        });
                      }
                    },
                    children: const <Info, Widget>{
                      Info.name: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(CupertinoIcons.person)),
                      Info.mail: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(CupertinoIcons.mail)),
                      Info.birth: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(CupertinoIcons.calendar)),
                      Info.location: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(CupertinoIcons.location)),
                      Info.phone: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(CupertinoIcons.phone)),
                      Info.pass: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(CupertinoIcons.lock)),
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 12.0),
                          child: Text(
                            _selectedSegment.displayTitle,
                            style: justoH2White,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 12.0),
                          child: Text(
                            () {
                              switch (_selectedSegment) {
                                case Info.name:
                                  return '${data.user.results.first.name.title}. ${data.user.results.first.name.first} ${data.user.results.first.name.last}';
                                case Info.mail:
                                  return data.user.results.first.email;
                                case Info.birth:
                                  return '${data.user.results.first.dob.date.day}/${data.user.results.first.dob.date.month}/${data.user.results.first.dob.date.year} \( I\'m ${data.user.results.first.dob.age} \)';
                                case Info.location:
                                  return '${data.user.results.first.location.street.number} ${data.user.results.first.location.street.name}';
                                case Info.phone:
                                  return data.user.results.first.phone;
                                case Info.pass:
                                  return data.user.results.first.login.password;
                                default:
                                  return data.user.results.first.gender;
                              }
                            }(),
                            style: justoH3Black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension InfoExtension on Info {
  String get displayTitle {
    switch (this) {
      case Info.name:
        return 'Hi, My name is';
      case Info.mail:
        return 'My email address is';
      case Info.birth:
        return 'My birthday is';
      case Info.location:
        return 'My address is';
      case Info.phone:
        return 'My phone number is';
      case Info.pass:
        return 'My password is';
      default:
        return 'My gender is';
    }
  }
}
