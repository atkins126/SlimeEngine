object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 985
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnMouseDown = mdf
  OnResize = resiz
  PixelsPerInch = 96
  TextHeight = 13
  object CB: TColorListBox
    Left = 0
    Top = 47
    Width = 121
    Height = 97
    TabOrder = 0
  end
  object SB: TScrollBar
    Left = 32
    Top = 0
    Width = 265
    Height = 17
    Max = 500
    PageSize = 0
    Position = 100
    TabOrder = 1
  end
  object SA: TScrollBar
    Left = 32
    Top = 23
    Width = 89
    Height = 17
    Max = 255
    PageSize = 1
    Position = 255
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Left = 128
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Blending'
    TabOrder = 3
  end
  object Button1: TButton
    Left = 231
    Top = 23
    Width = 66
    Height = 25
    Caption = 'Clear'
    TabOrder = 4
    OnClick = clr
  end
  object Timer1: TTimer
    Interval = 10
    OnTimer = Timer1Timer
  end
end
