object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'SlimeEngine Program'
  ClientHeight = 457
  ClientWidth = 799
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnMouseDown = onmd
  OnPaint = FormPaint
  OnResize = res
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 143
    Top = 6
    Width = 151
    Height = 13
    Caption = 'LMB - add block , RMB - DELETE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 300
    Top = 6
    Width = 118
    Height = 13
    Caption = 'Engine version 0.1 alpha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 424
    Top = 6
    Width = 55
    Height = 13
    Caption = 'By UtoECat'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ColorListBox1: TColorListBox
    Left = 0
    Top = 55
    Width = 137
    Height = 97
    TabOrder = 0
  end
  object alphabar: TScrollBar
    Left = 50
    Top = 3
    Width = 87
    Height = 23
    Max = 255
    PageSize = 0
    Position = 255
    TabOrder = 1
  end
  object Button1: TButton
    Left = 0
    Top = 1
    Width = 49
    Height = 25
    Caption = 'Clear'
    TabOrder = 2
    OnClick = Button1Click
  end
  object SCROLLBAR1: TScrollBar
    Left = 0
    Top = 32
    Width = 137
    Height = 17
    Max = 255
    PageSize = 0
    TabOrder = 3
  end
  object ZBAR: TScrollBar
    Left = 143
    Top = 25
    Width = 336
    Height = 17
    Max = 255
    PageSize = 0
    TabOrder = 4
  end
  object CheckBox1: TCheckBox
    Left = 143
    Top = 48
    Width = 97
    Height = 17
    Caption = 'Blending'
    TabOrder = 5
  end
  object Timer1: TTimer
    Interval = 10
    OnTimer = ont
    Top = 152
  end
end
