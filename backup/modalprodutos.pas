unit modalProdutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  EditBtn, JvBaseEdits, rxmemds;

type

  { TfrmBuscaProdutos }

  TfrmBuscaProdutos = class(TForm)
    DBGrid1: TDBGrid;
    rxProdutos: TRxMemoryData;
    rxProdutoscodigo: TLongintField;
    rxProdutosnome: TStringField;
    dsProdutos: TDataSource;
    rxProdutosValorUnd: TFloatField;
    JvCalcEdit1: TJvCalcEdit;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  frmBuscaProdutos: TfrmBuscaProdutos;

implementation

{$R *.lfm}

uses unitDM, unitpedidos;

{ TfrmBuscaProdutos }

procedure TfrmBuscaProdutos.FormShow(Sender: TObject);
begin
  with DM do
  begin
    zqTemp.close;
    zqTemp.sql.clear;
    zqTemp.sql.add('select codigo, nome, valor_unit from produtos order by codigo'); //campos registrados no rxProdutos
    zqTemp.Open;
    //limpa qualquer resquício de dados temporários
    if rxProdutos.Active = False then rxProdutos.Active:= True;
    rxProdutos.EmptyTable;
    //loop garantindo que todos os registros sejam lidos
    while not zqTemp.EOF do
    begin
      rxProdutos.Append; //estado de inserção
      rxProdutoscodigo.AsInteger:= zqTemp.Fields[0].AsInteger; //busca o primeiro atributo: código
      rxProdutosnome.AsString:= zqTemp.Fields[1].AsString;  //busca o segundo atributo: nome
      rxProdutosValorUnd.AsFloat:= zqTemp.Fields[2].AsFloat; //busca o terceiro atributo: valor_und
      rxProdutos.Post; // salva os dados encontrados na memória temporária
      zqTemp.Next; // muda para o próximo registro
    end;
  end;
end;

procedure TfrmBuscaProdutos.DBGrid1DblClick(Sender: TObject);
begin
  frmPedidos.edtCodProd.Text:= rxProdutoscodigo.AsString; //puxa a propriedade para o campo correto no formulário
  frmPedidos.edtNomeProd.Text:= rxProdutosnome.AsString;
  frmPedidos.edtValorUnitProd.Text:= rxProdutosValorUnd.AsString;
  Close;
end;



end.

