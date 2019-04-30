namespace Moshine.UI.UIKit.Material;

uses
  MaterialComponents,
  MaterialComponentsBeta,
  UIKit;

type
  [IBObject]
  BottomAppBarViewController = public abstract class(UIViewController)

  private


    method containerScheme: MDCContainerScheme;
    begin

      var scheme := new MDCContainerScheme;
      scheme.colorScheme := self.colorScheme;
      scheme.typographyScheme := self.typographyScheme;
      exit scheme;
    end;

  protected
    method imageForFloatingButton:UIImage; abstract;

    method leadingBarButtonItems:NSArray<UIBarButtonItem>; abstract;
    method trailingBarButtonItems:NSArray<UIBarButtonItem>; abstract;

  public

    property bottomBarView:MDCBottomAppBarView;

    property typographyScheme:MDCTypographyScheme := new MDCTypographyScheme;
    property colorScheme:MDCSemanticColorScheme;

    method viewDidLoad; override;
    begin
      inherited viewDidLoad;
      commonMDCBottomAppBarViewControllerSetup;
    end;

    method commonMDCBottomAppBarViewControllerSetup;
    begin
      colorScheme := new MDCSemanticColorScheme WithDefaults(MDCColorSchemeDefaults.Material201804);
      colorScheme.primaryColor := UIColor.whiteColor;
      var selectedColor := UIColor.colorWithRed(0/255.0) green(122/255.0) blue(255/255.0) alpha(1);
      colorScheme.onPrimaryColor := selectedColor /*UIColor.blackColor*/;

      bottomBarView := new MDCBottomAppBarView WithFrame(CGRectZero);
      bottomBarView.autoresizingMask := UIViewAutoresizing.FlexibleWidth or UIViewAutoresizing.FlexibleTopMargin;

      self.bottomBarView.floatingButton.applySecondaryThemeWithScheme(containerScheme);
      MDCBottomAppBarColorThemer.applySurfaceVariantWithSemanticColorScheme(self.colorScheme) toBottomAppBarView(self.bottomBarView);

      self.bottomBarView.floatingButton.addTarget(self) action(selector(didTapFloatingButton:)) forControlEvents(UIControlEvents.UIControlEventTouchUpInside);

      self.bottomBarView.floatingButton.setImage(imageForFloatingButton) forState(UIControlState.Normal);
      self.bottomBarView.leadingBarButtonItems := leadingBarButtonItems;

      for each item in self.bottomBarView.leadingBarButtonItems do
      begin
        item.tintColor := selectedColor;
      end;

      self.bottomBarView.trailingBarButtonItems := trailingBarButtonItems;

      for each item in self.bottomBarView.trailingBarButtonItems do
      begin
        item.tintColor := selectedColor;
      end;

      self.bottomBarView.tintColor := selectedColor;


      //var buttonScheme := new MDCButtonScheme;
      //buttonScheme.colorScheme := colorScheme;
      //buttonScheme.typographyScheme := typographyScheme;

     // MDCFloatingActionButtonThemer.applyScheme(buttonScheme) toButton(bottomBarView.floatingButton);



      self.view.addSubview(bottomBarView);
    end;

    method didTapFloatingButton(sender:id); virtual;
    begin
      NSLog('tapped floating button');
    end;

    method layoutBottomAppBar;
    begin
      var size: CGSize := bottomBarView.sizeThatFits(self.view.bounds.size);
      var bottomBarViewFrame: CGRect := CGRectMake(0, CGRectGetHeight(self.view.bounds) - size.height, size.width, size.height);
      bottomBarView.frame := bottomBarViewFrame;
    end;

    method viewWillLayoutSubviews; override;
    begin
      inherited viewWillLayoutSubviews;
      self.layoutBottomAppBar;
    end;

    method viewSafeAreaInsetsDidChange; override;
    begin
      if (available('iOS 11.0', "*")) then
      begin
        inherited viewSafeAreaInsetsDidChange;
      end;

      self.layoutBottomAppBar;
    end;




  end;

end.