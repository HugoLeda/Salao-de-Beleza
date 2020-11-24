unit U_Cadastro_Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtDlgs,
  Vcl.Imaging.pngimage, Vcl.Samples.Spin, Vcl.ComCtrls;

type
  TForm_Cadastro_Produto = class(TForm)
    ADOConnection1: TADOConnection;
    Image1: TImage;
    ButtonNovo: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ButtonLimpar: TSpeedButton;
    ButtonSair: TSpeedButton;
    EditNome: TEdit;
    EditDescricao: TEdit;
    Edittipo: TEdit;
    edvalortotal: TEdit;
    EditMarca: TEdit;
    EditCodBarras: TEdit;
    DBLookupComboBoxFornecedor: TDBLookupComboBox;
    ImProdutoPadrao: TImage;
    ButtonImg: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ADOQueryFornecedor: TADOQuery;
    DataSource1: TDataSource;
    ADOQueryFornecedorCODIGO: TAutoIncField;
    ADOQueryFornecedorNOME_EMPRESA: TStringField;
    ADOQueryFornecedorNOME_FANTASIA: TStringField;
    ADOQueryFornecedorTELEFONE: TStringField;
    ADOQueryFornecedorCNPJ: TStringField;
    ADOQueryFornecedorCIDADE: TIntegerField;
    ADOQueryFornecedorESTADO: TIntegerField;
    ADOQueryFornecedorENDERECO: TStringField;
    ADOQueryFornecedorBAIRRO: TStringField;
    ADOQueryVerificaCodBarras: TADOQuery;
    ADOQueryInsercao: TADOQuery;
    OdFoto: TOpenPictureDialog;
    Image2: TImage;
    Label8: TLabel;
    Image4: TImage;
    ImProduto: TImage;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    ADOQueryEstoque: TADOQuery;
    ADOQueryMovimentacao: TADOQuery;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonImgClick(Sender: TObject);
    procedure ImProdutoPadraoDblClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImProdutoDblClick(Sender: TObject);
    procedure EditDescricaoChange(Sender: TObject);
    procedure edvalortotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
  local, nome : String;
    { Public declarations }
  end;

var
  Form_Cadastro_Produto: TForm_Cadastro_Produto;

implementation

{$R *.dfm}

uses DateTimePicker.Interposer;
function DeleteChar(const Ch: Char; const S: string): string;

var

  Posicao: integer;

begin

  Result := S;

  Posicao := Pos(Ch, Result);

  while Posicao > 0 do

  begin

    Delete(Result, Posicao, 1);

    Posicao := Pos(Ch, Result);

  end;

end;

procedure TForm_Cadastro_Produto.ButtonImgClick(Sender: TObject);
begin
  local := 'Visual\icon image.png';
  OdFoto.FilterIndex := 1;
  if OdFoto.Execute = True then
    begin
      try
         ImProduto.Picture := Nil;
         local := OdFoto.FileName;
         ImProduto.Picture.LoadFromFile(OdFoto.FileName);
         ImProdutoPadrao.Visible := False;
         ImProduto.Visible := True;
      Except
        on E:Exception do begin
          MessageBox(Application.Handle, PChar('São permitidos apenas arquivos JPG e PNG para imagem!'),
                                         PChar('Falha ao carregar arquivo'), MB_OK + MB_ICONWARNING);
        end;
      end;
    end;
  Form_Cadastro_Produto.Show;
end;

procedure TForm_Cadastro_Produto.ButtonLimparClick(Sender: TObject);
begin
  local := 'Visual\icon image.png';
  EditNome.Text := '';
  EditNome.SetFocus;
  EditDescricao.Text := '';
  Edittipo.Text := '';
  edvalortotal.Text := '';
  EditMarca.Text := '';
  EditCodBarras.Text := '';
  DBLookupComboBoxFornecedor.KeyValue := 0;
  ImProduto.Picture := Nil;
  ImProduto.Visible := False;
  ImProdutoPadrao.Visible := True;
  DateTimePicker1.Date := Date;
  Edit1.Text := '';
  Edit2.Text := '';
