unit U_MovimentacoesEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ComCtrls, frxClass, frxDBSet, frxExportBaseDialog, frxExportPDF;

type
  TForm_Movimentacoes_Estoque = class(TForm)
    PanelBotoes: TPanel;
    GroupBoxRegistros: TGroupBox;
    ButtonFechar: TSpeedButton;
    DBGrid1: TDBGrid;
    LabelPesquisar: TLabel;
    ADOConnection1: TADOConnection;
    SearchBox1: TSearchBox;
    GroupBoxDados: TGroupBox;
    GroupBoxPesquisa: TGroupBox;
    ADOQueryGrid: TADOQuery;
    DataSource1: TDataSource;
    ButtonRelatorio: TSpeedButton;
    ButtonCancelar: TSpeedButton;
    ButtonNovaMovimentacao: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ADOQueryGridCODIGO: TAutoIncField;
    ADOQueryGridPRODUTO: TIntegerField;
    ADOQueryGridDATA_VALIDADE: TWideStringField;
    ADOQueryGridQTD: TIntegerField;
    ADOQueryGridQTD_ALERTA: TIntegerField;
    PanelMovimentacoes: TPanel;
    GroupBoxHistoricos: TGroupBox;
    DBGrid2: TDBGrid;
    ADOQueryGridCODIGO_1: TAutoIncField;
    ADOQueryGridNOME: TStringField;
    ADOQueryGridDESCRICAO: TStringField;
    ADOQueryGridTIPO: TStringField;
    ADOQueryGridPRECO: TBCDField;
    ADOQueryGridMARCA: TStringField;
    ADOQueryGridCODIGO_DE_BARRAS: TLargeintField;
    ADOQueryGridFORNECEDOR: TIntegerField;
    ADOQueryGridIMAGEM: TStringField;
    ADOQueryGridDATA_CADASTRO: TWideStringField;
    ADOQueryGridDATA_ULT_MODIFICACAO: TWideStringField;
    ADOQueryGridDISPONIVEl: TBooleanField;
    ADOQueryGridDVALIDADE: TStringField;
    Label2: TLabel;
    DBEditProduto: TDBEdit;
    Label3: TLabel;
    DBEditQTD: TDBEdit;
    Label4: TLabel;
    DBEditQTDAlerta: TDBEdit;
    DValidade: TDateTimePicker;
    Label5: TLabel;
    PanelGrid: TPanel;
    PanelButton: TPanel;
    ButtonMovi: TSpeedButton;
    ButtonEditar: TSpeedButton;
    ADOQuery1: TADOQuery;
    DataSource2: TDataSource;
    PanelPesquisa: TPanel;
    RadioFiltro: TRadioGroup;
    ButtonFiltro: TSpeedButton;
    Label1: TLabel;
    DBEditDValidade: TDBEdit;
    ButtonEstoque: TSpeedButton;
    ADOQuery1DIA: TStringField;
    ADOQuery1HORA: TStringField;
    ADOQuery1TIPU: TStringField;
    ADOQuery1QTD: TIntegerField;
    ADOQuery1NOME: TStringField;
    Relatorio: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    FrxMovimentacoes: TfrxDBDataset;
    ADOQuery1TIPO: TBooleanField;
    RadioData: TRadioGroup;
    ADOQueryTipo0Dia: TADOQuery;
    ADOQueryTipo0DiaDIA: TStringField;
    ADOQueryTipo0DiaHORA: TStringField;
    ADOQueryTipo0DiaTIPU: TStringField;
    ADOQueryTipo0DiaQTD: TIntegerField;
    ADOQueryTipo0DiaNOME: TStringField;
    ADOQueryTipo0Mes: TADOQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    IntegerField1: TIntegerField;
    ADOQueryTipo0Sempre: TADOQuery;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    IntegerField2: TIntegerField;
    ADOQueryTipo1Dia: TADOQuery;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    IntegerField3: TIntegerField;
    ADOQueryTipo1Mes: TADOQuery;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField16: TStringField;
    IntegerField4: TIntegerField;
    ADOQueryTipo1Sempre: TADOQuery;
    StringField17: TStringField;
    StringField18: TStringField;
    StringField19: TStringField;
    StringField20: TStringField;
    IntegerField5: TIntegerField;
    ADOQueryDia: TADOQuery;
    StringField21: TStringField;
    StringField22: TStringField;
    StringField23: TStringField;
    StringField24: TStringField;
    IntegerField6: TIntegerField;
    ADOQueryMes: TADOQuery;
    StringField25: TStringField;
    StringField26: TStringField;
    StringField27: TStringField;
    StringField28: TStringField;
    IntegerField7: TIntegerField;
    ADOQueryTodos: TADOQuery;
    StringField29: TStringField;
    StringField30: TStringField;
    StringField31: TStringField;
    StringField32: TStringField;
    IntegerField8: TIntegerField;
    ADOQueryUpData: TADOQuery;
    ADOQueryEmFalta: TADOQuery;
    AutoIncField1: TAutoIncField;
    StringField33: TStringField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    StringField34: TStringField;
    WideStringField1: TWideStringField;
    StringField35: TStringField;
    AutoIncField2: TAutoIncField;
    StringField36: TStringField;
    StringField37: TStringField;
    BCDField1: TBCDField;
    LargeintField1: TLargeintField;
    IntegerField12: TIntegerField;
    StringField38: TStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    BooleanField1: TBooleanField;
    //procedure ComboBox1Click(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure ADOQueryGridBeforeOpen(DataSet: TDataSet);
    procedure ButtonFecharClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ButtonEditarClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonEstoqueClick(Sender: TObject);
    procedure ButtonMoviClick(Sender: TObject);
    procedure ButtonFiltroClick(Sender: TObject);
    procedure ButtonNovaMovimentacaoClick(Sender: TObject);
    procedure ButtonRelatorioClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid2TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
    Ascendente : Boolean;
  end;

