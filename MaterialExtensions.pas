namespace Moshine.UI.UIKit.Material;

uses
  MaterialComponents,
  PureLayout,
  UIKit;

type
  MaterialExtensions = public extension class(UIViewController)
  public

    method addFloatingButton(imageNamed:String) withOffsetRight(bottomOffset:Integer := 100; rightOffset:Integer := 50):MDCFloatingButton;
    begin
      var addImage := UIImage.imageNamed(imageNamed).imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);

      var someButton := new MDCFloatingButton;

      someButton.setImage(addImage) forState(UIControlState.Normal);
      someButton.frame := CGRectMake(0, 0, 48, 48);
      self.view.addSubview(someButton);
      someButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom) withInset(bottomOffset);
      someButton.autoPinEdgeToSuperviewEdge(ALEdge.Right) withInset(rightOffset);
      exit someButton;

    end;

    method addFloatingButton(imageNamed:String) withOffsetLeft(bottomOffset:Integer := 100; leftOffset:Integer := 50):MDCFloatingButton;
    begin
      var addImage := UIImage.imageNamed(imageNamed).imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);

      var someButton := new MDCFloatingButton;

      someButton.setImage(addImage) forState(UIControlState.Normal);
      someButton.frame := CGRectMake(0, 0, 48, 48);
      self.view.addSubview(someButton);
      someButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom) withInset(bottomOffset);
      someButton.autoPinEdgeToSuperviewEdge(ALEdge.Left) withInset(leftOffset);
      exit someButton;

    end;



  end;
end.