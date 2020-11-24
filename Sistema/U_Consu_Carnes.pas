unit U_Consu_Carnes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TForm_BaseConsu = class(TForm)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    ButtonFechar: TSpeedButton;
    ButtonCancelar: TSpeedButton;
    ButtonSelecionar: TSpeedButton;
    DBGrid1: TDBGrid;
    LabelPesquisar: TLabel;
    ADOConnection1: TADOConnection;
    SearchBox1: TSearchBox;
    ButtonNovo: TSpeedButton;
    GroupBox1: TGroupBox;
    GroupBox4: TGroupBox;
    ButtonExcluir: TSpeedButton;
    DBGrid2: TDBGrid;
    ADOQueryCarnes: TADOQuery;
    ADOQueryItensCarnes: TADOQuery;
    DataSourceCarnes: TDataSource;
    DataSourceItens: TDataSource;
    DBEdit1: TDBEdit;
    ADOQueryCarnesCODIGO: TAutoIncField;
    ADOQueryCarnesNOME: TStringField;
    ADOQueryCarnesCODCARNE: TAutoIncField;
    ADOQueryCarnesCODIGO_VENDA: TIntegerField;
    ADOQueryCarnesQTD_PARCELAS: TIntegerField;
    ADOQueryCarnesQTD_PARCELAS_PAGAS: TIntegerField;
    ADOQueryCarnesSITUACAO: TBooleanField;
    ADOQueryCarnesVALOR_PAGO: TBCDField;
    ADOQueryCarnesVALOR_PARCELAS: TBCDField;
    ADOQueryCarnesVALOR_TOTAL: TBCDField;
    ADOQueryCarnesSIT: TStringField;
    RadioGroup1: TRadioGroup;
    ButtonFiltrar: TSpeedButton;
    Panel2: TPanel;
    EditValorPago: TEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    LabelTroco: TLabel;
    Label4: TLabel;
    ADOQueryItensCarnesCODIGO_ITEM_CARNE: TAutoIncField;
    ADOQueryItensCarnesVENCIMENTO: TStringField;
    ADOQueryItensCarnesSIT: TStringField;
    ADOQueryItensCarnesVALOR_PARCELAS: TBCDField;
    ButtonVenda: TSpeedButton;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
  end;

var
  Form_BaseConsu: TForm_BaseConsu;

implementation

{$R *.dfm}

procedure TForm_BaseConsu.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid1 do
    begin
      if Odd(DataSourceCarnes.DataSet.RecNo)then
        begin
          DBGrid1.Canvas.Brush.Color := $00C7CBEE;
        end;
    end;
  if (gdSelected in State) then
   begin
    TDBGrid(Sender).Canvas.Brush.Color := $00a4a2e4;
   end;

  DBGrid1.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TForm_BaseConsu.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid2 do
    begin
      if Odd(DataSourceItens.DataSet.RecNo)then
        begin
          DBGrid1.Canvas.Brush.Color := $00C7CBEE;
        end;
    end;
  if (gdSelected in State) then
   begin
    TDBGrid(Sender).Canvas.Brush.Color := $00a4a2e4;
   end;

  DBGrid2.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

end.
