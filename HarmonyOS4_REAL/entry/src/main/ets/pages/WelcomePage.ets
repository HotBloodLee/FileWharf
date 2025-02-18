import { CommonConstants } from '../common/constants/CommonConstants';
import common from '@ohos.app.ability.common';
import UserPrivacyDialog from '../view/welcome/UserPrivacyDialog';
import PreferenceUtil from '../common/utils/PreferenceUtil';
import router from '@ohos.router';

const PREF_KEY = 'user_privacy_key'

@Entry
@Component
struct WelcomePage {
  context = getContext(this) as common.UIAbilityContext

  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm: () => this.onConfirm(),
      cancel: () => this.exitApp()
    })
  })

  async aboutToAppear() {
    // 1. 加载首选项
    let isAgree = await PreferenceUtil.getPreferenceValue(PREF_KEY, false)
    // 2. 判断是否同意
    if(isAgree) {
      // 2.1 同意，跳转到首页
      this.jumpToHomePage()
    }else {
      // 2.2 未同意，弹出隐私协议对话框
      this.controller.open()
    }
  }

  jumpToHomePage() {
    setTimeout(() => {
      // 跳转到首页
      router.replaceUrl({
        url: 'pages/Index'
      })
    }, 1000)
  }

  onConfirm() {
    // 1. 保存首选项
    PreferenceUtil.putPreferenceValue(PREF_KEY, true)
    // 2. 跳转到首页
    this.jumpToHomePage()
  }

  exitApp() {
    // 退出应用
    this.context.terminateSelf()
  }

  build() {
    Column({ space: 10 }) {
      // 1. 中央slogan
      Row() {
        Text('File Wharf')
          .fontSize(40)
          .fontColor(Color.White)
          .fontWeight(CommonConstants.FONT_WEIGHT_900)
      }
      .layoutWeight(1)

      // 2. logo
      Text('File Wharf Logo')
        .fontSize(20)
        .fontColor(Color.White)
      // 3. 文字描述
      Text('Test')
        .fontSize(12)
        .opacity(0.8)
        .fontColor(Color.White)
        .margin({bottom: 25})
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.welcome_page_background'))
  }
}