end;

procedure TForm_Cadastro_Produto.ButtonNovoClick(Sender: TObject);
begin
  ButtonNovo.Enabled := False;
  ButtonSalvar.Enabled := True;
  ButtonLimparClick(Sender);
end;

procedure TForm_Cadastro_Produto.ButtonSairClick(Sender: TObject);
begin
  if  (EditNome.Text <> '')  or (EditDescricao.Text <> '') or
      (Edittipo.Text <> '')  or (edvalortotal.Text <> '')  or
      (EditMarca.Text <> '') or (EditCodBarras.Text <> '') then
    begin
      if Application.MessageBox('Deseja sair?','Sair',mb_iconquestion + MB_YESNO + mb_defbutton1) = id_yes then
        begin
          ButtonLimparClick(Sender);
          Form_Cadastro_Produto.Close;
        end;
    end
  else Form_Cadastro_Produto.Close;

end;

procedure TForm_Cadastro_Produto.ButtonSalvarClick(Sender: TObject);
var
  i : Integer;
  CodProduto, CodEstoque : integer;
  QTD, QTDA : integer;
  localnovo : string;
begin
  DeleteChar('.', edvalortotal.Text);
  DeleteChar('R', edvalortotal.Text);
  DeleteChar('$', edvalortotal.Text);

  {for I := 1 to Length(EditPreco) do
    begin
      if (i < 48) and (i > 57) and (i <> 44) then
        begin
          CodAsc := '#' + inttostr(i);
          DeleteChar('#' + i, EditPreco.Text);
        end;
    end;}
  if (Edit1.Text = '') or (Edit2.Text = '') then
    begin
      Application.MessageBox('Preencha os dados de estoque!', 'Atenção', MB_OK + MB_ICONWARNING);
      Exit;
    end;

  QTD := StrToInt(Edit1.Text);
  QTDA := StrToInt(Edit2.Text);
  if  (EditNome.Text <> '')  and (EditDescricao.Text <> '') and
      (Edittipo.Text <> '')  and (edvalortotal.Text <> '')     and
      (EditMarca.Text <> '') and (EditCodBarras.Text <> '') and
      (QTD > 0) and (QTDA > 0) then
    begin
      ADOQueryVerificaCodBarras.Close;
      ADOQueryVerificaCodBarras.Parameters.ParamByName('CDBARRAS').Value := EditCodBarras.Text;
      ADOQueryVerificaCodBarras.Open;
      if ADOQueryVerificaCodBarras.RecordCount = 0 then
        begin
          localnovo := local;
          if local <> 'Visual\icon image.png' then
            begin
              nome := ExtractFileName(local);
              localnovo := 'Imagens_Produtos\' + nome;
              MoveFile(Pchar(local), Pchar(localnovo));
            end;
          ADOQueryInsercao.Close;
          ADOQueryInsercao.Parameters.ParamByName('NOME').Value := EditNome.Text;
          ADOQueryInsercao.Parameters.ParamByName('DESCRICAO').Value := EditDescricao.Text;
          ADOQueryInsercao.Parameters.ParamByName('TIPO').Value := Edittipo.Text;
          ADOQueryInsercao.Parameters.ParamByName('PRECO').Value := edvalortotal.Text;
          ADOQueryInsercao.Parameters.ParamByName('MARCA').Value := EditMarca.Text;
          ADOQueryInsercao.Parameters.ParamByName('CODIGO_DE_BARRAS').Value := EditCodBarras.Text;
          ADOQueryInsercao.Parameters.ParamByName('FORNECEDOR').Value := DBLookupComboBoxFornecedor.KeyValue;
          ADOQueryInsercao.Parameters.ParamByName('IMAGEM').Value := localnovo;
          ADOQueryInsercao.Parameters.ParamByName('ULT').Value;
          ADOQueryInsercao.ExecSQL;
          CodProduto := ADOQueryInsercao.Parameters.ParamByName('ULT').Value;
          ADOQueryEstoque.Close;
          ADOQueryEstoque.Parameters.ParamByName('PRODUTO').Value := CodProduto;
          ADOQueryEstoque.Parameters.ParamByName('DVALIDADE').Value := DateToStr(DateTimePicker1.Date);
          ADOQueryEstoque.Parameters.ParamByName('QTD').Value := QTD;
          ADOQueryEstoque.Parameters.ParamByName('QTDALERTA').Value := QTDA;
          ADOQueryEstoque.Parameters.ParamByName('ULT').Value;
          ADOQueryEstoque.ExecSQL;
          CodEstoque := ADOQueryEstoque.Parameters.ParamByName('ULT').Value;
          ADOQueryMovimentacao.Close;
          ADOQueryMovimentacao.Parameters.ParamByName('ESTOQUE').Value := CodEstoque;
          ADOQueryMovimentacao.Parameters.ParamByName('QTD').Value := QTD;
          ADOQueryMovimentacao.ExecSQL;
          Application.MessageBox('Produto cadastrado com sucesso!','Cadastro de produto', MB_OK + MB_ICONINFORMATION);
          ButtonSalvar.Enabled := False;
          ButtonNovo.Enabled := True;
        end
      else
        begin
          MessageBox(Application.Handle, PChar('Ja existe um produto com esse código de barras!'),
                                         PChar('Erro'), MB_OK + MB_ICONWARNING);
        end;
    end
  else Application.MessageBox('Preencha todos os campos corretamente!','Alerta', MB_OK + MB_ICONWARNING);
