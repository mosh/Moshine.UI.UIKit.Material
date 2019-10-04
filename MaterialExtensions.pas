namespace Moshine.UI.UIKit.Material;

uses
  MaterialComponents,
  PureLayout,
  UIKit;

type
  MaterialExtensions = public extension class(UIViewController)
  public

    method addFloatingButton(imageNamed:String; bottomOffset:Integer := 100; rightOffset:Integer := 50):MDCFloatingButton;
    begin
      var addImage := UIImage.imageNamed(imageNamed).ImageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);

      var someButton := new MDCFloatingButton;

      someButton.setImage(addImage) forState(UIControlState.Normal);
      someButton.frame := CGRectMake(0, 0, 48, 48);
      self.view.addSubview(someButton);
      someButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom) withInset(bottomOffset);
      someButton.autoPinEdgeToSuperviewEdge(ALEdge.Right) withInset(rightOffset);
      exit someButton;

    end;
  end;
end.