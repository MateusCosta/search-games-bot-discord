import 'package:nyxx/nyxx.dart';
import 'package:search_games_bot_discord/config/env.dart';

void main() async {
  Env.load();

  final botToken = Env.get('BOT_TOKEN', defaultValue: '');

  final client =
      await Nyxx.connectGateway(botToken, GatewayIntents.allUnprivileged);

  final botUser = await client.users.fetchCurrentUser();

  client.onMessageCreate.listen((event) async {
    if (event.mentions.contains(botUser)) {
      await event.message.channel.sendMessage(MessageBuilder(
        content: 'You mentioned me!',
        replyId: event.message.id,
      ));
    }
  });
}
