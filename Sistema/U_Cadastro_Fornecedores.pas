unit U_Cadastro_Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Data.DB, Vcl.DBCtrls, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TForm_Cadastro_Fornecedores = class(TForm)
    Image1: TImage;
    ButtonSair: TSpeedButton;
    ButtonLimpar: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ButtonNovo: TSpeedButton;
    ADOConnection1: TADOConnection;
    ADOQueryInsercao: TADOQuery;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    DBLookupComboBox1: TDBLookupComboBox;
    DataSource1: TDataSource;
    ADOQuery1CODIGO: TIntegerField;
    ADOQuery1SIGLA: TStringField;
    ADOQuery1ESTADO: TStringField;
    DBLookupComboBox2: TDBLookupComboBox;
    ADOQuery2CODIGO: TIntegerField;
    ADOQuery2NOME: TStringField;
    ADOQuery2ESTADO: TIntegerField;
    ADOQuery2CAPITAL: TBooleanField;
    DataSource2: TDataSource;
    EditNomeEmpresa: TEdit;
    EditNomeFantasia: TEdit;
    Edittelefone: TEdit;
    EditCNPJ: TEdit;
    EditEmail: TEdit;
    EditEndereco: TEdit;
    EditBairro: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ADOQueryVerificaCidade: TADOQuery;
    Image2: TImage;
    Label10: TLabel;
    Image3: TImage;
    ADOQueryVerificaCNPJ: TADOQuery;
    procedure DBLookupComboBox2DropDown(Sender: TObject);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditCNPJKeyPress(Sender: TObject; var Key: Char);
    procedure EdittelefoneKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Cadastro_Fornecedores: TForm_Cadastro_Fornecedores;

implementation

{$R *.dfm}

procedure TForm_Cadastro_Fornecedores.ButtonLimparClick(Sender: TObject);
begin
  EditNomeEmpresa.Text := '';
  EditCNPJ.Text := '';
  EditNomeFantasia.Text := '';
  Edittelefone.Text := '';
  EditEmail.Text := '';
  EditEndereco.Text := '';
  EditBairro.Text := '';
  ADOQuery1.Close;
  ADOQuery1.Open;
  EditNomeEmpresa.SetFocus;
  DBLookupComboBox1.KeyValue := 0;
  DBLookupComboBox2.KeyValue := 0;
end;

procedure TForm_Cadastro_Fornecedores.ButtonNovoClick(Sender: TObject);
begin
  ButtonNovo.Enabled := False;
  ButtonSalvar.Enabled := True;
  ButtonLimparClick(Sender);
end;

procedure TForm_Cadastro_Fornecedores.ButtonSairClick(Sender: TObject);
begin
  if (EditNomeEmpresa.Text <> '')  and (EditCNPJ.Text <> '')     and
     (EditNomeFantasia.Text <> '') and (Edittelefone.Text <> '') and
     (EditEndereco.Text <> '')     and (EditBairro.Text <> '')   and
     (EditEmail.Text <> '')        and (EditCNPJ.Text <> '') then
    begin
      if Application.MessageBox('Deseja sair?','Sair',mb_iconquestion + MB_YESNO + mb_defbutton1) = id_yes then
        begin
          ButtonLimparClick(Sender);
          Form_Cadastro_Fornecedores.Close;
        end;
    end
  else Form_Cadastro_Fornecedores.Close;
end;

procedure TForm_Cadastro_Fornecedores.ButtonSalvarClick(Sender: TObject);
var
  Estado, Cidade: Integer;
