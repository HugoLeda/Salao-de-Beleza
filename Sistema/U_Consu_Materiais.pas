unit U_Consu_Materiais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.ComCtrls, DateTimePicker.Interposer, frxClass,
  frxExportBaseDialog, frxExportPDF, frxDBSet, frxExportText;

type
  TForm_Consu_Materiais = class(TForm)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    ButtonFechar: TSpeedButton;
    ButtonCancelar: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ButtonEditar: TSpeedButton;
    DBGrid1: TDBGrid;
    LabelPesquisar: TLabel;
    ADOConnection1: TADOConnection;
    SearchBox1: TSearchBox;
    ButtonNovo: TSpeedButton;
    GroupBox1: TGroupBox;
    GroupBox4: TGroupBox;
    ButtonExcluir: TSpeedButton;
    ScrollBox1: TScrollBox;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery1CODIGO: TAutoIncField;
    ADOQuery1NOME: TStringField;
    ADOQuery1DESCRICAO: TStringField;
    ADOQuery1TIPO: TStringField;
    ADOQuery1MARCA: TStringField;
    ADOQuery1FORNECEDOR: TIntegerField;
    ADOQuery1NOME_FANTASIA: TStringField;
    ADOQuery1PRECO: TBCDField;
    ADOQuery1QTD_DISPONIVEL: TIntegerField;
    ADOQuery1QTD_ALERTA: TIntegerField;
    ADOQuery1DATA_CADASTRO: TStringField;
    ADOQuery1ULT_MODIFICACAO: TStringField;
    ADOQuery1DATA_VALIDADE: TStringField;
    ADOQuery1DISPONIVEL: TBooleanField;
    Label1: TLabel;
    DBEditCodigo: TDBEdit;
    Label2: TLabel;
    DBEditNome: TDBEdit;
    Label3: TLabel;
    DBEditTipo: TDBEdit;
    Label4: TLabel;
    DBEditMarca: TDBEdit;
    DBLFornecedor: TDBLookupComboBox;
    Label5: TLabel;
    Label6: TLabel;
    DBEditPreco: TDBEdit;
    Label7: TLabel;
    DBEditQTDDisponivel: TDBEdit;
    Label8: TLabel;
    DBEditQTDAlerta: TDBEdit;
    DateTimePicker1: TDateTimePicker;
    Label9: TLabel;
    Label10: TLabel;
    DBEditDCadastro: TDBEdit;
    Label11: TLabel;
    DBEditUModificacao: TDBEdit;
    DBEditDValidade: TDBEdit;
    ADOQueryFornecedor: TADOQuery;
    ADOQueryFornecedorCODIGO: TAutoIncField;
    ADOQueryFornecedorNOME_EMPRESA: TStringField;
    ADOQueryFornecedorNOME_FANTASIA: TStringField;
    ADOQueryFornecedorTELEFONE: TStringField;
    ADOQueryFornecedorCNPJ: TStringField;
    ADOQueryFornecedorEMAIL: TStringField;
    ADOQueryFornecedorCIDADE: TIntegerField;
    ADOQueryFornecedorESTADO: TIntegerField;
    ADOQueryFornecedorENDERECO: TStringField;
    ADOQueryFornecedorBAIRRO: TStringField;
    ADOQueryFornecedorDATA_CADASTRO: TWideStringField;
    ADOQueryFornecedorDATA_ULT_MODIFICACAO: TWideStringField;
    ADOQueryFornecedorDISPONIVEL: TBooleanField;
    DataSourceFornecedor: TDataSource;
    ADOQueryExclusao: TADOQuery;
    ADOQueryUpdate: TADOQuery;
    Relatorio: TfrxReport;
    FrxMateriais: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    ButtonRelatorio: TSpeedButton;
    procedure ButtonNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure ButtonEditarClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ButtonFecharClick(Sender: TObject);
    procedure ButtonRelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
  end;

var
  Form_Consu_Materiais: TForm_Consu_Materiais;

implementation

{$R *.dfm}

uses Unit_Cadastro_Materiais, U_Login;

procedure TForm_Consu_Materiais.ButtonCancelarClick(Sender: TObject);
begin
  FormShow(Sender);
end;

procedure TForm_Consu_Materiais.ButtonEditarClick(Sender: TObject);
begin
  ButtonSalvar.Enabled := False;
  ButtonCancelar.Enabled := False;
  ButtonEditar.Enabled := True;
  ButtonExcluir.Enabled := True;
  ButtonNovo.Enabled := True;

  DBEditNome.ReadOnly := False;
  DBEditQTDDisponivel.ReadOnly := False;
  DBEditQTDAlerta.ReadOnly := False;
  DBEditTipo.ReadOnly := False;
  DBEditMarca.ReadOnly := False;
  DBEditPreco.ReadOnly := False;
  DBLFornecedor.ReadOnly := False;
  DateTimePicker1.Visible := True;
  DBEditDValidade.Visible := False;

  SearchBox1.Enabled := False;
  DBGrid1.Enabled := False;
end;

