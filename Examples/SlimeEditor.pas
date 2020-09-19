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
    CBP: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure mdf(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure resiz(Sender: TObject);
    procedure clr(Sender: TObject);
  private
  public
  end;

  type TSEPARENTPLAYER = class(TSEPARENT)
   function Process(i : integer;var scene : TSEArray):TSEOBJECT;override;
  end;

var
  Form7: TForm7;
  col : longint;
  obj : TSEOBJECT;
  mobj : TSEOBJECT;
  GameScene : TSEARRAY; // New Scene
  PPlayer : TSEParentPlayer;
  SDEBUG : string;

implementation

{$R *.dfm}
function TSEPARENTPLAYER.Process(i : integer; var scene: TSEArray):TSEOBJECT;
var obj2 : TSEOBJECT;
begin
obj2  := scene[i];
 if GetKeyState(87) < 0 then obj2.tr.Y := obj2.tr.Y  - 1  ;
  if GetKeyState(83) < 0 then obj2.tr.Y := obj2.tr.Y  + 1  ;
  if GetKeyState(	65) < 0 then obj2.tr.X := obj2.tr.X  - 1  ;
    if GetKeyState(	68) < 0 then obj2.tr.X := obj2.tr.X  + 1  ;
 if CollisionAllIndex(obj2,scene,i) > 0 then result := scene[i] else result := obj2;
end;
procedure TForm7.clr(Sender: TObject);
begin
Clear(GameScene);
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
SlimeEngine.Create(Form7.Handle); // init engine
SetLength(GameScene,1); // WERY WORRY!!!
resizeconst(0,50); // change this, if it just bad. Its just move viewpoint constants
resizevp(Form7.Width,Form7.Height,true); // resize viewpoint
Timer1.Enabled := true;   //start draw timer
PPlayer := TSEPARENTPlayer.CREATE;
setlength (parents,length(parents)+1);
parents [1] := pplayer;
end;

procedure TForm7.mdf(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var c,i : integer;
begin
if Button = mbLeft then
 begin

 if CBP.Checked = true then obj.Parent := 1 else obj.Parent := 0;

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
  resizevp(Form7.Width,Form7.Height,true);//resize view point
end;

procedure TForm7.Timer1Timer(Sender: TObject);
begin
gametick(GameScene);
SlimeEngine.DRAW(GameScene);
end;

end.
