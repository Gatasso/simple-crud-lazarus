unit unitDM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset;

type

  { TDM }

  TDM = class(TDataModule)
    ZConnection1: TZConnection;
    zqClientes: TZQuery;
    zqFornecedores: TZQuery;
    zqProdutos: TZQuery;
    zqPedidos: TZQuery;
    zqTemp: TZQuery;
  private

  public

  end;

var
  DM: TDM;

implementation

{$R *.lfm}

end.

