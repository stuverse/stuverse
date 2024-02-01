import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stuverse/app/app.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradient(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 3);
                });
              },
              children: const [
                BoardingCard(
                    img: AppImages.forum,
                    title: 'Stuverse: Your Academic Universe',
                    description:
                        'Embark on a journey where students, alumni, and opportunities unite. Redefine your academic experience in a vibrant, limitless community.'),
                BoardingCard(
                    img: AppImages.mentorship,
                    title: 'Mentorship Beyond Boundaries',
                    description:
                        'Forge connections with experienced mentors. Gain valuable insights and shape your academic path beyond boundaries. Connect, learn, and thrive.'),
                BoardingCard(
                  img: AppImages.jobPosting,
                  title: 'Unlock Your Career Potential',
                  description:
                      'Unlock job and internship postings that bridge academia and industry. Your pathway to success starts here. Explore, apply, and advance your career.',
                ),
                BoardingCard(
                  img: AppImages.fundraising,
                  title: 'Innovate, Captivate, Fundraise',
                  description:
                      'Request funds for your needs, events, or charity. Transparent fundraising processes, top contributors recognized. Innovate, captivate, and make a difference.',
                ),
              ],
            ),
            if (onLastPage)
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    textStyle: context.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    context.go(CommonRoutes.signin);
                  },
                  child: Text(
                    'GET STARTED',
                  ).toCenter(),
                ).paddingSymmetric(horizontal: 70),
              )
            else
              Container(
                alignment: Alignment(0, 0.85),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(3);
                      },
                      child: Text('SKIP', style: context.bodyLarge).bold(),
                    ),
                    SmoothPageIndicator(
                        controller: _pageController,
                        count: 4,
                        effect: JumpingDotEffect(
                          dotHeight: 12,
                          dotWidth: 12,
                          verticalOffset: 5,
                          jumpScale: 2,
                          activeDotColor: context.colorScheme.secondary,
                          dotColor: context.colorScheme.primary,
                        )),
                    GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Text('NEXT', style: context.bodyLarge).bold(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
