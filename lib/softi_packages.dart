library softi_packages;

///
export 'package:softi_packages/packages/services/app/alert_services/alert_service_interface.dart';
export 'package:softi_packages/packages/services/app/loading/loading_service_interface.dart';
export 'package:softi_packages/packages/services/app/local_storage/local_storage_interface.dart';
export 'package:softi_packages/packages/common/mixins/IndexControllerMixin.dart';
export 'package:softi_packages/packages/common/mixins/LocaleControllerMixin.dart';
export 'package:softi_packages/packages/common/mixins/ThemeControllerMixin.dart';
export 'package:softi_packages/packages/common/mixins/TimerControllerMixin.dart';
export 'package:softi_packages/packages/common/mixins/TranslationControllerMixin.dart';
export 'package:softi_packages/packages/services/app/alert_services/alert_service.dart';
export 'package:softi_packages/packages/services/app/loading/loading_service.dart';
export 'package:softi_packages/packages/services/app/local_storage/local_storage.dart';
export 'package:softi_packages/packages/common/widgets/BackgroundServiceManager.dart';
export 'package:softi_packages/packages/common/widgets/HideKeyboardManager.dart';
export 'package:softi_packages/packages/common/widgets/ListItemCreationAware.dart';
export 'package:softi_packages/packages/common/widgets/StateFullWrapper.dart';

///
export 'package:softi_packages/packages/services/auth/controllers/AuthControllerMixin.dart';
export 'package:softi_packages/packages/services/auth/interfaces/i_auth_service.dart';
export 'package:softi_packages/packages/services/auth/models/auth_user.dart';

///
export 'package:softi_packages/packages/core/controllers/BaseController.dart';
export 'package:softi_packages/packages/core/controllers/IBaseControllerWithLifeCycle.dart';
export 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
export 'package:softi_packages/packages/core/controllers/MultipleStoppableServiceController.dart';
export 'package:softi_packages/packages/core/controllers/StoppableServiceController.dart';
export 'package:softi_packages/packages/core/services/BaseService.dart';
export 'package:softi_packages/packages/core/services/SoppableService.dart';
export 'package:softi_packages/packages/core/widgets/BaseView.dart';
export 'package:softi_packages/packages/core/widgets/BaseView_copy.dart';

///
export 'package:softi_packages/packages/services/device/connectivity/ConnectivityController.dart';
export 'package:softi_packages/packages/services/device/connectivity/ConnectivityService.dart';
export 'package:softi_packages/packages/services/device/connectivity/ConnectivityServiceInterface.dart';
export 'package:softi_packages/packages/services/device/location/LocationController.dart';
export 'package:softi_packages/packages/services/device/location/location_service.dart';
export 'package:softi_packages/packages/services/device/location/location_service_intervace.dart';
export 'package:softi_packages/packages/services/device/media_picker/camera_service.dart';
export 'package:softi_packages/packages/services/device/media_picker/interfaces/camera_service_interface.dart';
export 'package:softi_packages/packages/services/device/media_picker/interfaces/media_picker_interface.dart';
export 'package:softi_packages/packages/services/device/media_picker/models.dart';
export 'package:softi_packages/packages/services/device/media_picker/wechat_media_picker_service.dart';

///
export 'package:softi_packages/packages/modules/firebase/firebase_auth/models/settings.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_auth/services/firebase_auth_provider.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_auth/services/firebase_auth_service.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_apple.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_email.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_email_link.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_facebook.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_google.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_phone.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_firestore/firebase_deserializer.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_firestore/firebase_resource.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_firestore/firestore_resource_adapter.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_firestore/firestore_resource_base.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_deeplink/firebase_deeplink_service.dart';
export 'package:softi_packages/packages/modules/firebase/firebase_storage/firebase_storage_service.dart';

///
export 'package:softi_packages/packages/modules/form/controllers/FormController.dart';
export 'package:softi_packages/packages/modules/form/controllers/FormControllerMixin.dart';
export 'package:softi_packages/packages/modules/form/controllers/ResourceFormController.dart';
export 'package:softi_packages/packages/modules/form/helpers/binder.dart';
export 'package:softi_packages/packages/modules/form/helpers/helpers.dart';
export 'package:softi_packages/packages/modules/form/helpers/map_utils.dart';

///
export 'package:softi_packages/packages/services/resource/controllers/CollectionController.dart';
export 'package:softi_packages/packages/services/resource/controllers/CollectionControllerMixin.dart';
export 'package:softi_packages/packages/services/resource/controllers/RecordController.dart';
export 'package:softi_packages/packages/services/resource/controllers/RecordControllerMixin.dart';
export 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
export 'package:softi_packages/packages/services/resource/interfaces/i_resource_adapter.dart';
export 'package:softi_packages/packages/services/resource/interfaces/i_resource_base.dart';
export 'package:softi_packages/packages/services/resource/models/ResourceCollection.dart';
export 'package:softi_packages/packages/services/resource/models/ResourceCollectionWithTransform.dart';
export 'package:softi_packages/packages/services/resource/models/ResourceRecord.dart';
export 'package:softi_packages/packages/services/resource/models/filters.dart';
export 'package:softi_packages/packages/services/resource/models/query.dart';

///
export 'package:softi_packages/packages/services/external/dynamic_links/i_dynamiclink_service.dart';
export 'package:softi_packages/packages/services/external/presence/PresenceController.dart';
export 'package:softi_packages/packages/services/external/presence/presence_service_interface.dart';
export 'package:softi_packages/packages/services/external/remote_Storage/i_remote_storage.dart';
export 'package:softi_packages/packages/services/external/remote_config/i_remote_config.dart';

///
export 'package:softi_packages/packages/modules/translation/translated_string.dart';
export 'package:softi_packages/packages/modules/translation/translation_parser.dart';
export 'package:softi_packages/packages/modules/translation/translation_model.dart';

///
export 'package:softi_packages/packages/common/convertors/date.dart';
export 'package:softi_packages/packages/common/convertors/remote_asset.dart';
