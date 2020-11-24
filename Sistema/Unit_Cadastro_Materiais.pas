unit Unit_Cadastro_Materiais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  Vcl.ComCtrls, Vcl.Imaging.pngimage, DateTimePicker.Interposer;

type
  TForm_Cadastro_Materiais = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQueryInsercao: TADOQuery;
    ADOQueryInsercaoCODIGO: TAutoIncField;
    ADOQueryInsercaoNOME: TStringField;
    ADOQueryInsercaoDESCRICAO: TStringField;
    ADOQueryInsercaoTIPO: TStringField;
    ADOQueryInsercaoMARCA: TStringField;
    ADOQueryInsercaoFORNECEDOR: TIntegerField;
    ADOQueryInsercaoPRECO: TBCDField;
    ADOQueryInsercaoQTD_DISPONIVEL: TIntegerField;
    ADOQueryInsercaoQTD_ALERTA: TIntegerField;
    ADOQueryInsercaoDATA_VALIDADE: TWideStringField;
    ADOQueryInsercaoDATA_CADASTRO: TWideStringField;
    ADOQueryInsercaoDATA_ULT_MODIFICACAO: TWideStringField;
    ADOQueryInsercaoDISPONIVEL: TBooleanField;
    EditAlerta: TEdit;
    EditMarca: TEdit;
    edvalortotal: TEdit;
    EditTipo: TEdit;
    EditDescricao: TEdit;
    EditQTD: TEdit;
    EditNome: TEdit;
    DBLFornecedor: TDBLookupComboBox;
    Image1: TImage;
    ButtonSalvar: TSpeedButton;
    ButtonLimpar: TSpeedButton;
    ButtonSair: TSpeedButton;
    ButtonNovo: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LabelCaracteres: TLabel;
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
    DateTimePicker1: TDateTimePicker;
    Label9: TLabel;
    ADOQueryVerificaNome: TADOQuery;
    Image2: TImage;
    Label10: TLabel;
    procedure ButtonLimparClick(Sender: TObject);
    procedure EditDescricaoChange(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edvalortotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Cadastro_Materiais: TForm_Cadastro_Materiais;

implementation

{$R *.dfm}

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

procedure TForm_Cadastro_Materiais.ButtonLimparClick(Sender: TObject);
begin
  EditAlerta.Text := '';
  EditMarca.Text := '';
  edvalortotal.Text := '';
  EditTipo.Text := '';
  EditDescricao.Text := '';
  EditQTD.Text := '';
  EditNome.Text := '';
  ADOQueryFornecedor.Close;
  ADOQueryFornecedor.Open;
  DBLFornecedor.KeyValue := 0;
  DateTimePicker1.Date := Date;
end;

procedure TForm_Cadastro_Materiais.ButtonNovoClick(Sender: TObject);
begin
  ButtonSalvar.Enabled := True;
  ButtonLimparClick(Sender);
end;

procedure TForm_Cadastro_Materiais.ButtonSairClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja sair?','Sair',mb_iconquestion + MB_YESNO + mb_defbutton1) = id_yes then
    begin
      ButtonLimparClick(Sender);
      Form_Cadastro_Materiais.Close;
    end;
end;

procedure TForm_Cadastro_Materiais.ButtonSalvarClick(Sender: TObject);
begin
  DeleteChar('.', edvalortotal.Text);
  DeleteChar('R', edvalortotal.Text);
  DeleteChar('$', edvalortotal.Text);
  if (EditAlerta.Text <> '') and (EditMarca.Text <> '')    and
     (edvalortotal.Text <> '') and (EditTipo.Text <> '')      and
     (EditNome.Text <> '') and (EditDescricao.Text <> '')  and
     (EditQTD.Text <> '') and (DBLFornecedor.KeyValue <> 0)then
    begin
      ADOQueryVerificaNome.Close;
      ADOQueryVerificaNome.Parameters.ParamByName('NOME').Value := EditNome.Text;
      ADOQueryVerificaNome.Open;
      if ADOQueryVerificaNome.RecordCount = 0 then
        begin
          ADOQueryInsercao.Close;
          ADOQueryInsercao.Parameters.ParamByName('NOME').Value := EditNome.Text;
          ADOQueryInsercao.Parameters.ParamByName('DESCRICAO').Value := EditDescricao.Text;
          ADOQueryInsercao.Parameters.ParamByName('TIPO').Value := EditTipo.Text;
          ADOQueryInsercao.Parameters.ParamByName('MARCA').Value := EditMarca.Text;
          ADOQueryInsercao.Parameters.ParamByName('FORNECEDOR').Value := DBLFornecedor.KeyValue;
          ADOQueryInsercao.Parameters.ParamByName('PRECO').Value := edvalortotal.Text;
          ADOQueryInsercao.Parameters.ParamByName('QTD_DISPONIVEL').Value := EditQTD.Text;
          ADOQueryInsercao.Parameters.ParamByName('QTD_ALERTA').Value := EditAlerta.Text;
          ADOQueryInsercao.Parameters.ParamByName('DATA_VALIDADE').Value := DateToStr(DateTimePicker1.Date);
          ADOQueryInsercao.ExecSQL;
          Application.MessageBox('Material para trabalho cadastrado com sucesso!','Cadastro', MB_OK + MB_ICONINFORMATION);
          ButtonSalvar.Enabled := False;
        end
      else Application.MessageBox('Já existe um material cadastrado com esse nome!','Erro ao cadastrar', MB_OK + MB_ICONERROR);
    end
  else Application.MessageBox('Preencha todos os campos!','Erro ao cadastrar', MB_OK + MB_ICONERROR);
end;

procedure TForm_Cadastro_Materiais.EditDescricaoChange(Sender: TObject);
var
  qtdcaracteres : Integer;
begin
  qtdcaracteres :=  length(EditDescricao.text);
  LabelCaracteres.Caption := inttostr(qtdcaracteres)+'\500';
end;

procedure TForm_Cadastro_Materiais.edvalortotalKeyUp(Sender: TObject;
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

procedure TForm_Cadastro_Materiais.FormShow(Sender: TObject);
begin
  ButtonLimparClick(Sender);
end;

end.
