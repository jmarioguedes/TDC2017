unit Regras;

interface

uses
  System.SysUtils,
  System.Classes,
  Redis.Commons,
  Redis.NetLib.INDY,
  Redis.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MongoDB,
  FireDAC.Phys.MongoDBDef,
  System.Rtti,
  System.JSON.Types,
  System.JSON.Readers,
  System.JSON.BSON,
  System.JSON.Builders,
  FireDAC.Phys.MongoDBWrapper,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  Data.DB,
  FireDAC.Comp.Client,
  IPPeerServer,
  Datasnap.DSCommonServer,
  Datasnap.DSHTTP,
  Datasnap.DSServer,
  Datasnap.DSHTTPCommon,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Phys.MongoDBDataSet;

type
  TdmRegras = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMongoDriverLink1: TFDPhysMongoDriverLink;
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    DSHTTPService1: TDSHTTPService;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSHTTPService1HTTPTrace(Sender: TObject; AContext: TDSHTTPContext; ARequest: TDSHTTPRequest; AResponse: TDSHTTPResponse);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public
    ConMongo: TMongoConnection;
    Redis: TRedisClient;
    procedure AbrirConexaoREDIS;
    procedure AbrirConexaoMONGO;
    procedure AbrirConexaoREST(const APorta: Integer);
  end;

var
  dmRegras: TdmRegras;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses ExemploClasseRemota;
{$R *.dfm}
{ TDataModule1 }

procedure TdmRegras.AbrirConexaoMONGO;
begin
  // Abrindo conexão com o banco de dados
  Self.FDConnection1.Open();

  // Hacker!
  Self.ConMongo := TMongoConnection(Self.FDConnection1.CliObj);
end;

procedure TdmRegras.AbrirConexaoREDIS;
begin
  // Instanciando o conector com o REDIS
  Self.REDIS := TRedisClient.Create('127.0.0.1', 6379, 'indy');

  // Efetivando a conexão
  Self.REDIS.Connect;
end;

procedure TdmRegras.AbrirConexaoREST(const APorta: Integer);
begin
  // Atribuindo a porta HTTP
  Self.DSHTTPService1.HttpPort := APorta;

  // Iniciando o servidor DataStanp
  Self.DSServer1.Start;
end;

procedure TdmRegras.DataModuleDestroy(Sender: TObject);
begin
  Self.FDConnection1.Close;
  Self.Redis.Clone;
  Self.DSServer1.Stop;
end;

procedure TdmRegras.DSHTTPService1HTTPTrace(Sender: TObject; AContext: TDSHTTPContext; ARequest: TDSHTTPRequest; AResponse: TDSHTTPResponse);
var
  _injection: TDSHTTPResponseIndy;
begin
  _injection := TDSHTTPResponseIndy(AResponse);
  _injection.ResponseInfo.CustomHeaders.Values['PORTA-QUE-RESPONDEU'] := IntToStr(Self.DSHTTPService1.HttpPort);
end;

procedure TdmRegras.DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TPersistentClass(TConsumidor);
end;

end.
