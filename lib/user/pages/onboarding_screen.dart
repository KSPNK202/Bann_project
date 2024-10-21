import 'package:baan_app/user/pages/login.dart';
import 'package:baan_app/user/pages/onboarding_entity.dart';
import 'package:baan_app/user/theme/style.dart';
import 'package:baan_app/widget/button_container_widget.dart';
import 'package:baan_app/widget/widget_support.dart';
import 'package:flutter/material.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingEntity> onBoardingData = OnBoardingEntity.onBoardingData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: onBoardingData.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  Image.asset("images/Cafe&Restaurant_2.png"),
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset("images/${onBoardingData[index].image}"),
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    "${onBoardingData[index].title}",
                    textAlign: TextAlign.center,
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("${onBoardingData[index].description}",
                      textAlign: TextAlign.center,
                      style: AppWidget.ligthtextTextFeildStyle()),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color:
                                index == 0 ? primaryColorED6E1B : Colors.grey,
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color:
                                index == 1 ? primaryColorED6E1B : Colors.grey,
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color:
                                index == 2 ? primaryColorED6E1B : Colors.grey,
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  index == 2
                      ? Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 100.0),
                          child: ButtonContainerWidget(
                            title: "เริ่มต้นใช้งาน",
                            hasIcon: true,
                            icon: Icons.arrow_forward_ios,
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogIn()),
                                (route) => false,
                              );
                            },
                            style: const TextStyle(
                              fontFamily:'Kanit',
                              fontSize: 18.0,
                              fontWeight:FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          }),
    );
  }
}
