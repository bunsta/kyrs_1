unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TForm5 = class(TForm)
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
  Form5: TForm5;

implementation

uses Unit2,Unit3,Unit4,Unit1;

{$R *.dfm}

type zupinki = record
    nazva:string[20];
    nomer_marsh:string[4];
    prib:string[5];
    vidpr:string[5];
end;


procedure TForm5.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[1, 0] := 'Назва зупинки';
  StringGrid1.Cells[2, 0] := 'Номер маршруту';
  StringGrid1.Cells[3, 0] := 'Прибуття';
  StringGrid1.Cells[4, 0] := 'Відправлення';
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
procedure TForm5.StringGrid1KeyDown(Sender: TObject; var Key: Word;
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
procedure TForm5.Button1Click(Sender: TObject);
var zr:zupinki;
    z:file of zupinki;
    row,col: integer;
begin
if not fileExists('z.txt') then begin
    ShowMessage('файл відсутній, спочатку запишіть');
    exit;
  end;
assignfile(z,'z.txt');
reset(z);
  row:= StringGrid1.FixedRows-1;
  col:= StringGrid1.FixedCols;
  while not eof(z) do begin
    inc(row);
    if row= StringGrid1.RowCount then StringGrid1.RowCount:= StringGrid1.RowCount+ 1;
    read(z, zr);
    StringGrid1.Cells[col-1, row]:= FloatToStr(row);
    StringGrid1.Cells[col, row]:= zr.nazva;
    StringGrid1.Cells[col+1, row]:= zr.nomer_marsh;
    StringGrid1.Cells[col+2, row]:= zr.prib;
    StringGrid1.Cells[col+3, row]:= zr.vidpr;
  end;
  StringGrid1.RowCount:= row+1;
  closeFile(z);
end;





     //записати
procedure TForm5.Button2Click(Sender: TObject);
var zr:zupinki;
    z:file of zupinki;
    row,col: integer;
begin
assignFile(z,'z.txt');
  rewrite(z);
  col:= StringGrid1.FixedCols;
  for row:= StringGrid1.FixedRows to StringGrid1.RowCount - 1 do begin
    if RowIsEmpty(StringGrid1, row) then Continue;
    zr.nazva:= StringGrid1.Cells[col, row];
    zr.nomer_marsh:= StringGrid1.Cells[col+1, row];
    zr.prib:= StringGrid1.Cells[col+2, row];
    zr.vidpr:= StringGrid1.Cells[col+3, row];
    write(z, zr);
  end;
  closeFile(z);
end;

        //видалити рядок за номером
procedure TForm5.Button3Click(Sender: TObject);
var
  z, zTmp: file of zupinki;
  znTmp: string;
  zr: zupinki;
  num,aNum: integer;
begin
  znTmp:= 'z.txt' + '~';
  assignFile(zTmp, 'z.txt');
  rename(zTmp, znTmp);
  reset(zTmp);
  assignFile(z,'z.txt');
  rewrite(z);
  aNum:=StrToInt(Edit1.Text);
  num:= 0;
  while not eof(zTmp) do begin
    inc(num);
    read(zTmp, zr);
    if num= aNum then continue;
    write(z, zr);
  end;
  closeFile(z);
  closeFile(zTmp);
  erase(zTmp);
  showMessage('рядок видалено');
end;


procedure TForm5.Button4Click(Sender: TObject);
begin
Close;
end;


end.
