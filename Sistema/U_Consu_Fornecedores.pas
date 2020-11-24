unit U_Consu_Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls,
  Vcl.Imaging.jpeg, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls;

type
  TForm_Consu_Fornecedores = class(TForm)
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
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery1CODIGO: TAutoIncField;
    ADOQuery1NOME_EMPRESA: TStringField;
    ADOQuery1NOME_FANTASIA: TStringField;
    ADOQuery1TELEFONE: TStringField;
    ADOQuery1CNPJ: TStringField;
    ADOQuery1EMAIL: TStringField;
    ADOQuery1ENDERECO: TStringField;
    ADOQuery1BAIRRO: TStringField;
    ADOQuery1DATA_CADASTRO: TStringField;
    ADOQuery1ULTIMA_MODIFICACAO: TStringField;
    ADOQuery1NOME: TStringField;
    ADOQuery1ESTADO: TStringField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid2: TDBGrid;
    Image1: TImage;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEditCodigo: TDBEdit;
    Label2: TLabel;
    DBEditNomeEmpresa: TDBEdit;
    Label3: TLabel;
    DBEditCNPJ: TDBEdit;
    Label4: TLabel;
    DBEditNomeFantasia: TDBEdit;
    Label5: TLabel;
    DBEditTelefone: TDBEdit;
    Label6: TLabel;
    DBEditEmail: TDBEdit;
    DBLEstado: TDBLookupComboBox;
    Label7: TLabel;
    Label8: TLabel;
    DBLCidade: TDBLookupComboBox;
    Label9: TLabel;
    DBEditEndereco: TDBEdit;
    Label10: TLabel;
    DBEditBairro: TDBEdit;
    Label11: TLabel;
    DBEditDCadastro: TDBEdit;
    Label12: TLabel;
    DBEditUModificacao: TDBEdit;
    ADOQuery1CDCIDADE: TIntegerField;
    ADOQuery1CDESTADO: TIntegerField;
    DataSourceEs: TDataSource;
    ADOQueryEs: TADOQuery;
    ADOQueryEsCODIGO: TIntegerField;
    ADOQueryEsSIGLA: TStringField;
    ADOQueryEsESTADO: TStringField;
    ADOQueryCidade: TADOQuery;
    DataSourceCidade: TDataSource;
    ADOQueryCidadeCODIGO: TIntegerField;
    ADOQueryCidadeNOME: TStringField;
    ADOQueryCidadeESTADO: TIntegerField;
    ADOQueryCidadeCAPITAL: TBooleanField;
    ADOQueryExclusao: TADOQuery;
    ADOQueryVerificaCidade: TADOQuery;
    ADOQueryUpdate: TADOQuery;
    ADOQueryProduto: TADOQuery;
    DataSourceProduto: TDataSource;
    ADOQueryProdutoCODIGO: TAutoIncField;
    ADOQueryProdutoNOME: TStringField;
    ADOQueryProdutoTIPO: TStringField;
    ADOQueryProdutoPRECO: TBCDField;
    ADOQueryProdutoMARCA: TStringField;
    ADOQueryProdutoDESCRICAO: TStringField;
    ADOQueryProdutoIMAGEM: TStringField;
    ADOQueryProdutoCODIGO_DE_BARRAS: TLargeintField;
    ADOQueryProdutoDISPONIVEL: TBooleanField;
    ADOQueryProdutoNOME_FANTASIA: TStringField;
    ADOQueryProdutoCODFORNEC: TAutoIncField;
    ADOQueryProdutoDATA_CADASTRO: TStringField;
    ADOQueryProdutoDATA_ULT_MODIFICACAO: TStringField;
    ADOQueryProdutoQTD: TIntegerField;
    ADOQueryProdutoQTD_ALERTA: TIntegerField;
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ButtonEditarClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure DBLEstadoClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBLCidadeClick(Sender: TObject);
    procedure DBEditCNPJKeyPress(Sender: TObject; var Key: Char);
    procedure DBEditTelefoneKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
    Estado : Integer;
    Cidade : Integer;
  end;

var
  Form_Consu_Fornecedores: TForm_Consu_Fornecedores;

implementation

{$R *.dfm}

uses U_Cadastro_Fornecedores, U_Login;

procedure TForm_Consu_Fornecedores.ButtonCancelarClick(Sender: TObject);
begin
  FormShow(Sender);
end;

