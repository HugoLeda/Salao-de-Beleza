unit U_Consu_Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.DBCtrls, Vcl.Mask, Vcl.ExtDlgs, frxClass,
  frxExportBaseDialog, frxExportPDF, frxDBSet;

type
  TForm_Consu_Produto = class(TForm)
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
    ADOQuery1NOME: TStringField;
    ADOQuery1TIPO: TStringField;
    ADOQuery1PRECO: TBCDField;
    ADOQuery1MARCA: TStringField;
    ADOQuery1CODIGO_DE_BARRAS: TLargeintField;
    ADOQuery1NOME_FANTASIA: TStringField;
    ADOQuery1DATA_CADASTRO: TStringField;
    ADOQuery1DATA_ULT_MODIFICACAO: TStringField;
    ADOQuery1QTD: TIntegerField;
    ScrollBox: TScrollBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBLFornecedor: TDBLookupComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LabelDesc: TLabel;
    ButtonImg: TSpeedButton;
    Panel2: TPanel;
    ImageProduto: TImage;
    ADOQuery1CODIGO: TAutoIncField;
    ADOQueryExclusao: TADOQuery;
    DBEditNome: TDBEdit;
    DBEditTipo: TDBEdit;
    DBEditCDBarras: TDBEdit;
    DBEditPreco: TDBEdit;
    DBEditMarca: TDBEdit;
    ADOQuery1DESCRICAO: TStringField;
    ADOQuery1IMAGEM: TStringField;
    ADOQuery1CODFORNEC: TAutoIncField;
    ADOQuery1QTD_ALERTA: TIntegerField;
    DBEditDescricao: TDBEdit;
    DBEditQTDEstoque: TDBEdit;
    DBEditQTDAlerta: TDBEdit;
    DBEditDCadastro: TDBEdit;
    DBEditUModificacao: TDBEdit;
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
    DataSourceFornec: TDataSource;
    ADOQuery1DISPONIVEL: TBooleanField;
    ODFoto: TOpenPictureDialog;
    DBEditCodFornec: TDBEdit;
    ADOQueryUpdate: TADOQuery;
    DBEditImage: TDBEdit;
    RelatorioProduto: TfrxReport;
    FrxProdutos: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ButtonSelecionar: TSpeedButton;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure ButtonNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ButtonFecharClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonEditarClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure DBEditDescricaoChange(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ButtonImgClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ButtonSelecionarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
    CaminhoImagem : string;
    qtdalerta : Boolean;
  end;

var
  Form_Consu_Produto: TForm_Consu_Produto;

implementation

{$R *.dfm}

uses U_Cadastro_Produto, U_Login, U_Venda;

procedure TForm_Consu_Produto.ButtonCancelarClick(Sender: TObject);
begin
  FormShow(Sender);
end;

procedure TForm_Consu_Produto.ButtonEditarClick(Sender: TObject);
begin
  if DBEditNome.Text <> '' then
    begin
      CaminhoImagem := 'Visual\icon image.png';
      qtdalerta := False;
      if DBEditQTDAlerta.Text <> '' then
        qtdalerta := True;
      ButtonEditar.Enabled := False;
      ButtonExcluir.Enabled := False;
      ButtonSalvar.Enabled := True;
      ButtonCancelar.Enabled := True;
      ButtonImg.Enabled := True;
      ButtonImg.Visible := True;
      SpeedButton2.Visible := True;
      DBGrid1.Enabled := False;
      SearchBox1.Enabled := False;

      DBEditNome.ReadOnly := False;
      DBEditTipo.ReadOnly := False;
      DBEditCDBarras.ReadOnly := False;
      DBEditPreco.ReadOnly := False;
      DBEditMarca.ReadOnly := False;
      DBEditDescricao.ReadOnly := False;
      DBLFornecedor.ReadOnly := False;

      DBEditNome.SetFocus;
    end
  else Application.MessageBox('Selecione um resgistro para editar!','Alerta', + MB_OK + MB_ICONWARNING);
end;

procedure TForm_Consu_Produto.ButtonExcluirClick(Sender: TObject);
begin
  ADOQueryExclusao.Close;
  ADOQueryExclusao.Parameters.ParamByName('CODIGO').Value := ADOQuery1CODIGO.AsInteger;

  if ButtonEditar.Enabled = False then
    begin
      if Application.MessageBox('Deseja excluir e descartar as alterações?', 'Excluir',
                              MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          ADOQueryExclusao.ExecSQL;
          Application.MessageBox('Produto excluído com sucesso!', 'Informação', MB_OK + MB_ICONINFORMATION);
          FormShow(Sender);
        end;
    end
  else
    begin
      if Application.MessageBox('Deseja excluir o registro selecionado?', 'Excluir',
                              MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          ADOQueryExclusao.ExecSQL;
          Application.MessageBox('Produto excluído com sucesso!', 'Informação', MB_OK + MB_ICONINFORMATION);
          FormShow(Sender);
        end;
     end;
end;

procedure TForm_Consu_Produto.ButtonFecharClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja sair e descartar as alterações?', 'Sair',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Produto.Close;
        end;
    end
  else Form_Consu_Produto.Close;
end;

procedure TForm_Consu_Produto.ButtonImgClick(Sender: TObject);
begin
  OdFoto.FilterIndex := 1;
  if OdFoto.Execute = True then
    begin
      try
         ImageProduto.Picture := Nil;
         CaminhoImagem := OdFoto.FileName;
         ImageProduto.Picture.LoadFromFile(OdFoto.FileName);
         ImageProduto.Visible := False;
         ImageProduto.Visible := True;
      Except
        on E:Exception do begin
          MessageBox(Application.Handle, PChar('São permitidos apenas arquivos JPG e PNG para imagem!'),
                                         PChar('Falha ao carregar arquivo'), MB_OK + MB_ICONWARNING);
        end;
      end;
    end;
  Form_Consu_Produto.Show;
end;

procedure TForm_Consu_Produto.ButtonNovoClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja coninuar?', 'Alterações não foram salvas',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Produto.Hide;
          Form_Cadastro_Produto.ShowModal;
          Form_Consu_Produto.Show;
        end;
    end
  else
    begin
      Form_Consu_Produto.Hide;
      Form_Cadastro_Produto.ShowModal;
      Form_Consu_Produto.Show;
    end;
end;

procedure TForm_Consu_Produto.ButtonSalvarClick(Sender: TObject);
var
  nome, localnovo : string;
begin
  localnovo := CaminhoImagem;
  if CaminhoImagem <> 'Visual\icon image.png' then
    begin
      nome := ExtractFileName(CaminhoImagem);
      localnovo := 'Imagens_Produtos\' + nome;
      MoveFile(Pchar(CaminhoImagem), Pchar(localnovo));
    end;
  ADOQueryUpdate.Close;
  ADOQueryUpdate.Parameters.ParamByName('CODIGO').Value := ADOQuery1CODIGO.AsInteger;
  ADOQueryUpdate.Parameters.ParamByName('FORNECEDOR').Value := DBLFornecedor.KeyValue;
  ADOQueryUpdate.Parameters.ParamByName('CAMINHOIMAGEM').Value := localnovo;
  DataSource1.Edit;
  if qtdalerta = True then
    begin
      if (DBEditNome.Text <> '')     and (DBEditTipo.Text <> '') and
         (DBEditCDBarras.Text <> '') and (DBEditPreco.Text <> '') and
         (DBEditMarca.Text <> '')    and (DBEditDescricao.Text <> '') and
         (DBEditQTDAlerta.Text <> '')then
        begin
          ADOQuery1.Post;
          ADOQueryUpdate.ExecSQL;
          Application.MessageBox('Atualizção concluída com sucesso!','', MB_OK + MB_ICONINFORMATION);
          FormShow(Sender);
        end
      else
        begin
          if Application.MessageBox('Nenhum campo editado pode ficar vazio!','', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON1) = ID_CANCEL then
            begin
              ButtonCancelarClick(Sender);
            end;
        end;
    end
  else
    begin
      if (DBEditNome.Text <> '')     and (DBEditTipo.Text <> '') and
         (DBEditCDBarras.Text <> '') and (DBEditPreco.Text <> '') and
         (DBEditMarca.Text <> '')    and (DBEditDescricao.Text <> '') then
        begin
          ADOQuery1.Post;
          ADOQueryUpdate.ExecSQL;
          Application.MessageBox('Atualizção concluída com sucesso!','', MB_OK + MB_ICONINFORMATION);
          FormShow(Sender);
        end
      else
        begin
          if Application.MessageBox('Nenhum campo editado pode ficar vazio!','', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON1) = ID_CANCEL then
            begin
              ButtonCancelarClick(Sender);
            end;
        end;
    end;
end;

procedure TForm_Consu_Produto.ButtonSelecionarClick(Sender: TObject);
begin
  Form_Venda.EditProduto.Text := DBGrid1.Columns[3].Field.AsString;
  Form_Consu_Produto.Close;
end;

procedure TForm_Consu_Produto.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin

  DBLFornecedor.KeyValue := ADOQuery1CODFORNEC.AsInteger;

  if (DBEditImage.Text <> '') then
    begin
      CaminhoImagem := DBEditImage.Text;
    end
  else
    CaminhoImagem := 'Visual\icon image.png';

  ImageProduto.Picture.LoadFromFile(CaminhoImagem);
end;

procedure TForm_Consu_Produto.DBEditDescricaoChange(Sender: TObject);
var
  qtdcaracteres : integer;
begin
  qtdcaracteres := Length(DBEditDescricao.Text);
  LabelDesc.Caption := IntToStr(qtdcaracteres) + '\500';
end;

procedure TForm_Consu_Produto.DBGrid1CellClick(Column: TColumn);
var
  CodLinha : Integer;
begin
  {CodLinha := DBGrid1.Columns[4].Field.AsInteger;
  ADOQueryRegistroSelecionado.Close;
  ADOQueryRegistroSelecionado.Parameters.ParamByName('CDBARRAS').Value := CodLinha;
  ADOQueryRegistroSelecionado.Open;

  EditNome.Text := ADOQueryRegistroSelecionadoNOME.AsString;
  EditTipo.Text := ADOQuery1TIPO.AsString;
  EditCDBarras.Text := ADOQuery1CODIGO_DE_BARRAS.AsString;
  EditPreco.Text := 'R$' + ADOQuery1PRECO.AsString;
  EditMarca.Text := ADOQueryRegistroSelecionadoMARCA.AsString;
  EditQTDEstoque.Text := ADOQueryRegistroSelecionadoQTD.AsString;
  EditQTDAlerta.Text := ADOQueryRegistroSelecionadoQTD_ALERTA.AsString;
  EditDCadastro.Text := ADOQuery1DATA_CADASTRO.AsString;
  EditUModificacao.Text := ADOQuery1DATA_ULT_MODIFICACAO.AsString;
  EditDescricao.Text := ADOQueryRegistroSelecionadoDESCRICAO.AsString;
  DBLFornecedor.KeyValue := ADOQueryRegistroSelecionadoFORNECEDOR.AsInteger;
  CaminhoImagem := ADOQueryRegistroSelecionadoIMAGEM.AsString;
  if CaminhoImagem <> '' then
    begin
      ImageProduto.Picture.LoadFromFile(CaminhoImagem);
    end
  else
    ImageProduto.Picture.LoadFromFile('Visual\icon image.png');}

end;

procedure TForm_Consu_Produto.DBGrid1DblClick(Sender: TObject);
begin
  ButtonSelecionarClick(Sender);
end;

procedure TForm_Consu_Produto.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TForm_Consu_Produto.DBGrid1TitleClick(Column: TColumn);
begin
  LabelPesquisar.Caption := Column.Title.Caption + ': ';
  CampoFiltro := Column.FieldName;

  if (ADOQuery1.FieldByName(CampoFiltro)is TAutoIncField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TIntegerField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TLargeintField)or
     (ADOQuery1.FieldByName(CampoFiltro)is TBCDField)then
    begin
      SearchBox1.NumbersOnly := True;
    end
  else SearchBox1.NumbersOnly := False;

  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  ADOQuery1.Filtered := False;
end;

procedure TForm_Consu_Produto.FormShow(Sender: TObject);
begin
  ADOQueryFornecedor.Close;
  ADOQueryFornecedor.Open;
  DBLFornecedor.KeyValue := 0;
  ADOQuery1.Close;
  ADOQuery1.Open;
  ADOQuery1.Filtered := False;
  DBGrid1.Enabled := True;
  SearchBox1.Enabled := True;
  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  LabelPesquisar.Caption := DBGrid1.Columns[0].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[0].FieldName;
  ScrollBox.VertScrollBar.Position := 0;

  ButtonNovo.Enabled := True;
  ButtonEditar.Enabled := True;
  ButtonSalvar.Enabled := False;
  ButtonCancelar.Enabled := False;
  ButtonFechar.Enabled := True;
  ButtonExcluir.Enabled := True;

  ButtonCancelar.Visible := True;
  ButtonSalvar.Visible := True;
  ButtonEditar.Visible := True;
  ButtonExcluir.Visible := True;
  ButtonNovo.Visible := True;
  SpeedButton1.Visible := True;
  ButtonSelecionar.Visible := False;
  GroupBox1.Visible := False;

  ButtonImg.Enabled := False;
  ButtonImg.Visible := False;
  SpeedButton2.Visible := False;
  DBEditNome.ReadOnly := True;
  DBEditTipo.ReadOnly := True;
  DBEditCDBarras.ReadOnly := True;
  DBEditPreco.ReadOnly := True;
  DBEditMarca.ReadOnly := True;
  DBEditDescricao.ReadOnly := True;
  DBEditQTDAlerta.ReadOnly := True;
  DBLFornecedor.ReadOnly := True;

  if Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
      SpeedButton1.Visible := False;
    end;

  if Form_Venda.SelecionarProd = True then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
      SpeedButton1.Visible := False;
      ButtonSelecionar.Visible := True;
      GroupBox1.Visible := False;
    end;
end;

procedure TForm_Consu_Produto.SearchBox1Change(Sender: TObject);
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

procedure TForm_Consu_Produto.SearchBox1InvokeSearch(Sender: TObject);
begin

  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQuery1.Filtered := False;
      exit;
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

procedure TForm_Consu_Produto.SpeedButton1Click(Sender: TObject);
begin
  RelatorioProduto.ShowReport();
end;

procedure TForm_Consu_Produto.SpeedButton2Click(Sender: TObject);
begin
  ImageProduto.Picture := Nil;
  CaminhoImagem := 'Visual\icon image.png';
  ImageProduto.Picture.LoadFromFile(CaminhoImagem);
end;

end.
