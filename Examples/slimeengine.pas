{
  Slime engine - New cool Game Engine that writted in Delphi 10.3 :D (INDEV)
  License : GPL-3.0
  By UtoECat :DD
  Delphi : 10.3

Thanks to :
Zedxxx (https://www.sql.ru/forum/memberinfo.aspx?mid=263077) - he help me with array
}
unit SlimeEngine;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Math, OpenGL;

   type TTransform = record
    X,Y,Z,SX,SY,R : integer;
   end;

   type T2COLOR = record
    R : byte; G : byte; B : byte; A : byte; L : boolean;
   end;

   type TSEObject = record
    tr : TTransform ; ID : integer;Parent : integer;
     Color : T2COLOR;
   end;

   type TSEArray = array of TSEobject;

   

   procedure CREATE (Handle:HWND);
   procedure DESTROY ();
   procedure ADD ( obj : TSEOBJECT; var scene : TSEARRAY);
   procedure DELETE (ID : integer; var scene : TSEARRAY);
   procedure CLEAR (var scene : TSEARRAY);
   procedure DRAW (var scene : TSEARRAY);
   procedure GAMETICK(var scene : TSEARRAY);
   Procedure DRAWSORT();
   function CollisionAll (obj : TSEOBJECT;var scene : TSEARRAY): integer;
   function Collision2 (obj, obj2 : TSEOBJECT):boolean;
   procedure sPixelFormat (DC : HDC);
   procedure resizevp (w : integer; h:integer; i : boolean);
   procedure resizeconst(x,y : integer);
   function CollisionAllIndex (obj : TSEOBJECT;var scene : TSEARRAY;ind:integer): integer;

   

     type TSEParent = class (TObject) // Parent Pattern (License GPL-3.0 by ME :DD )
    function Process(i : integer ;var scene : TSEArray):TSEOBJECT;Virtual;
    procedure Draw (obj : TSEOBJECT;var scene : TSEArray);Virtual;
    function Collision (obj, obj2 : TSEOBJECT):boolean;virtual;
    var hitboxid : integer;
     end;

    type TSEParentArray = array of TSEPARENT;

       var
    Init : boolean; systemtime : longint; CAMX,CAMY:integer;

     scene : TSEARRAY;

     parents : TSEParentArray;
     crx, cry : integer;
      PBlock : TSEPARENT;
  IMPLEMENTATION
 function TSEParent.Process(i : integer;var scene : TSEArray):TSEOBJECT;// Parent gameprocess collision procedure
var l : TSEOBJECT;
 begin
 result := scene[i];
 end;

 procedure TSEParent.Draw(obj:TSEObject;var scene : TSEArray);// Parent deafult draw procedure
 begin if obj.Color.l then glEnable(GL_BLEND) else glDisable(GL_BLEND);
 glColor(obj.Color.r/255,obj.Color.g/255,obj.Color.b/255,obj.Color.a/255); //color
 glBegin(GL_Polygon);glVertex3f(obj.tr.x,obj.tr.y,obj.tr.z);glVertex3f(obj.tr.x+obj.tr.sx,obj.tr.y,obj.tr.z);
 glVertex3f(obj.tr.x+obj.tr.sx,obj.tr.y+obj.tr.sy,obj.tr.z);glVertex3f(obj.tr.x,obj.tr.y+obj.tr.sy,obj.tr.z);
 glEnd;
 end;

 function TSEParent.Collision (obj, obj2 : TSEOBJECT):boolean; // Parent deafult collision procedure
 begin
 result := false;
 { case obj2.Parent of
  0, 1 :
   begin}
   if ((obj2.tr.X > obj.tr.X - obj2.tr.SX) and (obj2.tr.X< obj.tr.X+obj.tr.SX))and((obj2.tr.Y>
   obj.tr.Y-obj2.tr.SY)and(obj2.tr.Y<obj.tr.Y+obj.tr.SY)) then result := true;
   {end;
  else result := false
  end; }
 end;

  procedure sPixelFormat(DC:HDC);
const
   pfd:TPIXELFORMATDESCRIPTOR = (
        nSize:sizeof(TPIXELFORMATDESCRIPTOR);	// size
        nVersion:1;			// version
        dwFlags:PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or
                PFD_DOUBLEBUFFER;	// support double-buffering
        iPixelType:PFD_TYPE_RGBA;	// color type
        cColorBits:24;			// preferred color depth
        cRedBits:0; cRedShift:0;	// color bits (ignored)
        cGreenBits:0;  cGreenShift:0;
        cBlueBits:0; cBlueShift:0;
        cAlphaBits:0;  cAlphaShift:0;   // no alpha buffer
        cAccumBits: 0;
        cAccumRedBits: 0;  		// no accumulation buffer,
        cAccumGreenBits: 0;     	// accum bits (ignored)
        cAccumBlueBits: 0;
        cAccumAlphaBits: 0;
        cDepthBits:16;			// depth buffer
        cStencilBits:0;			// no stencil buffer
        cAuxBuffers:0;			// no auxiliary buffers
        iLayerType:PFD_MAIN_PLANE;  	// main layer
   bReserved: 0;
   dwLayerMask: 0;
   dwVisibleMask: 0;
   dwDamageMask: 0;                    // no layer, visible, damage masks
   ); var pixelFormat:integer;
begin
   pixelFormat := ChoosePixelFormat(DC, @pfd);
   if (pixelFormat = 0) then
        exit;
   if (SetPixelFormat(DC, pixelFormat, @pfd) <> TRUE) then
        exit;
end;

procedure GLInit;
begin
glMatrixMode(GL_PROJECTION);//viewing projection set
glOrtho (0,300,300,0,-500,500); // orthogonical projection
glMatrixMode(GL_MODELVIEW); // modelview
glEnable(GL_COLOR_MATERIAL);  //enable flags (color)
glEnable(GL_BLEND);      // blending color
glBlendFunc(GL_SRC_ALPHA,GL_DST_ALPHA);   // set blenging properties
end;

procedure Create(Handle : HWND);
var DC:HDC;
    RC:HGLRC;
begin
DC:=GetDC(Handle);        //Actually, you can use any windowed control here
SPixelFormat(DC);
RC:=wglCreateContext(DC); //makes OpenGL window out of DC
wglMakeCurrent(DC, RC);   //makes OpenGL window active
GLInit;
glEnable(GL_COLOR);                   //initialize OpenGL
SetLENGTH (parents,1);
PBlock := TSEParent.Create;
parents[0]:=Pblock;
end;

   procedure Add (obj : TSEOBJECT; var scene : TSEARRAY);  //add object
   var
   l : integer;
   begin
     {$R-}
     Systemtime:=systemtime+1;
     l := Length(scene);
     SetLength(scene, l + 1);
     obj.ID := systemtime;
     Scene[l] := obj;
     {$R+}
   end;

   procedure Delete (ID : integer; var scene : TSEARRAY); //delete object
   var
   last : integer;
     begin
      if ID > 0 then
       begin
       {$R-}
       Last:= high( scene );
       if ID <  Last then move( scene[ID+1], scene[ ID ],
       (Last-ID) * sizeof( scene[ID] )  );
       setLength( scene, Last );
       {$R+}
       end;
     end;

   procedure Clear (var scene : TSEARRAY);  // clear scene
     begin
     scene := nil;
     SetLength(Scene,1);
     end;

   procedure Destroy ();  // destroy myself :D (joke)
     begin
     end;

   procedure GameTick (var scene : TSEARRAY); // \-._.-/
    var i : integer;
     begin
     i := 0;
     for i := 0 to Length(Scene)-1 do
      begin
      scene[i]:=parents[scene[i].Parent].Process(i,scene);
      end;
     end;

    function CollisionAll (obj : TSEOBJECT;var scene : TSEARRAY):integer;
    var
    i : integer; obj2 : TSEOBJECT;
    begin
    result := 0;
    for i := 0 to Length(Scene)-1 do
      begin
      obj2 := Scene [i];
      if Collision2(obj,obj2) then
       begin
       result := i;
       break
       end ;
      end;
    end;
    function CollisionAllIndex (obj : TSEOBJECT;var scene : TSEARRAY;ind:integer):integer;
    var
    i : integer; obj2 : TSEOBJECT;
    begin
    result := 0;
      for i := 0 to Length(Scene)-1 do if i <> ind then begin
      obj2 := Scene [i];
      if Collision2(obj,obj2) then
       begin
       result := i;
       break
       end ;
      end;
    end;
    function Collision2 (obj, obj2 : TSEOBJECT) : boolean;  //collision 2 objects
    begin
    result := parents[obj.Parent].Collision(obj,obj2); // lolxd
    end;

    procedure draw(var scene : TSEARRAY);
      var i : integer;
      obj : TSEObject;
   begin
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
   glLoadIdentity;glpushmatrix;
   for i := 0 to Length(Scene)-1 do begin obj := Scene[i]; parents[obj.Parent].Draw(obj,Scene); end;
   glpopmatrix; SwapBuffers(wglGetCurrentDC);
    end;

 procedure drawsort();
 begin

 end;  // I WILL MAKE IT LATER :D

 procedure resizevp (w : integer; h:integer;i : boolean);
 begin glMatrixMode(GL_PROJECTION); glLoadIdentity();
 if i then glOrtho (0,w,h,0,-500,500);
 glMatrixMode(GL_MODELVIEW);glViewport(-crx, -cry, w, h);glLoadIdentity;
 end;

 procedure resizeconst (x,y : integer);
 begin
  crx := x; cry := y;
 end;


 end.
//go home!