var
  Form_Movimentacoes_Estoque: TForm_Movimentacoes_Estoque;

implementation

{$R *.dfm}

uses DateTimePicker.Interposer, U_Loading, U_Estoque, U_Login;

procedure TForm_Movimentacoes_Estoque.ADOQueryGridBeforeOpen(DataSet: TDataSet);
var
  i : integer;
begin
 { ADOQueryGrid.First;
  for i := 0 to ADOQueryGrid.RecordCount do
    begin

    end; }
end;

{procedure TForm_Movimentacoes_Estoque.ComboBox1Click(Sender: TObject);
begin
  if ComboBox1.ItemIndex = 0 then
    begin
      ADOQueryGrid.Filter := 'TIPO = 0';
      ADOQueryGrid.Filtered := True;
    end
  else if ComboBox1.ItemIndex = 1 then
    begin
      ADOQueryGrid.Filter := 'TIPO = 1';
      ADOQueryGrid.Filtered := True;
    end
  else
    begin
      ADOQueryGrid.Filtered := False;
    end;


  //fazer filtro
end;}

procedure TForm_Movimentacoes_Estoque.ButtonCancelarClick(Sender: TObject);
begin
  FormShow(Sender);
end;

procedure TForm_Movimentacoes_Estoque.ButtonEditarClick(Sender: TObject);
begin
  SearchBox1.Enabled := False;
  DBGrid1.Enabled := False;
  DBEditQTDAlerta.ReadOnly := False;
  DBEditDValidade.Visible := False;
  DValidade.Visible := True;
  DataSource1.Edit;
  ButtonEditar.Enabled := False;
  ButtonSalvar.Enabled := True;
  ButtonCancelar.Enabled := True;
  ButtonMovi.Enabled := False;
end;

procedure TForm_Movimentacoes_Estoque.ButtonEstoqueClick(Sender: TObject);
begin
  Form_Loading.ShowModal;
  LabelPesquisar.Caption := DBGrid1.Columns[1].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[1].FieldName;
  PanelMovimentacoes.Visible := False;
  GroupBoxRegistros.Visible := True;
  GroupBoxDados.Visible := True;
  GroupBoxPesquisa.Visible := True;
  ButtonEstoque.Visible := False;
  ButtonMovi.Visible := True;
  ButtonSalvar.Visible := True;
  ButtonCancelar.Visible := True;
  ButtonEditar.Visible := True;
end;

procedure TForm_Movimentacoes_Estoque.ButtonFecharClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja sair e descartar as alterações?', 'Sair',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Movimentacoes_Estoque.Close;
        end;
    end
  else Form_Movimentacoes_Estoque.Close;
end;

