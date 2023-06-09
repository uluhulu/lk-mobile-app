import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/help/navigation_claims_filter_page_params.dart';
import '../core/help/navigation_invoices_filter_page_params.dart';
import '../core/help/navigation_route_params.dart';
import '../domain/repositories/repository.dart';
import '../locator/locator.dart';
import '../presentation/navigation/navigation_page_route.dart';
import '../presentation/pages/claim_drafts_info/add_overage/views/claim_draft_add_overages_page.dart';
import '../presentation/pages/claim_drafts_info/views/add_product/add_product_page.dart';
import '../presentation/pages/claim_drafts_info/views/claim_drafts_info_page.dart';
import '../presentation/pages/claim_drafts_list/views/claim_drafts_list_page.dart';
import '../presentation/pages/claim_drafts_products/views/claim_draft_product_info.dart';
import '../presentation/pages/claims/views/claims_filters_page.dart';
import '../presentation/pages/claims/views/claims_search_page.dart';
import '../presentation/pages/claims_detail/views/claim_detail_page.dart';
import '../presentation/pages/create_claim/views/create_claim_page.dart';
import '../presentation/pages/invoices/views/invoices_filters_page.dart';
import '../presentation/pages/invoices/views/invoices_search_page.dart';
import '../presentation/pages/invoices_detail/invoices_add_overage/views/invoice_add_overage_provider.dart';
import '../presentation/pages/invoices_detail/views/invoices_detail_page.dart';
import '../presentation/pages/help/views/help_page.dart';
import '../presentation/pages/help_detail/views/help_detail_page.dart';
import '../presentation/pages/loca_auth/views/set_pin_code_page.dart';
import '../presentation/pages/main/main_screen.dart';
import '../presentation/pages/not_found/not_found_screen.dart';
import '../presentation/pages/profile/act/views/act_page.dart';
import '../presentation/pages/restore_password/views/restore_password_page.dart';
import '../presentation/widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';

/// Роуты
class AppRoutes {
  static const String init = '/',
      home = '/home',
      authorized = '/authorized',
      restorePassword = '/restorePassword',
      setPin = '/setPin',
      act = '/act',
      invoicesDetail = '/invoicesDetail',
      invoicesFilters = '/invoicesFilters',
      search = '/search',
      claimSearch = '/claimSearch',
      claimDetail = '/claimDetail',
      claimDraftsList = '/claimDraftsList',
      claimDraftsInfo = '/claimDraftsInfo',
      claimDraftProductInfo = '/claimDraftProductInfo',
      claimAddItem = '/claimAddItem',
      createClaimDraft = '/createClaimDraft',
      claimDraftAddOverages = '/claimDraftAddOverages',
      help = '/help',
      helpDetail = '/helpDetail',
      invoiceAddOverages = '/invoiceAddOverages',
      claimsFilters = '/claimsFilters';

  static Widget? child;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late final WidgetBuilder builder;
    late final NavigationRouteParams baseArguments;

    if (settings.arguments is NavigationRouteParams) {
      baseArguments = settings.arguments! as NavigationRouteParams;
    }

