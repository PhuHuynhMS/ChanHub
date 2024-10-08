import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../screens.dart';
import './widgets/index.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/onboarding";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingInfo> pages = OnboardingItems().items;
  final PageController pageController = PageController();

  bool isLastPage = false;

  void onPageChanged(int index) {
    setState(() => isLastPage = pages.length - 1 == index);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onSkip() {
    pageController.jumpToPage(pages.length - 1);
  }

  void onNext() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
    );
  }

  void navigateToGetStarted() {
    // TODO: Save the onboarding status
    Navigator.of(context).pushReplacementNamed(GetStartedScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Page View
      body: PageView.builder(
        onPageChanged: onPageChanged,
        itemCount: pages.length,
        controller: pageController,
        itemBuilder: (context, index) => OnboardingPage(pages[index]),
      ),

      // Page Controller
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage ? getStarted() : pageIndicator(),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: navigateToGetStarted,
        child: const Text("Get Started"),
      ),
    );
  }

  Widget pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Skip Button
        TextButton(
          onPressed: onSkip,
          child: const Text("Skip"),
        ),

        // Indicator
        SmoothPageIndicator(
          controller: pageController,
          count: pages.length,
          onDotClicked: (index) => pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          ),
          effect: WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Theme.of(context).colorScheme.primary,
          ),
        ),

        // Next Button
        TextButton(
          onPressed: onNext,
          child: const Text("Next"),
        ),
      ],
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(
    this.page, {
    super.key,
  });

  final OnboardingInfo page;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          page.svg,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
        const SizedBox(height: 15),
        Text(
          page.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        Text(
          page.descriptions,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