procedure TForm_Movimentacoes_Estoque.ButtonFiltroClick(Sender: TObject);
var
  filtro, tipo: string;
begin

  //ADOQuery1.SQL.Clear;

  if RadioFiltro.ItemIndex = 0 then
    begin
      if RadioData.ItemIndex = 0 then
        begin
          ADOQueryTipo0Dia.Close;
          ADOQueryTipo0Dia.Open;
          DataSource2.DataSet := ADOQueryTipo0Dia;
        end
      else if RadioData.ItemIndex = 1 then
        begin
          ADOQueryTipo0Mes.Close;
          ADOQueryTipo0Mes.Open;
          DataSource2.DataSet := ADOQueryTipo0Mes;
        end
      else if RadioData.ItemIndex = 2 then
        begin
          ADOQueryTipo0Sempre.Close;
          ADOQueryTipo0Sempre.Open;
          DataSource2.DataSet := ADOQueryTipo0Sempre;
        end;
    end
  else if RadioFiltro.ItemIndex = 1 then
    begin
      if RadioData.ItemIndex = 0 then
        begin
          ADOQueryTipo1Dia.Close;
          ADOQueryTipo1Dia.Open;
          DataSource2.DataSet := ADOQueryTipo1Dia;
        end
      else if RadioData.ItemIndex = 1 then
        begin
          ADOQueryTipo1Mes.Close;
          ADOQueryTipo1Mes.Open;
          DataSource2.DataSet := ADOQueryTipo1Mes;
        end
      else if RadioData.ItemIndex = 2 then
        begin
          ADOQueryTipo1Sempre.Close;
          ADOQueryTipo1Sempre.Open;
          DataSource2.DataSet := ADOQueryTipo1Sempre;
        end;
    end
  else if RadioFiltro.ItemIndex = 2 then
    begin
      if RadioData.ItemIndex = 0 then
        begin
          ADOQueryDia.Close;
          ADOQueryDia.Open;
          DataSource2.DataSet := ADOQueryDia;
        end
      else if RadioData.ItemIndex = 1 then
        begin
          ADOQueryMes.Close;
          ADOQueryMes.Open;
          DataSource2.DataSet := ADOQueryMes;
        end
      else if RadioData.ItemIndex = 2 then
        begin
          ADOQueryTodos.Close;
          ADOQueryTodos.Open;
          DataSource2.DataSet := ADOQueryTodos;
        end;
    end;

end;

procedure TForm_Movimentacoes_Estoque.ButtonMoviClick(Sender: TObject);
begin
  Form_Loading.ShowModal;
  LabelPesquisar.Caption := DBGrid2.Columns[1].Title.Caption + ': ';
  CampoFiltro := DBGrid2.Columns[1].FieldName;
  GroupBoxRegistros.Visible := False;
  GroupBoxDados.Visible := False;
  PanelMovimentacoes.Visible := True;
  PanelMovimentacoes.Align := AlClient;
  GroupBoxPesquisa.Visible := False;
  ButtonMovi.Visible := False;
  ButtonEstoque.Visible := True;
  ButtonEditar.Visible := False;
  ButtonCancelar.Visible := False;
  ButtonSalvar.Visible := False;
end;

procedure TForm_Movimentacoes_Estoque.ButtonNovaMovimentacaoClick(
  Sender: TObject);
begin
    Form_Movimentacoes_Estoque.Hide;
    Form_Estoque.ShowModal;
    Form_Movimentacoes_Estoque.Show;
end;

procedure TForm_Movimentacoes_Estoque.ButtonRelatorioClick(Sender: TObject);
begin
  //ADOQuery1.Filter := 'Dia = GETDATE()';
  //ADOQuery1.Filtered := True;
  Relatorio.ShowReport();
end;

procedure TForm_Movimentacoes_Estoque.ButtonSalvarClick(Sender: TObject);
begin
  if (StrToInt(DBEditQTDAlerta.Text) > 0) then
    begin
      ADOQueryUpData.Close;
      ADOQueryUpData.Parameters.ParamByName('DATA').Value := DateToStr(DValidade.Date);
      ADOQueryUpData.Parameters.ParamByName('COD').Value := ADOQueryGridCODIGO.AsInteger;
      ADOQueryUpData.ExecSQL;
      //DBEditDValidade.Text := DateToStr(DValidade.Date);
      ADOQueryGrid.Post;
      Application.MessageBox('Registro alterado com sucesso!','Alteração', MB_OK + MB_ICONINFORMATION);
      FormShow(Sender);
    end;
