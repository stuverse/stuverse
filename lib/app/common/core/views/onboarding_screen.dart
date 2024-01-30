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
                bottom: 100,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      textStyle: context.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      context.go(CommonRoutes.signin);
                    },
                    child: const Center(
                      child: Text(
                        'GET STARTED',
                      ),
                    ),
                  ),
                ),
              )
            else
              Container(
                alignment: Alignment(0, 0.75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(3);
                      },
                      child: Text(
                        'SKIP',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SmoothPageIndicator(controller: _pageController, count: 4),
                    GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        'NEXT',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
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