    switch (settings.name) {
      case init:
        builder = (BuildContext _) => child ?? const NotFoundScreen();
        break;
      case restorePassword:
        builder = (BuildContext _) => const RestorePasswordProvider();
        break;
      case home:
        builder = (BuildContext _) => const MainScreen();
        break;

      case setPin:
        builder = (BuildContext _) => const SetPinCodePage();
        break;
      case act:
        builder = (BuildContext _) => const ActProvider();
        break;
      case invoicesDetail:
        builder = (BuildContext _) => InvoicesDetailProvider(
              uuid: baseArguments.uuid,
            );
        break;

      case invoicesFilters:
        final arg = settings.arguments;
        if (arg is InvoicesFilterPageParams) {
          builder = (_) => BlocProvider.value(
                value: arg.bloc,
                child: InvoicesFiltersPage(
                  data: arg.data,
                ),
              );
          break;
        } else {
          builder = (BuildContext _) => const NotFoundScreen();
          break;
        }

      case claimsFilters:
        final arg = settings.arguments;
        if (arg is ClaimsFilterPageParams) {
          builder = (_) => BlocProvider.value(
                value: arg.bloc,
                child: ClaimsFiltersPage(
                  data: arg.data,
                ),
              );
          break;
        } else {
          builder = (BuildContext _) => const NotFoundScreen();
          break;
        }

      case search:
        builder = (BuildContext _) => const InvoicesSearchPage();
        break;

      case claimSearch:
        builder = (BuildContext _) => const ClaimsSearchPage();
        break;

      case claimDetail:
        builder =
            (BuildContext _) => ClaimDetailProvider(uuid: baseArguments.uuid);
        break;

      case claimDraftsList:
        builder = (BuildContext _) => const ClaimDraftsListProvider();
        break;

      case claimDraftsInfo:
        final arg = settings.arguments;
        if (arg is ClaimsDraftsListPageParams) {
          builder = (_) => ClaimDraftsInfoProvider(
                id: arg.id,
              );
          break;
        } else {
          builder = (BuildContext _) => const NotFoundScreen();
          break;
        }

      case claimDraftProductInfo:
        final arg = settings.arguments;
        if (arg is ClaimsDraftsProductInfoParams) {
          builder = (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: arg.bloc,
                  ),
                  BlocProvider.value(
                    value: arg.errorCubit,
                  ),
                ],
                child: BlocProvider<ClaimsFilesCubit>(
                  create: (context) =>
                      ClaimsFilesCubit(repository: sl.get<Repository>())
                        ..claimDraftAttachmentToFiles(
                          arg.data.attachments ?? [],
                        ),
                  child: ClaimDraftProductProvider(
                    data: arg.data,
                    draftId: arg.id,
                  ),
                ),
              );
          break;
        } else {
          builder = (BuildContext _) => const NotFoundScreen();
          break;
        }
      case claimAddItem:
        final arg = settings.arguments;
        if (arg is ClaimsDraftsAddItemParams) {
          builder = (_) => BlocProvider.value(
                value: arg.bloc,
                child: CreateClaimPage(
                  draftId: arg.id,
                ),
              );
          break;
        } else {
          builder = (BuildContext _) => const NotFoundScreen();
          break;
        }

      case createClaimDraft:
        final arg = settings.arguments;
        if (arg is CreateClaimDraftParams) {
          builder = (_) => CreateClaimProvider(
                uuid: arg.uuid,
              );
          break;
        } else {
          builder = (BuildContext _) => const NotFoundScreen();
          break;
        }

      case help:
        // final arg = settings.arguments;
        // if (arg is CreateClaimDraftParams) {
        //   builder = (_) => CreateClaimProvider(
        //         uuid: arg.uuid,
        //       );
        builder = (BuildContext _) => const HelpPageProvider();
        break;
      case helpDetail:
        final arg = settings.arguments;
        // final arg = settings.arguments;
        // if (arg is CreateClaimDraftParams) {
        //   builder = (_) => CreateClaimProvider(
        //         uuid: arg.uuid,
        //       );
        if (arg is HelpDetailParams) {
          builder = (_) => HelpDetailPageProvider(
                content: arg.content,
                helpTitle: arg.helpTitle,
                otherContentItems: arg.otherContentItems,
              );
          break;
        } else {
          builder = (BuildContext _) => const NotFoundScreen();
          break;
        }
      // } else {
      //   builder = (BuildContext _) => const NotFoundScreen();
      //   break;
      // }

      case claimDraftAddOverages:
        final arg = settings.arguments;
        if (arg is ClaimDraftAddOveragesParams) {
          builder = (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: arg.claimErrorBloc,
                  ),
                  BlocProvider.value(
                    value: arg.productsBloc,
                  ),
                  BlocProvider.value(
                    value: arg.bloc,
                  ),
                ],
                child: ClaimDraftAddOveragesPage(
                  id: arg.id,
                ),
              );
          break;
        } else {
          builder = (BuildContext _) => const NotFoundScreen();
          break;
        }

      case invoiceAddOverages:
        final arg = settings.arguments;
        if (arg is CreateClaimDraftParams) {
          builder = (_) => InvoiceAddOveragesProvider(
                guid: arg.uuid,
              );
          break;
        } else {
          builder = (BuildContext _) => const NotFoundScreen();
          break;
        }
      // builder = (BuildContext _) => InvoiceAddOveragesProvider(
      //       guid: baseArguments.uuid,
      //     );
      // break;

      // builder = (BuildContext _) =>  ClaimDraftProductInfo();
      // break;
      // builder = (BuildContext _) => ClaimDraftsInfoProvider(
      //       id: int.parse(baseArguments.uuid),
      //     );
      // break;

      // case authorized:
      //   builder = (BuildContext _) => const AuthorizationPage(
      //         child: DocumentListProvider(),
      //       );
      //   break;

      default:
        builder = (BuildContext _) => const NotFoundScreen();
    }

    return NavigationPageRoute<void>(builder: builder, settings: settings);
  }
}
