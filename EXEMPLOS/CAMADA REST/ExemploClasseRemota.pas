unit ExemploClasseRemota;

interface

uses
  System.JSON;

type

{$METHODINFO ON}
  TConsumidor = class
  private
    // ...
  public

    // Verbo GET
    function Consumidor(const AID: Integer): TJSONValue;

    // Verbo PUT
    function AcceptConsumidor(AID: Integer; AConsumidor: TJSONValue): Boolean;

    // Verbo DELETE
    function CancelConsumidor(AID: Integer): Boolean;

    // Verbo POST
    function UpdateConsumidor(AConsumidor: TJSONValue): Boolean;

  end;
{$METHODINFO OFF}

implementation

{ TConsumidor }

uses Regras,
  System.SysUtils,
  FireDAC.Phys.MongoDBWrapper;

function TConsumidor.AcceptConsumidor(AID: Integer; AConsumidor: TJSONValue): Boolean;
var
  sChave: string;
begin
  sChave := Format('CONSUMIDOR:%d', [AID]);
  dmRegras.Redis.DEL(sChave);
  dmRegras.ConMongo['TDC2017']['CONSUMIDOR'].Update().Match().Add('ID', AID).&End.Modify('{"$set": ' + AConsumidor.ToJSON + '}').&End.Exec;
  Result := True;
end;

function TConsumidor.CancelConsumidor(AID: Integer): Boolean;
var
  sChave: string;
begin
  sChave := Format('CONSUMIDOR:%d', [AID]);
  dmRegras.ConMongo['TDC2017']['CONSUMIDOR'].Remove().Match().Add('ID', AID).&End.Exec;
  dmRegras.Redis.DEL(sChave);
  dmRegras.Redis.LPUSH('TAREFAS', IntToStr(AID));
  Result := True;
end;

function TConsumidor.Consumidor(const AID: Integer): TJSONValue;
var
  sChave: string;
  buffer: TMongoDocument;
  oCursor: IMongoCursor;
begin
  sChave := Format('CONSUMIDOR:%d', [AID]);

  if not dmRegras.Redis.EXISTS(sChave) then
  begin
    oCursor := dmRegras.ConMongo['TDC2017']['CONSUMIDOR'].Find().Match().Add('ID', AID).&End;
    if oCursor.Next then
    begin
      dmRegras.Redis.&SET(sChave, oCursor.Doc.AsJSON, 90);
      Result := TJSONObject.ParseJSONValue(oCursor.Doc.AsJSON);
    end
    else
    begin
      raise Exception.Create('Consumidor não encontrado');
    end;
  end
  else
  begin
    Result := TJSONObject.ParseJSONValue(dmRegras.Redis.GET(sChave));
  end;
end;

function TConsumidor.UpdateConsumidor(AConsumidor: TJSONValue): Boolean;
begin
  dmRegras.ConMongo['TDC2017']['CONSUMIDOR'].Insert().Values(AConsumidor.ToJSON).&End.Exec;
  Result := True;
end;

end.
