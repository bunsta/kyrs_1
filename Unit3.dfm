object Form3: TForm3
  Left = 146
  Top = 146
  Width = 870
  Height = 640
  Caption = #1040#1042#1058#1054#1052#1054#1041#1030#1051#1030
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
    Left = 352
    Top = 16
    Width = 161
    Height = 33
    Caption = #1040#1042#1058#1054#1052#1054#1041#1030#1051#1030
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
      155
      122
      120
      88)
  end
  object Button1: TButton
    Left = 40
    Top = 368
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
    Top = 368
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
    Top = 368
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
  object Button4: TButton
    Left = 640
    Top = 432
    Width = 75
    Height = 25
    Caption = #1085#1072#1079#1072#1076
    TabOrder = 4
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 640
    Top = 368
    Width = 49
    Height = 21
    TabOrder = 5
  end
end
