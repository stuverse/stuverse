import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
                    img: AppImages.forumOnboarding,
                    title: 'Stuverse: Your Academic Universe',
                    description:
                        'Embark on a journey where students, alumni, and opportunities unite. Redefine your academic experience in a vibrant, limitless community.'),
                BoardingCard(
                    img: AppImages.mentorshipOnboarding,
                    title: 'Mentorship Beyond Boundaries',
                    description:
                        'Forge connections with experienced mentors. Gain valuable insights and shape your academic path beyond boundaries. Connect, learn, and thrive.'),
                BoardingCard(
                  img: AppImages.jobPostingOnboarding,
                  title: 'Unlock Your Career Potential',
                  description:
                      'Unlock job and internship postings that bridge academia and industry. Your pathway to success starts here. Explore, apply, and advance your career.',
                ),
                BoardingCard(
                  img: AppImages.fundraisingOnboarding,
                  title: 'Innovate, Captivate, Fundraise',
                  description:
                      'Request funds for your needs, events, or charity. Transparent fundraising processes, top contributors recognized. Innovate, captivate, and make a difference.',
                ),
              ],
            ),
            if (onLastPage)
              Positioned(
                bottom: context.height * 0.06,
                left: 0,
                right: 0,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    textStyle: context.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.go(CommonRoutes.signin);
                  },
                  child: Text(
                    'GET STARTED',
                  ).toCenter(),
                ).paddingSymmetric(horizontal: 70),
              ).animate().shake()
            else
              Container(
                alignment: Alignment(0, 0.85),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
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
                          activeDotColor:
                              context.colorScheme.secondaryContainer,
                          dotColor: context.colorScheme.primary,
                        )),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Text('NEXT', style: context.bodyLarge).bold(),
                    ),
                  ].animate(interval: 100.ms).slide(
                        begin: Offset(0, 5),
                        end: Offset(0, 0),
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