end;

procedure TForm_Movimentacoes_Estoque.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  if DBEditDValidade.Text <> '' then
    begin
      DValidade.Date := ADOQueryGridDVALIDADE.AsDateTime;
    end;
end;

procedure TForm_Movimentacoes_Estoque.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid1 do
    begin
      if Odd(DataSource1.DataSet.RecNo)then
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

procedure TForm_Movimentacoes_Estoque.DBGrid1TitleClick(Column: TColumn);
begin
  LabelPesquisar.Caption := Column.Title.Caption + ': ';
  CampoFiltro := Column.FieldName;

  if (ADOQueryGrid.FieldByName(CampoFiltro)is TAutoIncField) or
     (ADOQueryGrid.FieldByName(CampoFiltro)is TIntegerField) or
     (ADOQueryGrid.FieldByName(CampoFiltro)is TLargeintField)or
     (CampoFiltro = 'DVALIDADE')then
    begin
      SearchBox1.NumbersOnly := True;
    end
  else SearchBox1.NumbersOnly := False;

  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  ADOQueryGrid.Filtered := False;
end;

procedure TForm_Movimentacoes_Estoque.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid2 do
    begin
      if Odd(DataSource2.DataSet.RecNo)then
        begin
          DBGrid2.Canvas.Brush.Color := $00C7CBEE;
        end;
    end;
  if (gdSelected in State) then
   begin
    TDBGrid(Sender).Canvas.Brush.Color := $00a4a2e4;
   end;

  DBGrid2.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TForm_Movimentacoes_Estoque.DBGrid2TitleClick(Column: TColumn);
begin
  {LabelPesquisar.Caption := Column.Title.Caption + ': ';
  CampoFiltro := Column.FieldName;

  if (ADOQuery1.FieldByName(CampoFiltro)is TAutoIncField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TIntegerField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TLargeintField)or
     (CampoFiltro = 'DIA') or (CampoFiltro = 'HORA')then
    begin
      SearchBox1.NumbersOnly := True;
    end
  else SearchBox1.NumbersOnly := False;

  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  ADOQuery1.Filtered := False;}
end;

procedure TForm_Movimentacoes_Estoque.FormShow(Sender: TObject);
begin
  ADOQueryGrid.Close;
  ADOQueryGrid.Open;
  LabelPesquisar.Caption := DBGrid1.Columns[1].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[1].FieldName;
  SearchBox1.Enabled := True;
  SearchBox1.Text := '';
  DBGrid1.Enabled := True;
  DBEditDValidade.Visible := True;
  DValidade.Visible := False;
  DBEditQTDAlerta.ReadOnly := True;
  ButtonEditar.Enabled := True;
  ButtonSalvar.Enabled := False;
  ButtonCancelar.Enabled := False;
  ButtonMovi.Enabled := True;
  ButtonMovi.Visible := True;
  ButtonEstoque.Enabled := True;
  ButtonEstoque.Visible := False;
  ADOQuery1.Close;
  ADOQuery1.Open;
  PanelMovimentacoes.Visible := False;
  GroupBoxRegistros.Visible := True;
  GroupBoxDados.Visible := True;
  GroupBoxPesquisa.Visible := True;
  ButtonFiltroClick(Sender);

  if Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
    begin
      ButtonMovi.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonEditar.Visible := False;
    end;
end;

procedure TForm_Movimentacoes_Estoque.SearchBox1Change(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQueryGrid.Filtered := False;
    end
  else
    begin
      SearchBox1InvokeSearch(Sender);
    end;
end;

procedure TForm_Movimentacoes_Estoque.SearchBox1InvokeSearch(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQueryGrid.Filtered := False;
      exit
    end;

   if (ADOQueryGrid.FieldByName(CampoFiltro) is TStringField) and (Length(SearchBox1.Text) <> 0) then
     begin
       ADOQueryGrid.Filter := CampoFiltro + ' like ' + QuotedStr('*' + SearchBox1.Text + '*');
     end
   else
     begin
       ADOQueryGrid.Filter := CampoFiltro + ' = ' + SearchBox1.Text;
     end;
   ADOQueryGrid.Filtered := True;
end;

end.
