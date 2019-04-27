namespace Moshine.UI.UIKit.Material;

uses
  MaterialComponents,
  UIKit;

type

  [IBObject]
  BottomNavigationBarViewController = public abstract class(UIViewController, MDCBottomNavigationBarDelegate)
  private

    method layoutBottomNavBar;
    begin
      var viewBounds: CGRect := CGRectStandardize(self.view.bounds);
      var size: CGSize := self.bottomNavBar.sizeThatFits(viewBounds.size);
      var safeAreaInsets := UIEdgeInsetsZero;
      // Extend the Bottom Navigation to the bottom of the screen.
      if (available('iOS 11.0', "*")) then
      begin
        safeAreaInsets := self.view.safeAreaInsets;
      end;

      var bottomNavBarFrame: CGRect := CGRectMake(0, viewBounds.size.height - size.height - safeAreaInsets.bottom, size.width, size.height + safeAreaInsets.bottom);
      self.bottomNavBar.frame := bottomNavBarFrame;
    end;

    method createBottomNavBar;
    begin
      self.bottomNavBar := new MDCBottomNavigationBar withFrame(CGRectZero);
      self.bottomNavBar.sizeThatFitsIncludesSafeArea := false;
      self.bottomNavBar.titleVisibility := MDCBottomNavigationBarTitleVisibility.Selected;
      self.bottomNavBar.alignment := MDCBottomNavigationBarAlignment.JustifiedAdjacentTitles;
      self.bottomNavBar.delegate := self;
      self.view.addSubview(self.bottomNavBar);

      self.bottomNavBar.items := itemsForBottomNavigationBar;
      self.bottomNavBar.selectedItem := selectedNavigationBarItem;

    end;

  protected
    method itemsForBottomNavigationBar:NSArray<UITabBarItem>; abstract;
    method selectedNavigationBarItem:UITabBarItem; abstract;

  public

    property bottomNavBar:MDCBottomNavigationBar;
    property typographyScheme:MDCTypographyScheme := new MDCTypographyScheme;
    property colorScheme:MDCSemanticColorScheme /*:= new MDCSemanticColorScheme withDefaults(MDCColorSchemeDefaults.MDCColorSchemeDefaultsMaterial201804)*/;

    method viewDidLoad; override;
    begin
      inherited viewDidLoad;

      colorScheme :=  new MDCSemanticColorScheme withDefaults(MDCColorSchemeDefaults.Material201804);
      colorScheme.primaryColor := UIColor.whiteColor;
      var selectedColor := UIColor.colorWithRed(0/255.0) green(122/255.0) blue(255/255.0) alpha(1);
      colorScheme.onPrimaryColor := selectedColor /*UIColor.blackColor*/;

      createBottomNavBar;
      MDCBottomNavigationBarTypographyThemer.applyTypographyScheme(self.typographyScheme) toBottomNavigationBar(self.bottomNavBar);
      MDCBottomNavigationBarColorThemer.applySemanticColorScheme(self.colorScheme) toBottomNavigation(self.bottomNavBar);

    end;

    method viewSafeAreaInsetsDidChange; override;
    begin
      if (available('iOS 11.0', "*")) then
      begin
        inherited.viewSafeAreaInsetsDidChange;
      end;

      self.layoutBottomNavBar;

    end;

    method viewDidLayoutSubviews; override;
    begin
      inherited viewDidLayoutSubviews;
      layoutBottomNavBar;
    end;

  end;

end.