procedure TForm_Consu_Fornecedores.ButtonEditarClick(Sender: TObject);
begin
  if DBEditCodigo.Text <> '' then
    begin
      if DBEditNomeFantasia.Text = ' Fornecedor sem registro' then
        begin
          Application.MessageBox('Esse fornecedor não pode ser editado!', 'Informação', MB_OK + MB_ICONINFORMATION);
        end
      else
        begin
          ButtonEditar.Enabled := False;
          ButtonExcluir.Enabled := False;
          ButtonSalvar.Enabled := True;
          ButtonCancelar.Enabled := True;
          DBGrid1.Enabled := False;
          SearchBox1.Enabled := False;

          DBEditNomeEmpresa.ReadOnly := False;
          DBEditCNPJ.ReadOnly := False;
          DBEditNomeFantasia.ReadOnly := False;
          DBEditTelefone.ReadOnly := False;
          DBEditEmail.ReadOnly := False;
          DBEditEndereco.ReadOnly := False;
          DBEditBairro.ReadOnly := False;
          DBLEstado.ReadOnly := False;
          DBLCidade.ReadOnly := False;
          Estado := DBLEstado.KeyValue;
          Cidade := DBLCidade.KeyValue;
        end;
    end
  else Application.MessageBox('Selecione um registro para editar!', 'Alerta', MB_OK + MB_ICONWARNING);
end;

