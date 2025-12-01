import 'package:go_router/go_router.dart';

void customNavigatePush(context, String path) {
  GoRouter.of(context).push(path);
}

void customNavigatePushReplacement(context, String path) {
  GoRouter.of(context).pushReplacement(path);
}

void customNavigatePop(context) {
  GoRouter.of(context).pop();
}
