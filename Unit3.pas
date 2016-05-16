unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TForm3 = class(TForm)
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
  Form3: TForm3;

implementation

uses Unit1,Unit2,Unit4,Unit5;

{$R *.dfm}

type avto = record
    model:string[20];
    stan:string[25];
    nomer_bus:string[4];
    nomer_marsh:string[4];
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[1, 0] := 'Модель автомобіля';
  StringGrid1.Cells[2, 0] := 'Технічний стан';
  StringGrid1.Cells[3, 0] := 'Номер буса';
  StringGrid1.Cells[4, 0] := 'Номер маршрута';
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
procedure TForm3.StringGrid1KeyDown(Sender: TObject; var Key: Word;
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
procedure TForm3.Button1Click(Sender: TObject);
var av:avto;
    a:file of avto;
    row,col: integer;
begin
if not fileExists('a.txt') then begin
    ShowMessage('файл відсутній, спочатку запишіть');
    exit;
  end;
assignfile(a,'a.txt');
reset(a);
  row:= StringGrid1.FixedRows-1;
  col:= StringGrid1.FixedCols;
  while not eof(a) do begin
    inc(row);
    if row= StringGrid1.RowCount then StringGrid1.RowCount:= StringGrid1.RowCount+ 1;
    read(a, av);
    StringGrid1.Cells[col-1, row]:= FloatToStr(row);
    StringGrid1.Cells[col, row]:= av.model;
    StringGrid1.Cells[col+1, row]:= av.stan;
    StringGrid1.Cells[col+2, row]:= av.nomer_bus;
    StringGrid1.Cells[col+3, row]:= av.nomer_marsh;
  end;
  StringGrid1.RowCount:= row+1;
  closeFile(a);
end;


     //записати
procedure TForm3.Button2Click(Sender: TObject);
var av:avto;
    a:file of avto;
    row,col: integer;
begin
assignFile(a,'a.txt');
  rewrite(a);
  col:= StringGrid1.FixedCols;
  for row:= StringGrid1.FixedRows to StringGrid1.RowCount - 1 do begin
    if RowIsEmpty(StringGrid1, row) then Continue;
    av.model:= StringGrid1.Cells[col, row];
    av.stan:= StringGrid1.Cells[col+1, row];
    av.nomer_bus:= StringGrid1.Cells[col+2, row];
    av.nomer_marsh:= StringGrid1.Cells[col+3, row];
    write(a, av);
  end;
  closeFile(a);
end;

        //видалити рядок за номером
procedure TForm3.Button3Click(Sender: TObject);
var
  a, aTmp: file of avto;
  anTmp: string;
  av: avto;
  num,aNum: integer;
begin
  anTmp:= 'a.txt' + '~';
  assignFile(aTmp, 'a.txt');
  rename(aTmp, anTmp);
  reset(aTmp);
  assignFile(a,'a.txt');
  rewrite(a);
  aNum:=StrToInt(Edit1.Text);
  num:= 0;
  while not eof(aTmp) do begin
    inc(num);
    read(aTmp, av);
    if num= aNum then continue;
    write(a, av);
  end;
  closeFile(a);
  closeFile(aTmp);
  erase(aTmp);
  showMessage('рядок видалено');
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
Close;
end;

end.


