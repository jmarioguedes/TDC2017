unit Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Regras;

procedure TForm1.Button1Click(Sender: TObject);
begin
  dmRegras.AbrirConexaoREDIS;
  Self.Button1.Enabled := False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  dmRegras.AbrirConexaoREST(StrToInt(Self.ComboBox1.Text));
  Self.Button2.Enabled := False;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  dmRegras.AbrirConexaoMONGO;
  Self.Button3.Enabled := False;
end;

end.
