part of "../app_extensions.dart";

extension CustomColorExt on BuildContext {
  //  material,
  //   materialHc,
  //   blue,
  //   indigo,
  //   hippieBlue,
  //   aquaBlue,
  //   brandBlue,
  //   deepBlue,
  //   sakura,
  //   mandyRed,
  //   red,
  //   redWine,
  //   purpleBrown,
  //   green,
  //   money,
  //   jungle,
  //   greyLaw,
  //   wasabi,
  //   gold,
  //   mango,
  //   amber,
  //   vesuviusBurn,
  //   deepPurple,
  //   ebonyClay,
  //   barossa,
  //   shark,
  //   bigStone,
  //   damask,
  //   bahamaBlue,
  //   mallardGreen,
  //   espresso,
  //   outerSpace,
  //   blueWhale,
  //   sanJuanBlue,
  //   rosewood,
  //   blumineBlue,
  //   flutterDash,
  //   materialBaseline,
  //   verdunHemlock,
  //   dellGenoa,
  //   redM3,
  //   pinkM3,
  //   purpleM3,
  //   indigoM3,
  //   blueM3,
  //   cyanM3,
  //   tealM3,
  //   greenM3,
  //   limeM3,
  //   yellowM3,
  //   orangeM3,
  //   deepOrangeM3,

  Color getOnColor(Color color) {
    return (ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white.blendAlpha(color.brighten(20), 0)
        : Colors.black.blendAlpha(color.brighten(20), 0));
  }

  Color get redM3Primary =>
      this.isDark ? FlexColor.redM3DarkPrimary : FlexColor.redM3LightPrimary;
  Color get onRedM3Primary => this.isDark
      ? getOnColor(FlexColor.redM3DarkPrimary)
      : getOnColor(FlexColor.redM3LightPrimary);

  Color get pinkM3Primary =>
      this.isDark ? FlexColor.pinkM3DarkPrimary : FlexColor.pinkM3LightPrimary;
  Color get onPinkM3Primary => this.isDark
      ? getOnColor(FlexColor.pinkM3DarkPrimary)
      : getOnColor(FlexColor.pinkM3LightPrimary);

  Color get purpleM3Primary => this.isDark
      ? FlexColor.purpleM3DarkPrimary
      : FlexColor.purpleM3LightPrimary;
  Color get onPurpleM3Primary => this.isDark
      ? getOnColor(FlexColor.purpleM3DarkPrimary)
      : getOnColor(FlexColor.purpleM3LightPrimary);

  Color get indigoM3Primary => this.isDark
      ? FlexColor.indigoM3DarkPrimary
      : FlexColor.indigoM3LightPrimary;
  Color get onIndigoM3Primary => this.isDark
      ? getOnColor(FlexColor.indigoM3DarkPrimary)
      : getOnColor(FlexColor.indigoM3LightPrimary);

  Color get blueM3Primary =>
      this.isDark ? FlexColor.blueM3DarkPrimary : FlexColor.blueM3LightPrimary;
  Color get onBlueM3Primary => this.isDark
      ? getOnColor(FlexColor.blueM3DarkPrimary)
      : getOnColor(FlexColor.blueM3LightPrimary);

  Color get cyanM3Primary =>
      this.isDark ? FlexColor.cyanM3DarkPrimary : FlexColor.cyanM3LightPrimary;
  Color get onCyanM3Primary => this.isDark
      ? getOnColor(FlexColor.cyanM3DarkPrimary)
      : getOnColor(FlexColor.cyanM3LightPrimary);

  Color get tealM3Primary =>
      this.isDark ? FlexColor.tealM3DarkPrimary : FlexColor.tealM3LightPrimary;
  Color get onTealM3Primary => this.isDark
      ? getOnColor(FlexColor.tealM3DarkPrimary)
      : getOnColor(FlexColor.tealM3LightPrimary);

  Color get greenM3Primary => this.isDark
      ? FlexColor.greenM3DarkPrimary
      : FlexColor.greenM3LightPrimary;
  Color get onGreenM3Primary => this.isDark
      ? getOnColor(FlexColor.greenM3DarkPrimary)
      : getOnColor(FlexColor.greenM3LightPrimary);

  Color get limeM3Primary =>
      this.isDark ? FlexColor.limeM3DarkPrimary : FlexColor.limeM3LightPrimary;
  Color get onLimeM3Primary => this.isDark
      ? getOnColor(FlexColor.limeM3DarkPrimary)
      : getOnColor(FlexColor.limeM3LightPrimary);

