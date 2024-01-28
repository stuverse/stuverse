import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stuverse/app/utils/app_images.dart';
import 'package:stuverse/features/common/core/core.dart';
import 'package:stuverse/features/common/core/widgets/boarding_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = '/onBoarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController=PageController();
  bool onLastPage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradient(child: Stack(
        children: [PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 3);
            });
          },
          children: [
            BoardingPage(
              img: AppImages.forum,
              title:'Stuverse: Your Academic Universe' ,
              description:'Embark on a journey where students, alumni, and opportunities unite. Redefine your academic experience in a vibrant, limitless community.'),
            BoardingPage(
              img: AppImages.mentorship,
              title: 'Mentorship Beyond Boundaries',
              description: 'Connect with experienced mentors, seek valuable insights, and sculpt your academic path with guidance that transcends boundaries.'
            ),
            BoardingPage(
              img: AppImages.jobPosting,
              title: 'Unlock Your Career Potential',
              description: 'Explore job and internship postings, connecting academia with industry. Your path to success starts here.',
            ),
            BoardingPage(
              img: AppImages.fundraising,
              title: 'Innovate, Captivate, Fundraise', 
            description:'Request funds for your needs, events, or charity.Transparent fundraising, top contributors recognized.')
          ],
        ),
        onLastPage ?
         Positioned(
           bottom: 100,
           left: 0,
           right: 0,
           child:  Padding(
             padding: const EdgeInsets.symmetric(
               horizontal: 70
             ),
             child: FilledButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'GET STARTED',
                          style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontWeight: FontWeight.bold
                                ),
                        ),
                      ),
                    ),
           ),
         )
          :Container(
          alignment: Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  _pageController.jumpToPage(3);
                },
                child: Text('SKIP',
                style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold
                              ),
                ),
              ),
              SmoothPageIndicator(controller: _pageController, count: 4),    
              GestureDetector(
                onTap: (){
                  _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                },
                child: Text('NEXT',
                style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                               fontWeight: FontWeight.bold
                              ),),
              )
            ],
          ))
          
          
         
        ]
      )
      ),
    );
  }
}