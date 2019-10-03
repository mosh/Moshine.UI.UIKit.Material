﻿namespace Moshine.UI.UIKit.Material;

uses
  MaterialComponents,
  PureLayout,
  UIKit;

type
  MaterialExtensions = public extension class(UIViewController)
  public

    method addFloatingButton(imageNamed:String):MDCFloatingButton;
    begin
      var addImage := UIImage.imageNamed(imageNamed).ImageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);;

      var someButton := new MDCFloatingButton;

      someButton.setImage(addImage) forState(UIControlState.Normal);
      someButton.frame := CGRectMake(0, 0, 48, 48);
      self.view.addSubview(someButton);
      someButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom) withInset(100);
      someButton.autoPinEdgeToSuperviewEdge(ALEdge.Right) withInset(50);
      //someButton.autoAlignAxisToSuperviewAxis(ALAxis.horizontal);

      exit someButton;

    end;
  end;
end.