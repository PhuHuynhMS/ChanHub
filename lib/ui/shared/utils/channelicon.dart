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
