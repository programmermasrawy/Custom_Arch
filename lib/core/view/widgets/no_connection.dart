import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../l10n/l10n.dart';
import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../data/api_manager.dart';
import 'app_close_button.dart';
import 'buttons/app_button.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({
    Key? key,
    this.dismissible = true,
    this.retriable = true,
    required this.failure,
  }) : super(key: key);

  final bool retriable;
  final bool dismissible;
  final Failure failure;

  @override
  State<NoConnection> createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {

  // final enableShareReport = AppRemoteConfig.instance.enableShareReport;
  @override
  void initState() {
    super.initState();
    if (widget.failure is ReportableFailure && true) {
     
    }
  }

  Future<void> shareReport() async {
    final file = await (widget.failure as ReportableFailure).toFile();

   
  }

  @override
  Widget build(BuildContext context) {
    String errorCode = '';
    if (!widget.retriable) {
      if (widget.failure is ServiceNotAvailableFailure) {
        errorCode = 'SNA10';
      } else if (widget.failure is ValidationFailure) {
        errorCode = 'VF20';
      } else if (widget.failure is TypeFailure) {
        var x = widget.failure as TypeFailure;
        if (kDebugMode) {
          print(x.failureInfo.exception);
        }
        errorCode = 'FE30';
      } else if (widget.failure is ErrorFailure) {
        errorCode = 'E40';
      } else if (widget.failure is UnkownFailure) {
        errorCode = 'U50';
      } else if (widget.failure is SessionEndedFailure) {
        return const _SessionEnded();
      }
      errorCode += '\n${widget.failure.id}';
    }
    return Dialog(
      elevation: 12.0,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: AppColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppCloseButton(
                  onPressed: () => dismiss(context: context, retry: false)),
              if (widget.retriable)
                const Image(
                  image: AssetImage(Assets.noWifi),
                  key: Key('no_connection_image_no_connecion'),
                  height: 50,
                  color: AppColors.primary,
                  fit: BoxFit.cover,
                ),
              if (!widget.retriable)
                SvgPicture.asset(
                  Assets.warning,
                  key: const Key('no_connection_image_warning'),
                  height: 50,
                  color: AppColors.primary,
                ),
              const SizedBox(height: 16),
              InkWell(
                onDoubleTap: shareReport,
                child: Text(
                  widget.retriable
                      ? context.l10n.no_connection
                      : context.l10n.try_again_later,
                  style: const TextStyle(
                    color: AppColors.darkGreyBlue,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.retriable
                        ? context.l10n.check_your_connection
                        : errorCode,
                    style: errorCode.isEmpty
                        ? const TextStyle(
                            color: AppColors.darkGreyBlue,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                            fontSize: 16,
                          )
                        : const TextStyle(
                            color: AppColors.darkGreyBlue,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            fontSize: 14,
                          ),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 25),
              if (widget.dismissible && !widget.retriable)
                AppButton(
                  key: const Key('no_connection_button_dismiss'),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  textKey: context.l10n.dismiss,
                  width: 125,
                  height: 35,
                  onPressed: () => dismiss(context: context, retry: false),
                ),
              if (!widget.dismissible && widget.retriable)
                AppButton(
                    key: const Key('no_connection_button_retry'),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    textKey: context.l10n.retry,
                    width: 125,
                    height: 35,
                    onPressed: () => dismiss(context: context, retry: true)),
              if (widget.dismissible && widget.retriable)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: AppButton(
                      key: const Key('no_connection_button_dismiss'),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      textKey: context.l10n.dismiss,
                      height: 35,
                      onPressed: () => dismiss(context: context, retry: false),
                    )),
                    Expanded(
                      child: AppButton(
                        key: const Key('no_connection_button_retry'),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        textKey: context.l10n.retry,
                        height: 35,
                        onPressed: () => dismiss(context: context, retry: true),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void dismiss({required BuildContext context, required bool retry}) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(retry);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _SessionEnded extends StatelessWidget {
  const _SessionEnded({Key? key}) : super(key: key);

  void dismiss({required BuildContext context}) {
    // logout(context);

    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 12.0,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: AppColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 16),
              Text(
                context.l10n.sign_in_again,
                style: const TextStyle(
                  color: AppColors.darkGreyBlue,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  context.l10n.please_sign_in_again,
                  style: const TextStyle(
                    color: AppColors.darkGreyBlue,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25),
              AppButton(
                key: const Key('sign_in_again_button'),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                textKey: context.l10n.login,
                width: 200,
                height: 35,
                onPressed: () => dismiss(context: context),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