procedure TForm_Consu_Materiais.ButtonExcluirClick(Sender: TObject);
begin
  if ButtonEditar.Enabled = True then
      begin
        if Application.MessageBox('Deseja excluir e descartar as alterações?', 'Excluir',
                            MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
          begin
            ADOQueryExclusao.Close;
            ADOQueryExclusao.Parameters.ParamByName('CODIGO').Value := DBEditCodigo.Text;
            ADOQueryExclusao.ExecSQL;
            Application.MessageBox('Registro excluído com sucesso', 'Exclusão', MB_OK + MB_ICONINFORMATION);
            FormShow(Sender);
          end;
      end
    else
      begin
        if Application.MessageBox('Deseja excluir o registro?', 'Excluir',
                                 MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
          begin
            ADOQueryExclusao.Close;
            ADOQueryExclusao.Parameters.ParamByName('CODIGO').Value := DBEditCodigo.Text;
            ADOQueryExclusao.ExecSQL;
            Application.MessageBox('Registro excluído com sucesso', 'Exclusão', MB_OK + MB_ICONINFORMATION);
          end;
      end;
end;

procedure TForm_Consu_Materiais.ButtonFecharClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja sair e descartar as alterações?', 'Sair',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Materiais.Close;
        end;
    end
  else Form_Consu_Materiais.Close;
end;

procedure TForm_Consu_Materiais.ButtonNovoClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja coninuar?', 'Alterações não foram salvas',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Materiais.Hide;
          Form_Cadastro_Materiais.ShowModal;
          Form_Consu_Materiais.Show;
        end;
    end
  else
    begin
      Form_Consu_Materiais.Hide;
      Form_Cadastro_Materiais.ShowModal;
      Form_Consu_Materiais.Show;
    end;
end;

procedure TForm_Consu_Materiais.ButtonRelatorioClick(Sender: TObject);
begin
  Relatorio.ShowReport();
end;

procedure TForm_Consu_Materiais.ButtonSalvarClick(Sender: TObject);
begin
  DataSource1.Edit;
  if (DBEditNome.Text <> '')          and (DBEditTipo.Text <> '')      and
     (DBEditMarca.Text <> '')         and (DBEditPreco.Text <> '')     and
     (DBEditQTDDisponivel.Text <> '') and (DBEditQTDAlerta.Text <> '') and
     (DBLFornecedor.KeyValue <> 0)    then
    begin
      ADOQuery1.Post;
      ADOQueryUpdate.Close;
      ADOQueryUpdate.Parameters.ParamByName('DVALIDADE').Value := DateToStr(DateTimePicker1.Date);
      ADOQueryUpdate.Parameters.ParamByName('FORNECEDOR').Value := DBLFornecedor.KeyValue;
      ADOQueryUpdate.Parameters.ParamByName('CODIGO').Value := DBEditCodigo.Text;
      ADOQueryUpdate.ExecSQL;
      Application.MessageBox('Atualização concluída com sucesso!','Alteração de registro', MB_OK + MB_ICONINFORMATION);
      FormShow(Sender);
    end
  else Application.MessageBox('Nenhum campo pode ficar vazio!','Erro ao alterar', MB_OK + MB_ICONERROR);

end;

procedure TForm_Consu_Materiais.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  if DBEditCodigo.Text <> '' then
    begin
      DBLFornecedor.KeyValue := ADOQuery1FORNECEDOR.AsInteger;
      DateTimePicker1.Date := StrToDate(DBEditDValidade.Text);
    end
  else
    begin
      DBLFornecedor.KeyValue := 0;
      DateTimePicker1.Date := Date;
    end;
end;

procedure TForm_Consu_Materiais.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TForm_Consu_Materiais.DBGrid1TitleClick(Column: TColumn);
begin
  LabelPesquisar.Caption := Column.Title.Caption + ': ';
  CampoFiltro := Column.FieldName;

  if (ADOQuery1.FieldByName(CampoFiltro)is TAutoIncField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TIntegerField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TBCDField)then
    begin
      SearchBox1.NumbersOnly := True;
    end
  else SearchBox1.NumbersOnly := False;

  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  ADOQuery1.Filtered := False;
end;

procedure TForm_Consu_Materiais.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.Open;
  ADOQuery1.Filtered := False;
  DBGrid1.Enabled := True;
  SearchBox1.Enabled := True;
  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  LabelPesquisar.Caption := DBGrid1.Columns[1].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[1].FieldName;
  ADOQueryFornecedor.Close;
  ADOQueryFornecedor.Open;
  //
  ButtonSalvar.Enabled := False;
  ButtonCancelar.Enabled := False;
  ButtonEditar.Enabled := True;
  ButtonExcluir.Enabled := True;
  ButtonNovo.Enabled := True;
  ScrollBox1.VertScrollBar.Position := 0;

  DBEditCodigo.ReadOnly := True;
  DBEditNome.ReadOnly := True;
  DBEditTipo.ReadOnly := True;
  DBEditMarca.ReadOnly := True;
  DBEditPreco.ReadOnly := False;
  DBEditQTDDisponivel.ReadOnly := True;
  DBEditQTDAlerta.ReadOnly := True;
  DBLFornecedor.ReadOnly := True;
  DateTimePicker1.Visible := False;
  DBEditDValidade.Visible := True;

  if Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
      ButtonRelatorio.Visible := False;
    end;
end;

procedure TForm_Consu_Materiais.SearchBox1Change(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQuery1.Filtered := False;
    end
  else if (ADOQuery1.FieldByName(CampoFiltro) is TStringField) then
    begin
      SearchBox1InvokeSearch(Sender);
    end;

end;

procedure TForm_Consu_Materiais.SearchBox1InvokeSearch(Sender: TObject);
begin

  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQuery1.Filtered := False;
      exit
    end;

   if (ADOQuery1.FieldByName(CampoFiltro) is TStringField) and (Length(SearchBox1.Text) <> 0) then
     begin
       ADOQuery1.Filter := CampoFiltro + ' like ' + QuotedStr('*' + SearchBox1.Text + '*');
     end
   else
     begin
       ADOQuery1.Filter := CampoFiltro + ' = ' + SearchBox1.Text;
     end;
   ADOQuery1.Filtered := True;
end;

end.
