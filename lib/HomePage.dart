import 'dart:async';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'Enums/project_routes_enum.dart';
import 'widgets/CustomGradientImageTextWidget.dart';
import 'widgets/QuotesDesign1.dart';
import 'AdManager/ad_helper.dart';
import 'AdManager/ad_manager.dart';
import 'Singleton/project_manager.dart';

import 'data/Gifs.dart';
import 'data/Images.dart';
import 'data/Messages.dart';
import 'data/Quotes.dart';

import 'utils/pass_data_between_screens.dart';
import 'widgets/AppStoreAppsItemWidget1.dart';
import 'widgets/CustomFeatureCard.dart';
import 'widgets/CustomFullCard.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils/SizeConfig.dart';

import 'MyDrawer.dart';

import 'widgets/CustomBannerWidget.dart';

import 'widgets/DesignerContainer.dart';

// Height = 8.96
// Width = 4.14

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    implements ProjectListener, AdListener {
  String _authStatus = 'Unknown';

  BannerAd? _bannerAd;
  ProjectManager projectManager = ProjectManager.instance;
  AdManager adManager = AdManager.instance;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (_) => initPlugin(),
    );

    projectManager.listener = this;

    adManager.adListener = this;

    projectManager.startApp();

    adManager.loadAdsInAdManager();
    loadBannerAd();
  }
