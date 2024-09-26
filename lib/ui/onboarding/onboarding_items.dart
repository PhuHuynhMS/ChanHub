import './onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: "Welcome to ChanHub!",
      descriptions: "Connect, chat, and collaborate seamlessly with your team.",
      svg: "assets/svg/onboard_1.svg",
    ),
    OnboardingInfo(
      title: "Create & Manage Group Tasks",
      descriptions:
          "Create tasks, assign them to team members, and track progress.",
      svg: "assets/svg/onboard_2.svg",
    ),
    OnboardingInfo(
      title: "Stay Connected",
      descriptions: "Instant messaging with channels and private chats.",
      svg: "assets/svg/onboard_3.svg",
    ),
  ];
}
