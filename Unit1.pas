unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, sSkinManager, sLabel;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    sSkinManager1: TsSkinManager;
    sLabel1: TsLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2,Unit3,Unit4,Unit5;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
Form2.ShowModal;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Form3.Show;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Form4.Show;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Form5.Show;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
sskinmanager1.skinname:=' Steam ';
end;

end.