  Color get yellowM3Primary => this.isDark
      ? FlexColor.yellowM3DarkPrimary
      : FlexColor.yellowM3LightPrimary;
  Color get onYellowM3Primary => this.isDark
      ? getOnColor(FlexColor.yellowM3DarkPrimary)
      : getOnColor(FlexColor.yellowM3LightPrimary);

  Color get orangeM3Primary => this.isDark
      ? FlexColor.orangeM3DarkPrimary
      : FlexColor.orangeM3LightPrimary;
  Color get onOrangeM3Primary => this.isDark
      ? getOnColor(FlexColor.orangeM3DarkPrimary)
      : getOnColor(FlexColor.orangeM3LightPrimary);

  Color get deepOrangeM3Primary => this.isDark
      ? FlexColor.deepOrangeM3DarkPrimary
      : FlexColor.deepOrangeM3LightPrimary;
  Color get onDeepOrangeM3Primary => this.isDark
      ? getOnColor(FlexColor.deepOrangeM3DarkPrimary)
      : getOnColor(FlexColor.deepOrangeM3LightPrimary);
  Color get bluePrimary =>
      this.isDark ? FlexColor.blueDarkPrimary : FlexColor.blueLightPrimary;
  Color get onBluePrimary => this.isDark
      ? getOnColor(FlexColor.blueDarkPrimary)
      : getOnColor(FlexColor.blueLightPrimary);

  Color get indigoPrimary =>
      this.isDark ? FlexColor.indigoDarkPrimary : FlexColor.indigoLightPrimary;
  Color get onIndigoPrimary => this.isDark
      ? getOnColor(FlexColor.indigoDarkPrimary)
      : getOnColor(FlexColor.indigoLightPrimary);

  Color get hippieBluePrimary => this.isDark
      ? FlexColor.hippieBlueDarkPrimary
      : FlexColor.hippieBlueLightPrimary;
  Color get onHippieBluePrimary => this.isDark
      ? getOnColor(FlexColor.hippieBlueDarkPrimary)
      : getOnColor(FlexColor.hippieBlueLightPrimary);

  Color get aquaBluePrimary => this.isDark
      ? FlexColor.aquaBlueDarkPrimary
      : FlexColor.aquaBlueLightPrimary;
  Color get onAquaBluePrimary => this.isDark
      ? getOnColor(FlexColor.aquaBlueDarkPrimary)
      : getOnColor(FlexColor.aquaBlueLightPrimary);

  Color get brandBluePrimary => this.isDark
      ? FlexColor.brandBlueDarkPrimary
      : FlexColor.brandBlueLightPrimary;
  Color get onBrandBluePrimary => this.isDark
      ? getOnColor(FlexColor.brandBlueDarkPrimary)
      : getOnColor(FlexColor.brandBlueLightPrimary);

  Color get deepBluePrimary => this.isDark
      ? FlexColor.deepBlueDarkPrimary
      : FlexColor.deepBlueLightPrimary;
  Color get onDeepBluePrimary => this.isDark
      ? getOnColor(FlexColor.deepBlueDarkPrimary)
      : getOnColor(FlexColor.deepBlueLightPrimary);

  Color get sakuraPrimary =>
      this.isDark ? FlexColor.sakuraDarkPrimary : FlexColor.sakuraLightPrimary;
  Color get onSakuraPrimary => this.isDark
      ? getOnColor(FlexColor.sakuraDarkPrimary)
      : getOnColor(FlexColor.sakuraLightPrimary);

  Color get mandyRedPrimary => this.isDark
      ? FlexColor.mandyRedDarkPrimary
      : FlexColor.mandyRedLightPrimary;
  Color get onMandyRedPrimary => this.isDark
      ? getOnColor(FlexColor.mandyRedDarkPrimary)
      : getOnColor(FlexColor.mandyRedLightPrimary);

  Color get redPrimary =>
      this.isDark ? FlexColor.redDarkPrimary : FlexColor.redLightPrimary;
  Color get onRedPrimary => this.isDark
      ? getOnColor(FlexColor.redDarkPrimary)
      : getOnColor(FlexColor.redLightPrimary);

  Color get redWinePrimary => this.isDark
      ? FlexColor.redWineDarkPrimary
      : FlexColor.redWineLightPrimary;
  Color get onRedWinePrimary => this.isDark
      ? getOnColor(FlexColor.redWineDarkPrimary)
      : getOnColor(FlexColor.redWineLightPrimary);

