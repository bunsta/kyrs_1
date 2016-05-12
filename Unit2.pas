unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TForm2 = class(TForm)
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
  Form2: TForm2;

implementation

uses Unit1,Unit3,Unit4,Unit5;

{$R *.dfm}

 type 
  vodii = record
    fio:string[20];
    adresa:string[25];
    telefon:string[10];
    nomer_bus:string[4];
  end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[1, 0] := 'Прізвище,ім"я,по батькові';
  StringGrid1.Cells[2, 0] := 'Адреса проживання';
  StringGrid1.Cells[3, 0] := 'Телефон';
  StringGrid1.Cells[4, 0] := 'Номер буса';
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
procedure TForm2.StringGrid1KeyDown(Sender: TObject; var Key: Word;
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
procedure TForm2.Button1Click(Sender: TObject);
var r:vodii;
    v:file of vodii;
    row,col: integer;
begin
if not fileExists('v.txt') then begin
    ShowMessage('файл відсутній, спочатку запишіть');
    exit;
  end;
assignfile(v,'v.txt');
reset(v);
  row:= StringGrid1.FixedRows-1;
  col:= StringGrid1.FixedCols;
  while not eof(v) do begin
    inc(row);
    if row= StringGrid1.RowCount then StringGrid1.RowCount:= StringGrid1.RowCount+ 1;
    read(v, r);
    StringGrid1.Cells[col-1, row]:= FloatToStr(row);
    StringGrid1.Cells[col, row]:= r.fio;
    StringGrid1.Cells[col+1, row]:= r.adresa;
    StringGrid1.Cells[col+2, row]:= r.telefon;
    StringGrid1.Cells[col+3, row]:= r.nomer_bus;
  end;
  StringGrid1.RowCount:= row+1;
  closeFile(v);
end;





     //записати
procedure TForm2.Button2Click(Sender: TObject);
var r:vodii;
    v:file of vodii;
    row,col: integer;
begin
assignFile(v,'v.txt');
//if fileExists('v.txt') then reset(v) else rewrite(v);
  rewrite(v);
  col:= StringGrid1.FixedCols;
  for row:= StringGrid1.FixedRows to StringGrid1.RowCount - 1 do begin
    if RowIsEmpty(StringGrid1, row) then Continue;
    r.fio:= StringGrid1.Cells[col, row];
    r.adresa:= StringGrid1.Cells[col+1, row];
    r.telefon:= StringGrid1.Cells[col+2, row];
    r.nomer_bus:= StringGrid1.Cells[col+3, row];
    write(v, r);
  end;
  closeFile(v);
end;

        //видалити рядок за номером
procedure TForm2.Button3Click(Sender: TObject);
var
  v, vTmp: file of vodii;
  vnTmp: string;
  r: vodii;
  num,aNum: integer;
begin
  vnTmp:= 'v.txt' + '~';
  assignFile(vTmp, 'v.txt');
  rename(vTmp, vnTmp);
  reset(vTmp);
  assignFile(v,'v.txt');
  rewrite(v);
  aNum:=StrToInt(Edit1.Text);
  num:= 0;
  while not eof(vTmp) do begin
    inc(num);
    read(vTmp, r);
    if num= aNum then continue;
    write(v, r);
  end;
  closeFile(v);
  closeFile(vTmp);
  erase(vTmp);
  showMessage('рядок видалено');
end;


{procedure TForm2.Button3Click(Sender: TObject);
var
  buttonSelected:integer;
  v:file of vodii;
begin
buttonSelected:=MessageDlg('очистити файл? Всі дані будуть втрачені!',mtWarning, [mbYes,mbCancel], 0);
if buttonSelected = mrYes then begin
  assignFile(v,'v.txt');
  rewrite(v);
  closeFile(v);
end;
end;}


procedure TForm2.Button4Click(Sender: TObject);
begin
Close;
end;

end.