procedure TForm_Consu_Fornecedores.ButtonExcluirClick(Sender: TObject);
begin
  if DBEditNomeFantasia.Text <> ' Fornecedor sem registro' then
    begin
      ADOQueryExclusao.Close;
      ADOQueryExclusao.Parameters.ParamByName('CODIGO').Value := ADOQuery1CODIGO.AsInteger;

      if ButtonEditar.Enabled = False then
        begin
          if Application.MessageBox('Deseja excluir e descartar as alterações?', 'Excluir',
                                  MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
            begin
              ADOQueryExclusao.ExecSQL;
              Application.MessageBox('Produto excluído com sucesso!', 'Alteração', MB_OK + MB_ICONINFORMATION);
              FormShow(Sender);
            end;
        end
      else
        begin
          if Application.MessageBox('Deseja excluir o registro selecionado?', 'Excluir',
                                  MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
            begin
              ADOQueryExclusao.ExecSQL;
              Application.MessageBox('Produto excluído com sucesso!', 'Exclusão', MB_OK + MB_ICONINFORMATION);
              FormShow(Sender);
            end;
         end;
    end
  else Application.MessageBox('Esse fornecedor não pode ser excluido!', 'Informação', MB_ICONINFORMATION + MB_OK);
end;

procedure TForm_Consu_Fornecedores.ButtonFecharClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja sair e descartar as alterações?', 'Sair',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Fornecedores.Close;
        end;
    end
  else
    Form_Consu_Fornecedores.Close;
end;

procedure TForm_Consu_Fornecedores.ButtonNovoClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja coninuar?', 'Alterações não foram salvas',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Fornecedores.Hide;
          Form_Cadastro_Fornecedores.ShowModal;
          Form_Consu_Fornecedores.Show;
        end;
    end
  else
    begin
      Form_Consu_Fornecedores.Hide;
      Form_Cadastro_Fornecedores.ShowModal;
      Form_Consu_Fornecedores.Show;
    end;
end;

procedure TForm_Consu_Fornecedores.ButtonSalvarClick(Sender: TObject);
begin
  DataSource1.Edit;
  if (DBEditNomeEmpresa.Text <> '') and (DBEditNomeFantasia.Text <> '') and
     (DBEditTelefone.Text <> '')    and (DBEditEmail.Text <> '')        and
     (DBEditEndereco.Text <> '')    and (DBEditBairro.Text <> '')       and
     (Estado > 0) and (Cidade > 0)  then
    begin
      if Length(DBEditCNPJ.Text) = 18 then
        begin
          ADOQueryVerificaCidade.Close;
          ADOQueryVerificaCidade.Parameters.ParamByName('ESTADO').Value := Estado;
          ADOQueryVerificaCidade.Parameters.ParamByName('CIDADE').Value := Cidade;
          ADOQueryVerificaCidade.Open;

          if ADOQueryVerificaCidade.RecordCount = 1 then
            begin
              Trim(DBEditNomeFantasia.Text);
              ADOQuery1.Post;
              ADOQueryUpdate.Close;
              ADOQueryUpdate.Parameters.ParamByName('ESTADO').Value := Estado;
              ADOQueryUpdate.Parameters.ParamByName('CIDADE').Value := Cidade;
              ADOQueryUpdate.Parameters.ParamByName('CODFORNEC').Value := StrToInt(DBEditCodigo.Text);
              ADOQueryUpdate.ExecSQL;
              Application.MessageBox('Alteração concluída com sucesso!','Alteração', MB_OK + MB_ICONINFORMATION);
              FormShow(Sender);
            end
          else Application.MessageBox('Verifique a cidade!', 'Erro', MB_OK + MB_ICONERROR);
        end
      else Application.MessageBox('Verifique o CNPJ!', 'Erro', MB_OK + MB_ICONERROR);
    end
  else
    begin
      if Application.MessageBox('Nenhum campo editado pode ficar vazio!','Alerta', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON1) = ID_CANCEL then
        begin
          ButtonCancelarClick(Sender);
        end;
    end;

end;

procedure TForm_Consu_Fornecedores.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  if DBEditCodigo.Text <> '' then
    begin
      DBLEstado.KeyValue := ADOQuery1CDESTADO.AsInteger;
      ADOQueryCidade.Close;
      ADOQueryCidade.Parameters.ParamByName('CDES').Value := DBLEstado.KeyValue;
      ADOQueryCidade.Open;
      DBLCidade.KeyValue := ADOQuery1CDCIDADE.AsInteger;
      ADOQueryProduto.Close;
      ADOQueryProduto.Parameters.ParamByName('CODFORNEC').Value := ADOQuery1CODIGO.AsInteger;
      ADOQueryProduto.Open;
   end
  else
    begin
      DBLEstado.KeyValue := 0;
      DBLCidade.KeyValue := 0;
    end;
end;

procedure TForm_Consu_Fornecedores.DBEditCNPJKeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(DBEditCNPJ.Text) = 2 then
      begin
         DBEditCNPJ.Text := DBEditCNPJ.Text + '.';
         DBEditCNPJ.Selstart := Length(DBEditCNPJ.text);
      end;

   if Length(DBEditCNPJ.Text) = 6 then
      begin
         DBEditCNPJ.Text := DBEditCNPJ.Text + '.';
         DBEditCNPJ.Selstart := Length(DBEditCNPJ.text);
      end;

   if Length(DBEditCNPJ.Text) = 10 then
      begin
         DBEditCNPJ.Text := DBEditCNPJ.Text + '/';
         DBEditCNPJ.Selstart := Length(DBEditCNPJ.text);
      end;

   if Length(DBEditCNPJ.Text) = 15 then
      begin
         DBEditCNPJ.Text := DBEditCNPJ.Text + '-';
         DBEditCNPJ.Selstart := Length(DBEditCNPJ.text);
      end;
end;

procedure TForm_Consu_Fornecedores.DBEditTelefoneKeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(DBEditTelefone.Text) = 1 then
      begin
         DBEditTelefone.Text := '(' + DBEditTelefone.Text;
         DBEditTelefone.Selstart := Length(DBEditTelefone.text);
      end;

   if Length(DBEditTelefone.Text) = 3 then
      begin
         DBEditTelefone.Text := DBEditTelefone.Text + ') ';
         DBEditTelefone.Selstart := Length(DBEditTelefone.text);
      end;
end;

procedure TForm_Consu_Fornecedores.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TForm_Consu_Fornecedores.DBGrid1TitleClick(Column: TColumn);
begin
  LabelPesquisar.Caption := Column.Title.Caption + ': ';
  CampoFiltro := Column.FieldName;

  if (ADOQuery1.FieldByName(CampoFiltro)is TAutoIncField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TIntegerField) then
    begin
      SearchBox1.NumbersOnly := True;
    end
  else SearchBox1.NumbersOnly := False;

  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  ADOQuery1.Filtered := False;
end;

procedure TForm_Consu_Fornecedores.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid2 do
    begin
      if Odd(DataSourceProduto.DataSet.RecNo)then
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

procedure TForm_Consu_Fornecedores.DBLCidadeClick(Sender: TObject);
begin
  Cidade := DBLCidade.KeyValue;
end;

procedure TForm_Consu_Fornecedores.DBLEstadoClick(Sender: TObject);
begin
  Estado := DBLEstado.KeyValue;
  ADOQueryCidade.Close;
  ADOQueryCidade.Parameters.ParamByName('CDES').Value := Estado;
  ADOQueryCidade.Open;
end;

procedure TForm_Consu_Fornecedores.FormShow(Sender: TObject);
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
  PageControl1.ActivePage := TabSheet1;
  ScrollBox1.VertScrollBar.Position := 0;

  ButtonNovo.Enabled := True;
  ButtonEditar.Enabled := True;
  ButtonSalvar.Enabled := False;
  ButtonCancelar.Enabled := False;
  ButtonFechar.Enabled := True;
  ButtonExcluir.Enabled := True;
  DBEditCodigo.ReadOnly := True;
  DBEditNomeEmpresa.ReadOnly := True;
  DBEditCNPJ.ReadOnly := True;
  DBEditNomeFantasia.ReadOnly := True;
  DBEditTelefone.ReadOnly := True;
  DBEditEmail.ReadOnly := True;
  DBEditEndereco.ReadOnly := True;
  DBEditBairro.ReadOnly := True;
  DBEditDCadastro.ReadOnly := True;
  DBEditUModificacao.ReadOnly := True;
  DBLEstado.ReadOnly := True;
  DBLCidade.ReadOnly := True;

  if Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
    end;
end;

procedure TForm_Consu_Fornecedores.SearchBox1Change(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQuery1.Filtered := False;
    end
  else if (ADOQuery1.FieldByName(CampoFiltro) is TStringField) then
    begin
      SearchBox1InvokeSearch(Sender);
    end

end;

procedure TForm_Consu_Fornecedores.SearchBox1InvokeSearch(Sender: TObject);
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