  Color get purpleBrownPrimary => this.isDark
      ? FlexColor.purpleBrownDarkPrimary
      : FlexColor.purpleBrownLightPrimary;
  Color get onPurpleBrownPrimary => this.isDark
      ? getOnColor(FlexColor.purpleBrownDarkPrimary)
      : getOnColor(FlexColor.purpleBrownLightPrimary);

  Color get greenPrimary =>
      this.isDark ? FlexColor.greenDarkPrimary : FlexColor.greenLightPrimary;
  Color get onGreenPrimary => this.isDark
      ? getOnColor(FlexColor.greenDarkPrimary)
      : getOnColor(FlexColor.greenLightPrimary);

  Color get moneyPrimary =>
      this.isDark ? FlexColor.moneyDarkPrimary : FlexColor.moneyLightPrimary;
  Color get onMoneyPrimary => this.isDark
      ? getOnColor(FlexColor.moneyDarkPrimary)
      : getOnColor(FlexColor.moneyLightPrimary);

  Color get junglePrimary =>
      this.isDark ? FlexColor.jungleDarkPrimary : FlexColor.jungleLightPrimary;
  Color get onJunglePrimary => this.isDark
      ? getOnColor(FlexColor.jungleDarkPrimary)
      : getOnColor(FlexColor.jungleLightPrimary);

  Color get greyLawPrimary => this.isDark
      ? FlexColor.greyLawDarkPrimary
      : FlexColor.greyLawLightPrimary;
  Color get onGreyLawPrimary => this.isDark
      ? getOnColor(FlexColor.greyLawDarkPrimary)
      : getOnColor(FlexColor.greyLawLightPrimary);

  Color get wasabiPrimary =>
      this.isDark ? FlexColor.wasabiDarkPrimary : FlexColor.wasabiLightPrimary;
  Color get onWasabiPrimary => this.isDark
      ? getOnColor(FlexColor.wasabiDarkPrimary)
      : getOnColor(FlexColor.wasabiLightPrimary);

  Color get goldPrimary =>
      this.isDark ? FlexColor.goldDarkPrimary : FlexColor.goldLightPrimary;
  Color get onGoldPrimary => this.isDark
      ? getOnColor(FlexColor.goldDarkPrimary)
      : getOnColor(FlexColor.goldLightPrimary);

  Color get mangoPrimary =>
      this.isDark ? FlexColor.mangoDarkPrimary : FlexColor.mangoLightPrimary;
  Color get onMangoPrimary => this.isDark
      ? getOnColor(FlexColor.mangoDarkPrimary)
      : getOnColor(FlexColor.mangoLightPrimary);

  Color get amberPrimary =>
      this.isDark ? FlexColor.amberDarkPrimary : FlexColor.amberLightPrimary;
  Color get onAmberPrimary => this.isDark
      ? getOnColor(FlexColor.amberDarkPrimary)
      : getOnColor(FlexColor.amberLightPrimary);

  Color get vesuviusBurnPrimary => this.isDark
      ? FlexColor.vesuviusBurnDarkPrimary
      : FlexColor.vesuviusBurnLightPrimary;
  Color get onVesuviusBurnPrimary => this.isDark
      ? getOnColor(FlexColor.vesuviusBurnDarkPrimary)
      : getOnColor(FlexColor.vesuviusBurnLightPrimary);

  Color get deepPurplePrimary => this.isDark
      ? FlexColor.deepPurpleDarkPrimary
      : FlexColor.deepPurpleLightPrimary;
  Color get onDeepPurplePrimary => this.isDark
      ? getOnColor(FlexColor.deepPurpleDarkPrimary)
      : getOnColor(FlexColor.deepPurpleLightPrimary);

  Color get ebonyClayPrimary => this.isDark
      ? FlexColor.ebonyClayDarkPrimary
      : FlexColor.ebonyClayLightPrimary;
  Color get onEbonyClayPrimary => this.isDark
      ? getOnColor(FlexColor.ebonyClayDarkPrimary)
      : getOnColor(FlexColor.ebonyClayLightPrimary);

  Color get barossaPrimary => this.isDark
      ? FlexColor.barossaDarkPrimary
      : FlexColor.barossaLightPrimary;
  Color get onBarossaPrimary => this.isDark
      ? getOnColor(FlexColor.barossaDarkPrimary)
      : getOnColor(FlexColor.barossaLightPrimary);

  Color get sharkPrimary =>
      this.isDark ? FlexColor.sharkDarkPrimary : FlexColor.sharkLightPrimary;
  Color get onSharkPrimary => this.isDark
      ? getOnColor(FlexColor.sharkDarkPrimary)
      : getOnColor(FlexColor.sharkLightPrimary);