end;

procedure TForm_Cadastro_Produto.EditDescricaoChange(Sender: TObject);
var
  qtdcaracteres : Integer;
begin
  qtdcaracteres :=  length(EditDescricao.text);
  Label9.Caption := inttostr(qtdcaracteres)+'\500';
end;

procedure TForm_Cadastro_Produto.edvalortotalKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  s: String;
begin
  if (Key in [96..107]) or (Key in [48..57]) then
     begin
      S := edValorTotal.Text;
      S := StringReplace(S,',','',[rfReplaceAll]);
      S := StringReplace(S,'.','',[rfReplaceAll]);
      if Length(s) = 3 then
        begin
          s := Copy(s,1,1)+','+Copy(S,2,15);
          edValorTotal.Text := S;
          edValorTotal.SelStart := Length(S);
        end
      else
        if (Length(s) > 3) and (Length(s) < 6) then
          begin
            s := Copy(s,1,length(s)-2)+','+Copy(S,length(s)-1,15);
            edValorTotal.Text := s;
            edValorTotal.SelStart := Length(S);
          end
        else
          if (Length(s) >= 6) and (Length(s) < 9) then
            begin
              s := Copy(s,1,length(s)-5)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
              edValorTotal.Text := s;
              edValorTotal.SelStart := Length(S);
            end
          else
            if (Length(s) >= 9) and (Length(s) < 12) then
              begin
                s := Copy(s,1,length(s)-8)+'.'+Copy(s,length(s)-7,3)+'.'+
                       Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                edValorTotal.Text := s;
                edValorTotal.SelStart := Length(S);
              end
            else
              if (Length(s) >= 12) and (Length(s) < 15)  then
                begin
                  s := Copy(s,1,length(s)-11)+'.'+Copy(s,length(s)-10,3)+'.'+
                          Copy(s,length(s)-7,3)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                  edValorTotal.Text := s;
                  edValorTotal.SelStart := Length(S);
                end;
      end;

end;

procedure TForm_Cadastro_Produto.FormShow(Sender: TObject);
begin
  ButtonLimparClick(Sender);
  ADOQueryFornecedor.Close;
  ADOQueryFornecedor.Open;
  ButtonSalvar.Enabled := True;
end;

procedure TForm_Cadastro_Produto.ImProdutoDblClick(Sender: TObject);
begin
  ButtonImgClick(Sender);
end;

procedure TForm_Cadastro_Produto.ImProdutoPadraoDblClick(Sender: TObject);
begin
  ButtonImgClick(Sender);
end;

end.
