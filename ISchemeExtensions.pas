namespace Moshine.UI.UIKit.Material;

uses
  Foundation, MaterialComponentsBeta,MaterialComponents;

type
  ISchemeExtensions = public extension class(IScheme)

  private
    _scheme:MDCContainerScheme;
    _colorScheme:MDCSemanticColorScheme;
    _typographyScheme:MDCTypographyScheme;
    _selectedColor:UIColor;

  public

    property typographyScheme:MDCTypographyScheme read
      begin
        if(not assigned(_typographyScheme))then
        begin
          _typographyScheme := new MDCTypographyScheme;
        end;
        exit _typographyScheme;
      end;

    property selectedColor:UIColor read
      begin
        if(not assigned(_selectedColor))then
        begin
          _selectedColor := UIColor.blackColor; //UIColor.colorWithRed(0/255.0) green(122/255.0) blue(255/255.0) alpha(1);
        end;
        exit _selectedColor;
      end;





    property colorScheme:MDCSemanticColorScheme read
      begin
        if(assigned(_colorScheme))then
        begin
          exit _colorScheme;
        end;

        _colorScheme := new MDCSemanticColorScheme WithDefaults(MDCColorSchemeDefaults.Material201804);
        _colorScheme.primaryColor := UIColor.whiteColor;
        //_colorScheme.onPrimaryColor := selectedColor ;
        _colorScheme.onPrimaryColor := UIColor.blackColor;
        exit _colorScheme;

      end;


    property containerScheme: MDCContainerScheme read
      begin
        if(assigned(_scheme))then
        begin
          exit _scheme;
        end;

        _scheme := new MDCContainerScheme;
        _scheme.colorScheme := self.colorScheme;
        _scheme.typographyScheme := self.typographyScheme;
        exit _scheme;
      end;


  end;
end.