namespace Moshine.UI.UIKit.Material;

uses
  Foundation,
  //MaterialComponentsBeta,
  MaterialComponents;

type

  ISchemeExtensions = public extension class(IScheme)

  public

    property typographyScheme:MDCTypographyScheme read
      begin
        exit new MDCTypographyScheme;
      end;

    property selectedColor:UIColor read
      begin
        //exit UIColor.blackColor;
        exit UIColor.colorWithRed(0/255.0) green(122/255.0) blue(255/255.0) alpha(1);
      end;

    property colorScheme:MDCSemanticColorScheme read
      begin

        var scheme := new MDCSemanticColorScheme WithDefaults(MDCColorSchemeDefaults.Material201804);
        scheme.primaryColor := UIColor.whiteColor;
        scheme.onPrimaryColor := self.selectedColor;
        scheme.secondaryColor := UIColor.whiteColor;
        scheme.onSecondaryColor := self.selectedColor;
        scheme.surfaceColor := UIColor.whiteColor;
        scheme.onSurfaceColor := self.selectedColor;
        exit scheme;
      end;

    /*
    property containerScheme: MDCContainerScheme read
      begin

        var scheme := new MDCContainerScheme;
        scheme.colorScheme := self.colorScheme;
        scheme.typographyScheme := self.typographyScheme;
        exit scheme;
      end;
      */


  end;
end.