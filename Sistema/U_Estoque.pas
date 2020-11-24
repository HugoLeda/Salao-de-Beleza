unit U_Estoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.DBCtrls, Data.Win.ADODB,
  Vcl.Imaging.pngimage, Vcl.Samples.Spin, Vcl.Buttons;

type
  TForm_Estoque = class(TForm)
    DBLProdutos: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ADOConnection1: TADOConnection;
    Image1: TImage;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    ButtonLimpar: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ButtonSair: TSpeedButton;
    ADOQueryProdutos: TADOQuery;
    DataSource1: TDataSource;
    ADOQueryProdutosNOME: TStringField;
    ADOQueryProdutosMARCA: TStringField;
    ADOQueryProdutosNOME_FANTASIA: TStringField;
    ADOQueryInsert: TADOQuery;
    ADOQueryProdutosCODIGO: TAutoIncField;
    ADOQueryEstoque: TADOQuery;
    ADOQueryEstoqueCODIGO: TAutoIncField;
    ADOQueryEstoquePRODUTO: TIntegerField;
    ADOQueryEstoqueDATA_VALIDADE: TWideStringField;
    ADOQueryEstoqueQTD: TIntegerField;
    ADOQueryEstoqueQTD_ALERTA: TIntegerField;
    SpinEdit1: TEdit;
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Estoque: TForm_Estoque;

implementation

{$R *.dfm}

procedure TForm_Estoque.ButtonLimparClick(Sender: TObject);
begin
  ADOQueryProdutos.Close;
  ADOQueryProdutos.Open;
  DBLProdutos.KeyValue := 0;
  SpinEdit1.Text := '';
  RadioGroup1.ItemIndex := -1;
  DBLProdutos.SetFocus;
end;

procedure TForm_Estoque.ButtonSairClick(Sender: TObject);
begin
  Form_Estoque.Close;
end;

procedure TForm_Estoque.ButtonSalvarClick(Sender: TObject);
var
  qtdatualiza : integer;
begin
  qtdatualiza := 0;
  if (RadioGroup1.ItemIndex <> -1) and (DBLProdutos.KeyValue > 0) and
     (SpinEdit1.Text <> '') then
    begin
      ADOQueryEstoque.Close;
      ADOQueryEstoque.Parameters.ParamByName('PRODUTO').Value := DBLProdutos.KeyValue;
      ADOQueryEstoque.Open;
      if ADOQueryEstoque.RecordCount = 1 then
        begin
          if RadioGroup1.ItemIndex = 1 then
            begin
              if ADOQueryEstoqueQTD.AsInteger > StrToInt(SpinEdit1.Text) then
                begin
                  qtdatualiza := ADOQueryEstoqueQTD.AsInteger - StrToInt(SpinEdit1.Text);
                  ADOQueryInsert.Close;
                  ADOQueryInsert.Parameters.ParamByName('TIPO').Value := RadioGroup1.ItemIndex;
                  ADOQueryInsert.Parameters.ParamByName('ESTOQUE').Value := ADOQueryEstoqueCODIGO.AsInteger;
                  ADOQueryInsert.Parameters.ParamByName('QTD').Value := SpinEdit1.Text;
                  ADOQueryInsert.Parameters.ParamByName('QTD2').Value := qtdatualiza;
                  ADOQueryInsert.Parameters.ParamByName('PRODUTO').Value := DBLProdutos.KeyValue;
                  ADOQueryInsert.ExecSQL;
                  Application.MessageBox('Movimentação registrada com sucesso!', 'Registro de Movimentação', MB_OK + MB_ICONINFORMATION);
                  if Application.MessageBox('Desja registrar outra movimentação?','Registro de Movimentação',
                                             MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1)  = IDYES then
                    begin
                      ButtonLimparClick(Sender);
                    end
                  else Form_Estoque.Close;
                end
              else Application.MessageBox('Essa quantidade não está disponível no estoque!', 'Erro', MB_OK + MB_ICONERROR);
            end
          else if RadioGroup1.ItemIndex = 0 then
            begin
              qtdatualiza := ADOQueryEstoqueQTD.AsInteger + StrToInt(SpinEdit1.Text);
              ADOQueryInsert.Close;
              ADOQueryInsert.Parameters.ParamByName('TIPO').Value := RadioGroup1.ItemIndex;
              ADOQueryInsert.Parameters.ParamByName('ESTOQUE').Value := ADOQueryEstoqueCODIGO.AsInteger;
              ADOQueryInsert.Parameters.ParamByName('QTD').Value := SpinEdit1.Text;
              ADOQueryInsert.Parameters.ParamByName('QTD2').Value := qtdatualiza;
              ADOQueryInsert.Parameters.ParamByName('PRODUTO').Value := DBLProdutos.KeyValue;
              ADOQueryInsert.ExecSQL;
              Application.MessageBox('Movimentação registrada com sucesso!', 'Registro de Movimentação', MB_OK + MB_ICONINFORMATION);
              if Application.MessageBox('Desja registrar outra movimentação?','Registro de Movimentação',
                                        MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1)  = IDYES then
                begin
                  ButtonLimparClick(Sender);
                end
              else Form_Estoque.Close;
            end;
        end
      else Application.MessageBox('Erro a registrar movimentação!','Erro', MB_OK + MB_ICONERROR);
    end
  else Application.MessageBox('Preencha todos os campos!','Alerta', MB_OK + MB_ICONWARNING);
end;

procedure TForm_Estoque.FormShow(Sender: TObject);
begin
  ButtonLimparClick(Sender);
end;

end.
