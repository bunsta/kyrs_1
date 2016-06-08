object Form5: TForm5
  Left = 223
  Top = 191
  Width = 747
  Height = 380
  Caption = #1047#1059#1055#1048#1053#1050#1048
  Color = clTeal
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 320
    Top = 16
    Width = 118
    Height = 33
    Caption = #1047#1059#1055#1048#1053#1050#1048
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object StringGrid1: TStringGrid
    Left = 40
    Top = 64
    Width = 681
    Height = 161
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 0
    OnKeyDown = StringGrid1KeyDown
    ColWidths = (
      64
      261
      101
      105
      103)
  end
  object Button1: TButton
    Left = 40
    Top = 264
    Width = 129
    Height = 25
    Caption = #1089#1087#1080#1089#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 264
    Width = 115
    Height = 25
    Caption = #1079#1072#1087#1080#1089#1072#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 384
    Top = 264
    Width = 201
    Height = 25
    Caption = #1074#1080#1076#1072#1083#1080#1090#1080' '#1088#1103#1076#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 592
    Top = 264
    Width = 49
    Height = 21
    TabOrder = 4
  end
  object Button4: TButton
    Left = 624
    Top = 304
    Width = 75
    Height = 25
    Caption = #1085#1072#1079#1072#1076
    TabOrder = 5
    OnClick = Button4Click
  end
end
