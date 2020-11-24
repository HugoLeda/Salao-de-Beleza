unit U_Cadastro_Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.WinXCalendars, Vcl.ComCtrls, DateTimePicker.Interposer;

type
  TForm_Cadastro_Funcionario = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOQuery1CODIGO: TAutoIncField;
    ADOQuery1NOME: TStringField;
    ADOQuery1TELEFONE: TStringField;
    ADOQuery1D_NASC: TWideStringField;
    ADOQuery1SEXO: TStringField;
    ADOQuery1RG: TStringField;
    ADOQuery1CPF: TStringField;
    ADOQuery1CIDADE: TStringField;
    ADOQuery1ESTADO: TIntegerField;
    ADOQuery1ENDERECO: TStringField;
    ADOQuery1BAIRRO: TStringField;
    ADOQuery1SALARIO: TBCDField;
    Label1: TLabel;
    DataSourceES: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit6: TEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Edit7: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ADOQueryES: TADOQuery;
    Edit9: TEdit;
    Edit10: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Image1: TImage;
    Label14: TLabel;
    Image2: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    ADOQuery2: TADOQuery;
    ADOQuery2CODIGO: TIntegerField;
    ADOQuery2SIGLA: TStringField;
    ADOQuery2ESTADO: TStringField;
    Image3: TImage;
    DBLookupComboBox2: TDBLookupComboBox;
    ADOQueryCidades: TADOQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    ADOQueryVerificaCidade: TADOQuery;
    DateTimePicker1: TDateTimePicker;
    ADOQueryCPF: TADOQuery;
    edvalortotal: TEdit;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure DBLookupComboBox2DropDown(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure edvalortotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Cadastro_Funcionario: TForm_Cadastro_Funcionario;

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

procedure TForm_Cadastro_Funcionario.CheckBox1Click(Sender: TObject);
begin
  if CheckBox2.Checked = True then
    CheckBox2.Checked := False;

end;

procedure TForm_Cadastro_Funcionario.CheckBox2Click(Sender: TObject);
begin
 if CheckBox1.Checked = True then
    CheckBox1.Checked := False;

end;

procedure TForm_Cadastro_Funcionario.DBLookupComboBox1Click(Sender: TObject);
begin
  DBLookupComboBox2.Enabled := True;
  ADOQueryCidades.Open;
end;

procedure TForm_Cadastro_Funcionario.DBLookupComboBox2DropDown(Sender: TObject);
var
  a : Integer;
begin
  a := DBLookupComboBox1.KeyValue;
  ADOQueryCidades.Close;
  ADOQueryCidades.Parameters.ParamByName('ESTADO').Value := a;
  ADOQueryCidades.Open;
end;

procedure TForm_Cadastro_Funcionario.Edit1Click(Sender: TObject);
begin
  ADOQueryES.Open;
end;

procedure TForm_Cadastro_Funcionario.Edit2Click(Sender: TObject);
begin
  ADOQueryES.Open;
end;

procedure TForm_Cadastro_Funcionario.Edit2KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(Edit2.Text) = 3 then
      begin
         Edit2.Text := Edit2.Text + '.';
         Edit2.Selstart := Length(Edit2.text);
      end;

   if Length(Edit2.Text) = 7 then
      begin
         Edit2.Text := Edit2.Text + '.';
         Edit2.Selstart := Length(Edit2.text);
      end;

   if Length(Edit2.Text) = 11 then
      begin
         Edit2.Text := Edit2.Text + '-';
         Edit2.Selstart := Length(Edit2.text);
      end;
end;

procedure TForm_Cadastro_Funcionario.Edit3KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(Edit3.Text) = 2 then
      begin
         Edit3.Text := Edit3.Text + '.';
         Edit3.Selstart := Length(Edit3.text);
      end;

   if Length(Edit3.Text) = 6 then
      begin
         Edit3.Text := Edit3.Text + '.';
         Edit3.Selstart := Length(Edit3.text);
      end;

   if Length(Edit3.Text) = 10 then
      begin
         Edit3.Text := Edit3.Text + '-';
         Edit3.Selstart := Length(Edit3.text);
      end;
end;

procedure TForm_Cadastro_Funcionario.Edit4KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(Edit4.Text) = 1 then
      begin
         Edit4.Text := '(' + Edit4.Text;
         Edit4.Selstart := Length(Edit4.text);
      end;

   if Length(Edit4.Text) = 3 then
      begin
         Edit4.Text := Edit4.Text + ') ';
         Edit4.Selstart := Length(Edit4.text);
      end;

   if Length(Edit4.Text) = 10 then
      begin
         Edit4.Text := Edit4.Text + '-';
         Edit4.Selstart := Length(Edit4.text);
      end;
end;

procedure TForm_Cadastro_Funcionario.edvalortotalKeyUp(Sender: TObject;
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

procedure TForm_Cadastro_Funcionario.FormShow(Sender: TObject);
begin
  SpeedButton3Click(Sender);
  ADOQueryES.Close;
  ADOQueryES.Open;
  SpeedButton2.Enabled := True;
end;

procedure TForm_Cadastro_Funcionario.SpeedButton1Click(Sender: TObject);
begin
  SpeedButton3Click(Sender);
  SpeedButton1.Enabled := False;
  SpeedButton2.Enabled := True;
end;

procedure TForm_Cadastro_Funcionario.SpeedButton2Click(Sender: TObject);
var
  Cod_Estado, CIDADE, Diferenca : Integer;
  Data : string;
  Sexo : string;
  Data_Nasc, Data_atual  : TDateTime;
  AnoNasc, AnoAtual, MesNasc, MesAtual, DiaNasc, DiaAtual  : Word;
begin
  Edit10.Text := edvalortotal.Text;
  DeleteChar('.', Edit10.Text);
  DeleteChar('R', Edit10.Text);
  DeleteChar('$', Edit10.Text);
  if (DBLookupComboBox1.KeyValue > 0) and (DBLookupComboBox2.KeyValue > 0) then
    begin
      Cod_Estado := DBLookupComboBox1.KeyValue;
      Cidade := DBLookupComboBox2.KeyValue;
      ADOQueryVerificaCidade.Close;
      ADOQueryVerificaCidade.Parameters.ParamByName('ESTADO').Value := Cod_Estado;
      ADOQueryVerificaCidade.Parameters.ParamByName('CIDADE').Value := CIDADE;
      ADOQueryVerificaCidade.Open;
    end;

  Data := DateToStr(DateTimePicker1.Date);

  Sexo := '';
  if CheckBox1.Checked = True then
    begin
      Sexo := 'F';
    end;

  if CheckBox2.Checked = True then
    begin
      Sexo := 'M';
    end;

  if (Edit1.Text <> '') and (Edit2.Text <> '')   and
     (Edit3.Text <> '') and (Edit4.Text <> '')   and
     (Edit6.Text <> '') and (Sexo <> '')         and
     (Edit7.Text <> '') and
     (Edit9.Text <> '') and (Edit10.Text <> '')  then
    begin
      Data_atual := Date;
      Data_Nasc := DateTimePicker1.Date;
      decodedate(Data_Nasc,AnoNasc,MesNasc,DiaNasc);
      decodedate(Data_Atual,AnoAtual,MesAtual,DiaAtual);
      Diferenca := AnoAtual - AnoNasc;
      if MesNasc > MesAtual then
        begin
          Diferenca := Diferenca - 1;
        end
      else if MesNasc = MesAtual then
        begin
          if DiaNasc > DiaAtual then
            begin
              Diferenca := Diferenca - 1;
            end;
        end;
      if (Diferenca >= 16) then
        begin
          ADOQueryCPF.Close;
          ADOQueryCPF.Parameters.ParamByName('CPF').Value := Edit2.Text;
          ADOQueryCPF.Open;
          if ADOQueryCPF.RecordCount = 0 then
            begin
              ADOQueryVerificaCidade.Close;
              ADOQueryVerificaCidade.Parameters.ParamByName('ESTADO').Value := Cod_Estado;
              ADOQueryVerificaCidade.Parameters.ParamByName('CIDADE').Value := Cidade;
              ADOQueryVerificaCidade.Open;
              if ADOQueryVerificaCidade.RecordCount = 1  then
                begin
                  ADOQuery1.Parameters.ParamByName('NOME').Value := Edit1.Text;
                  ADOQuery1.Parameters.ParamByName('TELEFONE').Value := Edit4.Text;
                  ADOQuery1.Parameters.ParamByName('D_NASC').Value := DateToStr(DateTimePicker1.Date);
                  ADOQuery1.Parameters.ParamByName('SEXO').Value := Sexo;
                  ADOQuery1.Parameters.ParamByName('RG').Value := Edit3.Text;
                  ADOQuery1.Parameters.ParamByName('CPF').Value := Edit2.Text;
                  ADOQuery1.Parameters.ParamByName('CIDADE').Value := CIDADE;
                  ADOQuery1.Parameters.ParamByName('ESTADO').Value := Cod_Estado;
                  ADOQuery1.Parameters.ParamByName('ENDERECO').Value := Edit6.Text;
                  ADOQuery1.Parameters.ParamByName('BAIRRO').Value := Edit7.Text;
                  ADOQuery1.Parameters.ParamByName('CARGO').Value := Edit9.Text;
                  ADOQuery1.Parameters.ParamByName('SALARIO').Value := Edit10.Text;
                  ADOQuery1.ExecSQL;
                  Application.MessageBox('Funcionário cadastrado com sucesso!','Cadastro de funcionário', MB_OK + MB_ICONINFORMATION);
                  SpeedButton2.Enabled := False;
                  SpeedButton1.Enabled := True;
                end
             else Application.MessageBox('Verifique a cidade!','Alerta', MB_OK + MB_ICONWARNING);
            end
          else Application.MessageBox('Já existe um funcionário com esse CPF.','Informação', MB_OK + MB_ICONINFORMATION);
        end
      else Application.MessageBox('Necessário ter pelo menos 16 anos para realizar o cadastro','Informação', MB_OK + MB_ICONINFORMATION);
    end
  else Application.MessageBox('Preencha todos os campos!', 'Erro ao cadastrar', MB_OK + MB_ICONERROR);
end;

procedure TForm_Cadastro_Funcionario.SpeedButton3Click(Sender: TObject);
begin
  DateTimePicker1.Date := Date;
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  Edit6.Text := '';
  Edit7.Text := '';
  Edit9.Text := '';
  Edit10.Text := '';
  edvalortotal.Text := '';
  CheckBox1.Checked := False;
  CheckBox2.Checked := False;
  DBLookupComboBox1.KeyValue := 0;
  ADOQueryCidades.Close;
  DBLookupComboBox2.Enabled := False;
  DBLookupComboBox2.KeyValue := 0;
  ADOQueryES.Close;
  Edit1.SetFocus;
end;

procedure TForm_Cadastro_Funcionario.SpeedButton4Click(Sender: TObject);
begin
  if (Edit1.Text <> '') or (Edit2.Text <> '')   or
     (Edit3.Text <> '') or (Edit4.Text <> '')   or
     (Edit6.Text <> '') or (CheckBox1.Checked = False) or
     (Edit7.Text <> '') or (CheckBox2.Checked = False) or
     (Edit9.Text <> '') or (Edit10.Text <> '')  then
    begin
      if Application.MessageBox('Deseja sair?','Sair',mb_iconquestion + MB_YESNO + mb_defbutton1) = id_yes then
        begin
          SpeedButton3Click(Sender);
          Form_Cadastro_Funcionario.Close;
        end;
    end
  else Form_Cadastro_Funcionario.Close;
end;

end.
