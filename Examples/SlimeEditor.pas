unit SlimeEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, slimeengine, Vcl.ExtCtrls, OpenGL,
  Vcl.StdCtrls {uses engine};

type
  TForm7 = class(TForm)
    Timer1: TTimer;
    CB: TColorListBox;
    SB: TScrollBar;
    SA: TScrollBar;
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure mdf(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure resiz(Sender: TObject);
    procedure clr(Sender: TObject);
  private
  public
  end;
var
  Form7: TForm7;
  col : longint;
  obj : TSEOBJECT;
  mobj : TSEOBJECT;
  i : integer;
       GameScene : TSEARRAY; // New Scene

implementation

{$R *.dfm}

procedure TForm7.clr(Sender: TObject);
begin
Clear(GameScene);
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
SlimeEngine.Create(Form7.Handle); // init engine
SetLength(GameScene,1); // WERY WORRY!!!
resizeconst(0,50); // change this, if it just bad. Its just move viewpoint constants
resizevp(Form7.Width,Form7.Height); // resize viewpoint
Timer1.Enabled := true;   //start draw timer
end;

procedure TForm7.mdf(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var c : integer;
begin
if Button = mbLeft then
 begin
 c := ColorToRGB(CB.Selected);
 obj.tr.SY := SB.Position; obj.tr.SX := SB.Position; obj.tr.X := X; obj.tr.Y := Y; obj.Color.A := SA.Position; //set params
 obj.Color.R := GetRValue(c) ;obj.Color.G := GetGValue(c);obj.Color.B := GetBValue(c);
  if CheckBox1.State = cbChecked then obj.Color.L:=true else obj.Color.L := false;

 SlimeEngine.ADD(obj,gamescene);  // add object
 end else if Button = mbRight then
 begin
 mobj.tr.X := x;
 mobj.tr.Y := y;
 i := CollisionAll(mobj,GameScene);
 Delete(i,GameScene);
 end;
end;



procedure TForm7.resiz(Sender: TObject);
begin
  resizevp(Form7.Width,Form7.Height);//resize view point
end;
procedure TForm7.Timer1Timer(Sender: TObject);
begin
SlimeEngine.DRAW(GameScene);
end;

end.
