namespace Moshine.UI.UIKit.Material;

uses
  MaterialComponents,
  MaterialComponentsBeta,
  UIKit;

type
  [IBObject]
  BottomAppBarViewController = public abstract class(UIViewController)

  private

    property someConstraint : NSLayoutConstraint;


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

      var alwaysImage := imageForFloatingButton.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);
      self.bottomBarView.floatingButton.setImage(alwaysImage) forState(UIControlState.Normal);

      self.bottomBarView.leadingBarButtonItems := leadingBarButtonItems;

      for each barButtonItem in self.bottomBarView.leadingBarButtonItems do
      begin

        var newImage := barButtonItem.image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);
        barButtonItem.image := newImage;
        barButtonItem.tintColor := selectedColor;

      end;

      self.bottomBarView.trailingBarButtonItems := trailingBarButtonItems;

      for each barButtonItem in self.bottomBarView.trailingBarButtonItems do
      begin

        var newImage := barButtonItem.image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);
        barButtonItem.image := newImage;
        barButtonItem.tintColor := selectedColor;

      end;


      self.bottomBarView.floatingButton.applySecondaryThemeWithScheme(containerScheme);
      MDCBottomAppBarColorThemer.applySurfaceVariantWithSemanticColorScheme(self.colorScheme) toBottomAppBarView(self.bottomBarView);

      self.bottomBarView.floatingButton.addTarget(self) action(selector(didTapFloatingButton:)) forControlEvents(UIControlEvents.UIControlEventTouchUpInside);

      self.view.addSubview(bottomBarView);
    end;

    method didTapFloatingButton(sender:id); virtual;
    begin
      NSLog('tapped floating button');
    end;

    method layoutBottomAppBar;
    begin
      var size := sizeThatFits;
      var bottomBarViewFrame: CGRect := CGRectMake(0, CGRectGetHeight(self.view.bounds) - size.height, size.width, size.height);
      bottomBarView.frame := bottomBarViewFrame;
    end;

    property sizeThatFits:CGSize read
      begin
        exit bottomBarView.sizeThatFits(self.view.bounds.size);
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

    method viewWillAppear(animated: BOOL); override;
    begin
      inherited viewWillAppear(animated);

      if(self.navigationController.toolbarHidden = false)then
      begin
        self.navigationController.toolbarHidden := true;
      end;
    end;

    method uiElementAboveAppBar:UIView; virtual;
    begin
      exit nil;
    end;

    method updateViewConstraints; override;
    begin
      if(not assigned(someConstraint))then
      begin
        var someElement := uiElementAboveAppBar;
        var constant := self.bottomBarView.floatingButton.frame.size.width / 2;

        someConstraint := NSLayoutConstraint.constraintWithItem(someElement) attribute(NSLayoutAttribute.Bottom)
          relatedBy(NSLayoutRelation.NSLayoutRelationEqual) toItem(self.bottomBarView) attribute(NSLayoutAttribute.Top) multiplier(1) constant(constant);

        self.view.addConstraint(someConstraint);
      end;

      inherited updateViewConstraints;
    end;

  end;

end.