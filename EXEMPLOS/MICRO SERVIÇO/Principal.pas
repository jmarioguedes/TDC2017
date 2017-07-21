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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Redis.netlib.INDY,
  Redis.Client;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Redis: TRedisClient;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Self.Redis := TRedisClient.Create('127.0.0.1', 6379, 'indy');
  Self.Redis.Connect;
  Self.Memo1.Text := 'CONECTADO AO REDIS!';
  Self.Timer1.Enabled := True;
  Self.Button1.Enabled := False;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  sValue: string;
  bRet: Boolean;
begin
  bRet := Self.Redis.RPOP('TAREFAS', sValue);

  if bRet then
  begin
    Self.Memo1.Lines.Insert(0, Format('Processando QUALQUER COISA do Consumidor: %s', [sValue]));
  end;
end;

end.
