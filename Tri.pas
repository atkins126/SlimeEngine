unit Tri;

interface

uses
  OpenGL, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls,SlimeEngine;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    ColorListBox1: TColorListBox;
    alphabar: TScrollBar;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SCROLLBAR1: TScrollBar;
    ZBAR: TScrollBar;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure onmd(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure res(Sender: TObject);
    procedure ont(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;
  mouseobj : SlimeEngine.TSEObject; // your small mouse :D

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
SLIMEENGINE.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
SlimeEngine.Create(Form1,Handle);
mouseobj.tr.SX := 1;
mouseobj.tr.SY := 1;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
   SlimeEngine.Draw; // big f****in brain
end;

procedure TForm1.onmd(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
  var obj : SlimeEngine.TSEObject; c,i : integer;
begin
  if Button = mbLeft then
 begin
 obj.tr.X := X;
 obj.tr.Y := Y;
 obj.tr.SX := Scrollbar1.Position;
 obj.tr.SY := Scrollbar1.Position;
 c := ColorToRGB(ColorListBox1.Selected);
 obj.Color.r := GetRValue(c);
 obj.Color.G := GetGValue(c);
 obj.Color.B := GetBValue(c);
 obj.Color.A := AlphaBar.Position;
 if checkbox1.State = cbUnchecked then
 begin
 obj.Color.L := false;
 end else
 begin
  obj.Color.L := true;
 end;
 obj.tr.Z := ZBAR.Position;
 SlimeEngine.Add(obj);
 Form1.Caption := InttoStr(Length(GameScene));
 end else if Button = mbRight then
  begin
  mouseobj.tr.X := X;
  mouseobj.tr.Y := Y;
  i := SlimeEngine.CollisionAll(mouseobj);
  SlimeEngine.Delete(i);
  end;
end;

procedure TForm1.ont(Sender: TObject);
begin
SlimeEngine.Draw;
end;

procedure TForm1.res(Sender: TObject);

begin
glViewport(0,0,Form1.Width,Form1.Height);
 glMatrixMode(GL_PROJECTION);
 glLoadidentity;
glOrtho (0,Form1.Width,Form1.Height,0,-500,500);
 glMatrixMode(GL_Modelview);
 glloadidentity;
end;

end.
