unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1,Unit2,Unit3,Unit5;

{$R *.dfm}

type marsh = record
    pochatok:string[25];
    kinec:string[25];
    nomer_marsh:string[4];
    k_zupinok:string[4];
//    chas:integer;
end;


procedure TForm4.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[1, 0] := 'Початкова зупинка';
  StringGrid1.Cells[2, 0] := 'Кінцева зупинка';
  StringGrid1.Cells[3, 0] := 'Номер маршруту';
  StringGrid1.Cells[4, 0] := 'Кількість зупинок';
end;


        //чи пустий рядок
function RowIsEmpty(aSg : TStringGrid; aRow : Integer) : Boolean;
var
  Col : Integer;
begin
  Result := True;
  for Col := aSg.FixedCols to aSg.ColCount - 1 do begin
    if aSg.Cells[Col, aRow] <> '' then begin
      Result := False;
      Break;
    end;
  end;
end;

       //добавляє чи видаляє пустий нижній рядок
procedure TForm4.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Sg: TStringGrid;
begin
  Sg:= Sender as TStringGrid;
  case Key of
    VK_UP :
    begin
      if
        (Sg.Selection.Bottom = Sg.RowCount - 1)
        and (Sg.Selection.Bottom <> Sg.FixedRows)
        and RowIsEmpty(Sg, Sg.Selection.Bottom)
      then begin
        Sg.RowCount := Sg.RowCount - 1;
      end;
    end;
    VK_DOWN :
    begin
      if
        (Sg.Selection.Bottom = Sg.RowCount - 1)
        and ( not RowIsEmpty(Sg, Sg.Selection.Bottom) )
      then begin
        Sg.RowCount := Sg.RowCount + 1;
      end;
    end;
  end;
end;

       //вивести список
procedure TForm4.Button1Click(Sender: TObject);
var mr:marsh;
    m:file of marsh;
    row,col: integer;
begin
if not fileExists('m.txt') then begin
    ShowMessage('файл відсутній, спочатку запишіть');
    exit;
  end;
assignfile(m,'m.txt');
reset(m);
  row:= StringGrid1.FixedRows-1;
  col:= StringGrid1.FixedCols;
  while not eof(m) do begin
    inc(row);
    if row= StringGrid1.RowCount then StringGrid1.RowCount:= StringGrid1.RowCount+ 1;
    read(m, mr);
    StringGrid1.Cells[col-1, row]:= FloatToStr(row);
    StringGrid1.Cells[col, row]:= mr.pochatok;
    StringGrid1.Cells[col+1, row]:= mr.kinec;
    StringGrid1.Cells[col+2, row]:= mr.nomer_marsh;
    StringGrid1.Cells[col+3, row]:= mr.k_zupinok;
  end;
  StringGrid1.RowCount:= row+1;
  closeFile(m);
end;





     //записати
procedure TForm4.Button2Click(Sender: TObject);
var mr:marsh;
    m:file of marsh;
    row,col: integer;
begin
assignFile(m,'m.txt');
  rewrite(m);
  col:= StringGrid1.FixedCols;
  for row:= StringGrid1.FixedRows to StringGrid1.RowCount - 1 do begin
    if RowIsEmpty(StringGrid1, row) then Continue;
    mr.pochatok:= StringGrid1.Cells[col, row];
    mr.kinec:= StringGrid1.Cells[col+1, row];
    mr.nomer_marsh:= StringGrid1.Cells[col+2, row];
    mr.k_zupinok:= StringGrid1.Cells[col+3, row];
    write(m, mr);
  end;
  closeFile(m);
end;

        //видалити рядок за номером
procedure TForm4.Button3Click(Sender: TObject);
var
  m, mTmp: file of marsh;
  mnTmp: string;
  mr: marsh;
  num,aNum: integer;
begin
  mnTmp:= 'm.txt' + '~';
  assignFile(mTmp, 'm.txt');
  rename(mTmp, mnTmp);
  reset(mTmp);
  assignFile(m,'m.txt');
  rewrite(m);
  aNum:=StrToInt(Edit1.Text);
  num:= 0;
  while not eof(mTmp) do begin
    inc(num);
    read(mTmp, mr);
    if num= aNum then continue;
    write(m, mr);
  end;
  closeFile(m);
  closeFile(mTmp);
  erase(mTmp);
  showMessage('рядок видалено');
end;


procedure TForm4.Button4Click(Sender: TObject);
begin
Close;
end;

end.

