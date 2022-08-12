library softi_packages;

///
export 'package:softi_packages/packages/app/alert_services/alert_service_interface.dart';
export 'package:softi_packages/packages/app/loading/loading_service_interface.dart';
export 'package:softi_packages/packages/app/local_storage/local_storage_interface.dart';
export 'package:softi_packages/packages/common/mixins/IndexControllerMixin.dart';
export 'package:softi_packages/packages/common/mixins/LocaleControllerMixin.dart';
export 'package:softi_packages/packages/common/mixins/ThemeControllerMixin.dart';
export 'package:softi_packages/packages/common/mixins/TimerControllerMixin.dart';
export 'package:softi_packages/packages/common/mixins/TranslationControllerMixin.dart';
export 'package:softi_packages/packages/app/alert_services/alert_service.dart';
export 'package:softi_packages/packages/app/loading/loading_service.dart';
export 'package:softi_packages/packages/app/local_storage/local_storage.dart';
export 'package:softi_packages/packages/common/widgets/BackgroundServiceManager.dart';
export 'package:softi_packages/packages/common/widgets/HideKeyboardManager.dart';
export 'package:softi_packages/packages/common/widgets/ListItemCreationAware.dart';
export 'package:softi_packages/packages/common/widgets/StateFullWrapper.dart';

///
export 'package:softi_packages/packages/external/auth/controllers/AuthControllerMixin.dart';
export 'package:softi_packages/packages/external/auth/interfaces/i_auth_service.dart';
export 'package:softi_packages/packages/external/auth/models/auth_user.dart';
export 'package:softi_packages/packages/external/auth/models/auth_user.freezed.dart';

///
export 'package:softi_packages/packages/core/controllers/BaseController.dart';
export 'package:softi_packages/packages/core/controllers/BaseLifeCycleController.dart';
export 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
export 'package:softi_packages/packages/core/controllers/MultipleStoppableServiceController.dart';
export 'package:softi_packages/packages/core/controllers/StoppableServiceController.dart';
export 'package:softi_packages/packages/core/services/BaseService.dart';
export 'package:softi_packages/packages/core/services/SoppableService.dart';
export 'package:softi_packages/packages/core/widgets/BaseView.dart';

///
export 'package:softi_packages/packages/device/connectivity/ConnectivityController.dart';
export 'package:softi_packages/packages/device/connectivity/ConnectivityService.dart';
export 'package:softi_packages/packages/device/connectivity/ConnectivityServiceInterface.dart';
export 'package:softi_packages/packages/device/location/LocationController.dart';
export 'package:softi_packages/packages/device/location/location_service.dart';
export 'package:softi_packages/packages/device/location/location_service_intervace.dart';
export 'package:softi_packages/packages/device/media_picker/camera_service.dart';
export 'package:softi_packages/packages/device/media_picker/camera_service_interface.dart';
export 'package:softi_packages/packages/device/media_picker/media_picker_interface.dart';
export 'package:softi_packages/packages/device/media_picker/models.dart';
export 'package:softi_packages/packages/device/media_picker/wechat_media_picker_service.dart';

///
export 'package:softi_packages/packages/firebase/firebase_auth/models/settings.dart';
export 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_provider.dart';
export 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_service.dart';
export 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_apple.dart';
export 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_email.dart';
export 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_email_link.dart';
export 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_facebook.dart';
export 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_google.dart';
export 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_phone.dart';
export 'package:softi_packages/packages/firebase/firebase_firestore/firebase_deserializer.dart';
export 'package:softi_packages/packages/firebase/firebase_firestore/firebase_resource.dart';
export 'package:softi_packages/packages/firebase/firebase_firestore/firestore_resource_adapter.dart';
export 'package:softi_packages/packages/firebase/firebase_firestore/firestore_resource_base.dart';
export 'package:softi_packages/packages/firebase/firebase_deeplink/firebase_deeplink_service.dart';
export 'package:softi_packages/packages/firebase/firebase_storage/firebase_storage_service.dart';

///
export 'package:softi_packages/packages/form/controllers/FormController.dart';
export 'package:softi_packages/packages/form/controllers/FormControllerMixin.dart';
export 'package:softi_packages/packages/form/controllers/ResourceFormController.dart';
export 'package:softi_packages/packages/form/helpers/binder.dart';
export 'package:softi_packages/packages/form/helpers/helpers.dart';
export 'package:softi_packages/packages/form/helpers/map_utils.dart';

///
export 'package:softi_packages/packages/external/resource/controllers/CollectionController.dart';
export 'package:softi_packages/packages/external/resource/controllers/CollectionControllerMixin.dart';
export 'package:softi_packages/packages/external/resource/controllers/CollectionWithTransformControllerMixin.dart';
export 'package:softi_packages/packages/external/resource/controllers/RecordController.dart';
export 'package:softi_packages/packages/external/resource/controllers/RecordControllerMixin.dart';
export 'package:softi_packages/packages/external/resource/interfaces/i_resource.dart';
export 'package:softi_packages/packages/external/resource/interfaces/i_resource_adapter.dart';
export 'package:softi_packages/packages/external/resource/interfaces/i_resource_base.dart';
export 'package:softi_packages/packages/external/resource/models/ResourceCollection.dart';
export 'package:softi_packages/packages/external/resource/models/ResourceCollectionWithTransform.dart';
export 'package:softi_packages/packages/external/resource/models/ResourceRecord.dart';
export 'package:softi_packages/packages/external/resource/models/filters.dart';
export 'package:softi_packages/packages/external/resource/models/query.dart';

///
export 'package:softi_packages/packages/external/dynamic_links/i_dynamiclink_service.dart';
export 'package:softi_packages/packages/external/presence/PresenceController.dart';
export 'package:softi_packages/packages/external/presence/presence_service_interface.dart';
export 'package:softi_packages/packages/external/remote_Storage/i_remote_storage.dart';
export 'package:softi_packages/packages/external/remote_config/i_remote_config.dart';

///
export 'package:softi_packages/softi_packages.dart';