begin
  if (DBLookupComboBox1.KeyValue > 0) and (DBLookupComboBox2.KeyValue > 0) then
    begin
      Estado := DBLookupComboBox1.KeyValue;
      Cidade := DBLookupComboBox2.KeyValue;
      ADOQueryVerificaCidade.Close;
      ADOQueryVerificaCidade.Parameters.ParamByName('ESTADO').Value := Estado;
      ADOQueryVerificaCidade.Parameters.ParamByName('CIDADE').Value := CIDADE;
      ADOQueryVerificaCidade.Open;
    end;
  if   (EditNomeEmpresa.Text <> '')  and (EditCNPJ.Text <> '')     and
       (EditNomeFantasia.Text <> '') and (Edittelefone.Text <> '') and
       (EditEndereco.Text <> '')     and (EditBairro.Text <> '')   and
       (EditEmail.Text <> '') then
    begin
      if ADOQueryVerificaCidade.RecordCount = 1  then
        begin
          if (Length(EditCNPJ.Text) = 18) then
            begin
              ADOQueryVerificaCNPJ.Close;
              ADOQueryVerificaCNPJ.Parameters.ParamByName('CNPJ').Value := EditCNPJ.Text;
              ADOQueryVerificaCNPJ.Open;
              if ADOQueryVerificaCNPJ.RecordCount = 0 then
                begin
                  ADOQueryInsercao.Parameters.ParamByName('NOME_EMPRESA').Value := EditNomeEmpresa.Text;
                  EditNomeFantasia.Text := Trim(EditNomeFantasia.Text);
                  ADOQueryInsercao.Parameters.ParamByName('NOME_FANTASIA').Value := EditNomeFantasia.Text;
                  ADOQueryInsercao.Parameters.ParamByName('TELEFONE').Value := Edittelefone.Text;
                  ADOQueryInsercao.Parameters.ParamByName('CNPJ').Value := EditCNPJ.Text;
                  ADOQueryInsercao.Parameters.ParamByName('EMAIL').Value := EditEmail.Text;
                  ADOQueryInsercao.Parameters.ParamByName('CIDADE').Value := Cidade;
                  ADOQueryInsercao.Parameters.ParamByName('ESTADO').Value := Estado;
                  ADOQueryInsercao.Parameters.ParamByName('ENDERECO').Value := EditEndereco.Text;
                  ADOQueryInsercao.Parameters.ParamByName('BAIRRO').Value := EditBairro.Text;
                  ADOQueryInsercao.ExecSQL;
                  Application.MessageBox('Cadastro realizado com sucesso','Cadastro', MB_OK + MB_ICONINFORMATION);
                  ButtonSalvar.Enabled := False;
                  ButtonNovo.Enabled := True;
                end
              else Application.MessageBox('CNPJ já cadastrado!', 'Erro', MB_OK + MB_ICONERROR);
            end
          else Application.MessageBox('CNPJ inválido!', 'Erro', MB_OK + MB_ICONERROR);
        end
      else Application.MessageBox('Verifique a cidade!','Alerta', MB_OK + MB_ICONWARNING);
    end
  else Application.MessageBox('Preencha todos os campos!', 'Erro', MB_OK + MB_ICONERROR);

end;

procedure TForm_Cadastro_Fornecedores.DBLookupComboBox1Click(Sender: TObject);
begin
  DBLookupComboBox2.Enabled := True;
end;

procedure TForm_Cadastro_Fornecedores.DBLookupComboBox2DropDown(
  Sender: TObject);
var
  a : Integer;
begin
  a := DBLookupComboBox1.KeyValue;
  ADOQuery2.Close;
  ADOQuery2.Parameters.ParamByName('ESTADO').Value := a;
  ADOQuery2.Open;

end;

procedure TForm_Cadastro_Fornecedores.EditCNPJKeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(EditCNPJ.Text) = 2 then
      begin
         EditCNPJ.Text := EditCNPJ.Text + '.';
         EditCNPJ.Selstart := Length(EditCNPJ.text);
      end;

   if Length(EditCNPJ.Text) = 6 then
      begin
         EditCNPJ.Text := EditCNPJ.Text + '.';
         EditCNPJ.Selstart := Length(EditCNPJ.text);
      end;

   if Length(EditCNPJ.Text) = 10 then
      begin
         EditCNPJ.Text := EditCNPJ.Text + '/';
         EditCNPJ.Selstart := Length(EditCNPJ.text);
      end;

   if Length(EditCNPJ.Text) = 15 then
      begin
         EditCNPJ.Text := EditCNPJ.Text + '-';
         EditCNPJ.Selstart := Length(EditCNPJ.text);
      end;
end;

procedure TForm_Cadastro_Fornecedores.EdittelefoneKeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(EditTelefone.Text) = 1 then
      begin
         EditTelefone.Text := '(' + EditTelefone.Text;
         EditTelefone.Selstart := Length(EditTelefone.text);
      end;

   if Length(EditTelefone.Text) = 3 then
      begin
         EditTelefone.Text := EditTelefone.Text + ') ';
         EditTelefone.Selstart := Length(EditTelefone.text);
      end;
end;

procedure TForm_Cadastro_Fornecedores.FormShow(Sender: TObject);
begin
  ButtonLimparClick(Sender);
end;

end.