  Color get bigStonePrimary => this.isDark
      ? FlexColor.bigStoneDarkPrimary
      : FlexColor.bigStoneLightPrimary;
  Color get onBigStonePrimary => this.isDark
      ? getOnColor(FlexColor.bigStoneDarkPrimary)
      : getOnColor(FlexColor.bigStoneLightPrimary);

  Color get damaskPrimary =>
      this.isDark ? FlexColor.damaskDarkPrimary : FlexColor.damaskLightPrimary;
  Color get onDamaskPrimary => this.isDark
      ? getOnColor(FlexColor.damaskDarkPrimary)
      : getOnColor(FlexColor.damaskLightPrimary);

  Color get bahamaBluePrimary => this.isDark
      ? FlexColor.bahamaBlueDarkPrimary
      : FlexColor.bahamaBlueLightPrimary;
  Color get onBahamaBluePrimary => this.isDark
      ? getOnColor(FlexColor.bahamaBlueDarkPrimary)
      : getOnColor(FlexColor.bahamaBlueLightPrimary);

  Color get mallardGreenPrimary => this.isDark
      ? FlexColor.mallardGreenDarkPrimary
      : FlexColor.mallardGreenLightPrimary;
  Color get onMallardGreenPrimary => this.isDark
      ? getOnColor(FlexColor.mallardGreenDarkPrimary)
      : getOnColor(FlexColor.mallardGreenLightPrimary);

  Color get espressoPrimary => this.isDark
      ? FlexColor.espressoDarkPrimary
      : FlexColor.espressoLightPrimary;
  Color get onEspressoPrimary => this.isDark
      ? getOnColor(FlexColor.espressoDarkPrimary)
      : getOnColor(FlexColor.espressoLightPrimary);

  Color get outerSpacePrimary => this.isDark
      ? FlexColor.outerSpaceDarkPrimary
      : FlexColor.outerSpaceLightPrimary;
  Color get onOuterSpacePrimary => this.isDark
      ? getOnColor(FlexColor.outerSpaceDarkPrimary)
      : getOnColor(FlexColor.outerSpaceLightPrimary);

  Color get blueWhalePrimary => this.isDark
      ? FlexColor.blueWhaleDarkPrimary
      : FlexColor.blueWhaleLightPrimary;
  Color get onBlueWhalePrimary => this.isDark
      ? getOnColor(FlexColor.blueWhaleDarkPrimary)
      : getOnColor(FlexColor.blueWhaleLightPrimary);

  Color get sanJuanBluePrimary => this.isDark
      ? FlexColor.sanJuanBlueDarkPrimary
      : FlexColor.sanJuanBlueLightPrimary;
  Color get onSanJuanBluePrimary => this.isDark
      ? getOnColor(FlexColor.sanJuanBlueDarkPrimary)
      : getOnColor(FlexColor.sanJuanBlueLightPrimary);

  Color get rosewoodPrimary => this.isDark
      ? FlexColor.rosewoodDarkPrimary
      : FlexColor.rosewoodLightPrimary;
  Color get onRosewoodPrimary => this.isDark
      ? getOnColor(FlexColor.rosewoodDarkPrimary)
      : getOnColor(FlexColor.rosewoodLightPrimary);

  Color get blumineBluePrimary => this.isDark
      ? FlexColor.blumineBlueDarkPrimary
      : FlexColor.blumineBlueLightPrimary;
  Color get onBlumineBluePrimary => this.isDark
      ? getOnColor(FlexColor.blumineBlueDarkPrimary)
      : getOnColor(FlexColor.blumineBlueLightPrimary);

  Color get materialBaselinePrimary => this.isDark
      ? FlexColor.materialBaselineDarkPrimary
      : FlexColor.materialBaselineLightPrimary;
  Color get onMaterialBaselinePrimary => this.isDark
      ? getOnColor(FlexColor.materialBaselineDarkPrimary)
      : getOnColor(FlexColor.materialBaselineLightPrimary);

  Color get verdunHemlockPrimary => this.isDark
      ? FlexColor.verdunHemlockDarkPrimary
      : FlexColor.verdunHemlockLightPrimary;
  Color get onVerdunHemlockPrimary => this.isDark
      ? getOnColor(FlexColor.verdunHemlockDarkPrimary)
      : getOnColor(FlexColor.verdunHemlockLightPrimary);
}
