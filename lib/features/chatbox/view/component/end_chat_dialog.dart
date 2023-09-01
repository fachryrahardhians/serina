import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serina/common/color_palette/color_palette.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_bloc.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_event.dart';
import 'package:serina/helper/ui/font_style.dart';

import 'package:serina/features/chat_history/view/chat_history_page.dart';

showEndChatDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) => BlocProvider.value(
      value: context.read<ChatBloc>(),
      child: const Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: EndChatDialog(),
      ),
    ),
  );
}

class EndChatDialog extends StatelessWidget {
  const EndChatDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "Selesaikan Obrolan",
            style: bigText.copyWith(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 16),
          Text(
            "Apakah kamu ingin mengakhiri obrolan saat ini?",
          ),
          Text(
            "Jika anda mengakhiri obrolan maka semua chat akan direset.",
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                        border: Border.all(
                          color: ColorPalette.basicRed,
                        )),
                    child: Center(
                      child: Text(
                        "Tidak",
                        style: normalText.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<ChatBloc>().add(ChangeSession());

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatHistoryPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: ColorPalette.basicRed,
                        border: Border.all(
                          color: Colors.white,
                        )),
                    child: Center(
                      child: Text(
                        "Ya",
                        style: normalText.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
