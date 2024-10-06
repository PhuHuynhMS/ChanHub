import 'package:flutter/material.dart';

import '../../../common/enums.dart';

IconData getChannelIcon(ChannelPrivacy channelPrivacy) {
  switch (channelPrivacy) {
    case ChannelPrivacy.public:
      return Icons.public;
    case ChannelPrivacy.private:
      return Icons.lock;
  }
}

String getReactionEmoji(ReactionType type) {
  switch (type) {
    case ReactionType.like:
      return '\u{1F44D}';
    case ReactionType.love:
      return '\u{2764}';
    case ReactionType.haha:
      return '\u{1F604}';
    case ReactionType.seen:
      return '\u{1F440}';
    case ReactionType.dislike:
      return '\u{1F44E}';
    case ReactionType.completed:
      return '\u{2705}';
  }
}