void loadBannerAd() {
  _bannerAd = adManager.loadBannerAd(
    BannerAdListener(
      onAdLoaded: (ad) {
        debugPrint("Banner Ad Loaded");

        setState(() {});
      },
      onAdFailedToLoad: (ad, error) {
        debugPrint("Banner Failed: ${error.message}");
        ad.dispose();
      },
    ),
  );
}

  @override
  void dispose() {
    super.dispose();

    debugPrint("Home Page: Dispose Called");
    projectManager.listener = null;
    adManager.adListener = null;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    setState(() => _authStatus = '$status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      setState(() => _authStatus = '$status');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    debugPrint("UUID: $uuid");
  }

  Future<void> showCustomTrackingDialog(
    BuildContext context,
  ) async => await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text('Dear User'),
      content: Text(
        'We care about your privacy and data security. We keep this app free by showing ads. '
        'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
        'Our partners will collect data and use a unique identifier on your device to show you ads.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Continue', style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "☘️",
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            /*TriColorBackground(
                size: size, color: Colors.orangeAccent, isLeft: true),
            TriColorBackground(
                size: size, color: Colors.orangeAccent, isLeft: false),
            TopNBottomBackground(
                size: size, color: Colors.lightBlue, isTop: true),
            TopNBottomBackground(size: size, color: Colors.brown, isTop: false),*/
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.width(8)),
                    child: Center(
                      child: Text(
                        "🎩Happy Saint Patrick's Day🎩",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),

                  Divider(),

                  // Messages Start
                  Column(
                    children: [
                      DesignerContainer(
                        isLeft: true,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Center(
                            child: Text(
                              "St.Patrick's Day Wishes",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8.0)),
                          child: Row(
                            children: [
                              CustomGradientImageTextWidget(
                                size: size,
                                title: "English",
                                bodyText:
                                    "May the sun shine warm upon\nyour face,and the rain shower\nupon your fields.\nMay God bless you always.\nHappy Saint Patrick's Day!",
                                bottomText: "Tap For More",
                                color1: Colors.pinkAccent,
                                color2: Colors.pink,
                                isleft: true,
                                imageUrl: Gifs.gifsPath[6],
                                ontap: () {
                                  print("English Message Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("1", "1"),
                                  );
                                },
                              ),
                              CustomGradientImageTextWidget(
                                size: size,
                                title: "Irish Blessings & Sayings",
                                bodyText: Messages.funnyData[2],
                                bottomText: "Tap For More",
                                color1: Colors.indigoAccent,
                                color2: Colors.indigo,
                                isleft: true,
                                imageUrl: Gifs.gifsPath[6],
                                ontap: () {
                                  print("Funny Message Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("2", "1"),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Messages End
                  Divider(),

                  // Quotes Start
                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                            "St.Patricks's Day Quotes",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: QuotesDesign1(
                            size: size,
                            color: Colors.yellow,
                            bodyText: Quotes.quotesData[5],
                            footerText: "Tap here to Read Quotes",
                            ontap: () {
                              print("Quotes Clicked");
                              ProjectManager.instance.clickOnButton(
                                ProjectRoutes.quotesList.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quotes End
                  Divider(),

                  //Image Start
                  Column(
                    children: [
                      DesignerContainer(
                        isLeft: false,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "St.Patricks's Day Images",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CustomFeatureCard(
                                  size: size,
                                  imageUrl: Images.imagesPath[0],
                                  ontap: () {},
                                ),
                                CustomFeatureCard(
                                  size: size,
                                  imageUrl: Images.imagesPath[2],
                                  ontap: () {},
                                ),
                                CustomFeatureCard(
                                  size: size,
                                  imageUrl: Images.imagesPath[4],
                                  ontap: () {},
                                ),
                                CustomFeatureCard(
                                  size: size,
                                  imageUrl: Images.imagesPath[5],
                                  ontap: () {},
                                ),
                              ],
                            ),
                            onTap: () {
                              print("Images Clicked");
                              ProjectManager.instance.clickOnButton(
                                ProjectRoutes.imagesList.toString(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Image End
                  Divider(),

                  // Status Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                            "Best Captions",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CustomGradientImageTextWidget(
                                  size: size,
                                  title: "Instagarm Captions",
                                  bodyText:
                                      "Celebrations are more\nimportant that just working\nis what I wanted to remind\nyou on the occasion on\nSt Patrick’s Day.\nHappy St Patrick’s Day.",
                                  bottomText: "Read",
                                  color1: Colors.pinkAccent,
                                  color2: Colors.pink,
                                  isleft: false,
                                  imageUrl: Gifs.gifsPath[6],
                                  ontap: () {
                                    ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.messagesList.toString(),
                                  PassDataBetweenScreens("3", "1"),
                                );
                                  },
                                ),
                                CustomGradientImageTextWidget(
                                  size: size,
                                  title: "Captions for FB",
                                  bodyText:
                                      "St Patrick’s Day reminds us\nthat it is time to take break\nfrom work and enjoy some\nfun time.\nWarm wishes on\nSt Patrick’s Day.",
                                  bottomText: "Read",
                                  color1: Colors.indigoAccent,
                                  color2: Colors.indigo,
                                  isleft: false,
                                  imageUrl: Gifs.gifsPath[6],
                                  ontap: () {
                                    ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.messagesList.toString(),
                                  PassDataBetweenScreens("3", "1"),
                                );
                                  },
                                ),
                                CustomGradientImageTextWidget(
                                  size: size,
                                  title: "Funny Captions",
                                  bodyText:
                                      "What do they call the Irish\njig at McDonalds?\nA Shamrock Shake.",
                                  bottomText: "Read",
                                  color1: Colors.deepPurple,
                                  color2: Colors.deepPurpleAccent,
                                  isleft: false,
                                  imageUrl: Gifs.gifsPath[6],
                                  ontap: () {
                                  ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.messagesList.toString(),
                                  PassDataBetweenScreens("3", "1"),
                                );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Status End
                  Divider(),

                  //Native Ad
                  Divider(),

                  //Gifs Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                            "Send Gifs",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Gifs.gifsPath[5],
                                    ontap: () {},
                                  ),
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Gifs.gifsPath[1],
                                    ontap: () {},
                                  ),

                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Gifs.gifsPath[3],
                                    ontap: () {},
                                  ),
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Gifs.gifsPath[6],
                                    ontap: () {},
                                  ),
                                ],
                              ),
                              onTap: () {
                                print("Gifs Clicked");
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.gifsList.toString(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Gifs End

                  //Divider(),
                  Divider(),

                  // Shayari Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                            "St.Patricks's Day Poems",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: QuotesDesign1(
                            size: size,
                            color: Colors.grey,
                            bodyText:
                                "On St. Patrick's Day\nTreasures to be found,\nAt the end of the rainbow so sound.\nSeveral legends have been told,\nBut the message for you to behold....",
                            footerText: "Tap here to Read Poems",
                            ontap: () {
                              print("Shayari Clicked");
                              ProjectManager.instance.clickOnButton(
                                ProjectRoutes.shayariList.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Shayari End
                  Divider(),

                  // Wish Creator Start
                  Column(
                    children: [
                      DesignerContainer(
                        isLeft: false,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Greeting Card & Meme Maker",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: CustomBannerWidget(
                          size: MediaQuery.of(context).size,
                          imagePath: Gifs.gifsPath[1],
                          buttonText: "Create it",
                          topText: "Greetings & Memes for",
                          middleText: "St.Patricks's Day",
                          bottomText: "Share it With Your Friends",
                          onTap: () {
                            print("Meme Clicked");
                            ProjectManager.instance.clickOnButton(
                              ProjectRoutes.memeGenerator.toString(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  // Wish Creator End
                  Divider(),

                  //Native Ad
                  /*DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                            "Play Game \"Sell Rakhi\"",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        CustomFullCard(
                          size: MediaQuery.of(context).size,
                          imageUrl: "assets/rakhi_game.jpeg",
                          onTap: () {
                            if (Platform.isAndroid) {
                              // Android-specific code
                              print("More Button Clicked");
                              launch(
                                "https://play.google.com/store/apps/developer?id=Festival+Messages+SMS",
                              );
                            } else if (Platform.isIOS) {
                              // iOS-specific code
                              print("More Button Clicked");
                              launch(
                                "https://apps.apple.com/us/app/-/id1434054710",
                              );

                              
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  Divider(),
*/
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.width(8)),
                    child: Text(
                      "Apps From Developer",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Row(
                        children: <Widget>[
                          //Column1
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple117/v4/8f/e7/b5/8fe7b5bc-03eb-808c-2b9e-fc2c12112a45/mzl.jivuavtz.png/292x0w.jpg",
                                appTitle: "Good Morning Images & Messages",
                                appUrl:
                                    "https://apps.apple.com/us/app/good-morning-images-messages-to-wish-greet-gm/id1232993917",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/44/e0/fd/44e0fdb5-667b-5468-7b2f-53638cba539e/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                                appTitle: "Birthday Status Wishes Quotes",
                                appUrl:
                                    "https://apps.apple.com/us/app/birthday-status-wishes-quotes/id1522542709",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/7d/60/69/7d60694e-2e38-9403-80e8-bc3b7c7b5772/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/230x0w.webp",
                                appTitle: "Good Night Gif Image Quote Sm‪s‬",
                                appUrl:
                                    "https://apps.apple.com/us/app/good-night-gif-image-quote-sms/id1527002426",
                              ),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),
                          //Column2
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/e9/96/64/e99664d3-1083-5fac-6a0c-61718ee209fd/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                appTitle: "Weight Loss My Diet Coach Tips",
                                appUrl:
                                    "https://apps.apple.com/us/app/weight-loss-my-diet-coach-tips/id1448343218",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is2-ssl.mzstatic.com/image/thumb/Purple127/v4/5f/7c/45/5f7c45c7-fb75-ea39-feaa-a698b0e4b09e/pr_source.jpg/292x0w.jpg",
                                appTitle: "English Speaking Course Grammar",
                                appUrl:
                                    "https://apps.apple.com/us/app/english-speaking-course-learn-grammar-vocabulary/id1233093288",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/50/ad/82/50ad82d9-0d82-5007-fcdd-cc47c439bfd0/AppIcon-0-1x_U007emarketing-0-85-220-10.png/292x0w.jpg",
                                appTitle: "English Hindi Language Diction",
                                appUrl:
                                    "https://apps.apple.com/us/app/english-hindi-language-diction/id1441243874",
                              ),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),

                          //Column3
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/b6/3d/cd/b63dcde0-b4db-d05b-7025-e879a338049a/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/230x0w.webp",
                                appTitle: "Sorry Forgive Card Status Gif‪s",
                                appUrl:
                                    "https://apps.apple.com/us/app/sorry-forgive-card-status-gifs/id1549696526",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/79/1e/61/791e61de-500c-6c97-3947-8abbc6b887e3/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                appTitle: "Bangladesh Passport Visa Biman",
                                appUrl:
                                    "https://apps.apple.com/us/app/bangladesh-passport-visa-biman/id1443074171",
                              ),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/dd/34/c3/dd34c3e8-5c9f-51aa-a3eb-3a203f5fd49b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-10.png/292x0w.jpg",
                                appTitle: "Complete Spoken English Course",
                                appUrl:
                                    "https://apps.apple.com/us/app/complete-spoken-english-course/id1440118617",
                              ),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),

                          //Column4
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/9a/52/7a/9a527a0e-ca83-ecba-5f1b-336057d7a48b/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/230x0w.webp",
                                appTitle: "Anniversary Wishes Gif Image‪s",
                                appUrl:
                                    "https://apps.apple.com/us/app/anniversary-wishes-gif-images/id1527002955",
                              ),
                              Divider(),

                              AppStoreAppsItemWidget1(
                                imageUrl:
                                    "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/89/1b/44/891b44e5-bbb3-a530-0f97-011c226d79e1/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/230x0w.webp",
                                appTitle: "Thank You Greetings Card Make‪r‬",
                                appUrl:
                                    "https://apps.apple.com/us/app/thank-you-greetings-card-maker/id1552601152",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
       bottomNavigationBar: BottomAppBar(
            child: _bannerAd != null
                ? SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  )
                : Container(),
          ),

      drawer: MyDrawer(),
    );
  }

  @override
  void moveToScreen(String s, [PassDataBetweenScreens? object]) {
    // TODO: implement moveToScreen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      Navigator.of(context).pushNamed(s, arguments: object);
    });
  }

 @override
  void moveToScreenAfterAd(String s, [PassDataBetweenScreens? object]) {
    Navigator.of(context).pushNamed(s, arguments: object);
  }

  @override
  void showAd(String s, [PassDataBetweenScreens? object]) {
    AdManager.instance.showInterstitialAd(s, object);
  }
}
