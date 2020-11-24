unit U_Cadastro_Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Mask, Data.Win.ADODB, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg,
  Vcl.Buttons, Vcl.CheckLst, Vcl.ComCtrls, DateTimePicker.Interposer;

type

  NewTypeNav = class( TDbNavigator );

type
  TForm_Cadastro_Clientes = class(TForm)
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    ADOQuery1CODIGO: TAutoIncField;
    ADOQuery1NOME: TStringField;
    ADOQuery1TELEFONE: TStringField;
    ADOQuery1DNASC: TWideStringField;
    ADOQuery1SEXO: TStringField;
    ADOQuery1RG: TStringField;
    ADOQuery1CPF: TStringField;
    ADOQuery1CIDADE: TStringField;
    ADOQuery1ESTADO: TIntegerField;
    ADOQuery1ENDERECO: TStringField;
    ADOQuery1BAIRRO: TStringField;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DataSource1: TDataSource;
    Label11: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    ADOQueryESTADOS: TADOQuery;
    ADOQueryESTADOSCODIGO: TIntegerField;
    ADOQueryESTADOSSIGLA: TStringField;
    DataSourceES: TDataSource;
    SpeedButton1: TSpeedButton;
    DBLookupComboBox1: TDBLookupComboBox;
    ADOQuery3: TADOQuery;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    DBEdit1: TEdit;
    DBEdit6: TEdit;
    DBEdit5: TEdit;
    DBEdit4: TEdit;
    DBEdit9: TEdit;
    DBEdit10: TEdit;
    DBEdit2: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ADOQueryESTADOSESTADO: TStringField;
    DBLookupComboBox2: TDBLookupComboBox;
    ADOQueryCidades: TADOQuery;
    DataSource2: TDataSource;
    ADOQueryCidadesCODIGO: TIntegerField;
    ADOQueryCidadesNOME: TStringField;
    ADOQueryCidadesESTADO: TIntegerField;
    ADOQueryCidadesCAPITAL: TBooleanField;
    DateTimePicker1: TDateTimePicker;
    ADOQueryVerificaCidade: TADOQuery;
    ADOQueryCPF: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure DBLookupComboBox2DropDown(Sender: TObject);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit5KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form_Cadastro_Clientes: TForm_Cadastro_Clientes;

implementation

{$R *.dfm}

uses U_FormataEdit;

procedure TForm_Cadastro_Clientes.CheckBox1Click(Sender: TObject);
begin
  if CheckBox2.Checked = True then
    CheckBox2.Checked := False;
end;

procedure TForm_Cadastro_Clientes.CheckBox2Click(Sender: TObject);
begin
  if CheckBox1.Checked = True then
    CheckBox1.Checked := False;

end;

procedure TForm_Cadastro_Clientes.DBEdit2KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(DBEdit2.Text) = 1 then
      begin
         DBEdit2.Text := '(' + DBEdit2.Text;
         DBEdit2.Selstart := Length(DBEdit2.text);
      end;

   if Length(DBEdit2.Text) = 3 then
      begin
         DBEdit2.Text := DBEdit2.Text + ') ';
         DBEdit2.Selstart := Length(DBEdit2.text);
      end;

   if Length(DBEdit2.Text) = 10 then
      begin
         DBEdit2.Text :=DBEdit2.Text + '-';
         DBEdit2.Selstart := Length(DBEdit2.text);
      end;
end;

procedure TForm_Cadastro_Clientes.DBEdit5KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(DBEdit5.Text) = 2 then
      begin
         DBEdit5.Text := DBEdit5.Text + '.';
         DBEdit5.Selstart := Length(DBEdit5.text);
      end;

   if Length(DBEdit5.Text) = 6 then
      begin
         DBEdit5.Text := DBEdit5.Text + '.';
         DBEdit5.Selstart := Length(DBEdit5.text);
      end;

   if Length(DBEdit5.Text) = 10 then
      begin
         DBEdit5.Text := DBEdit5.Text + '-';
         DBEdit5.Selstart := Length(DBEdit5.text);
      end;
end;

procedure TForm_Cadastro_Clientes.DBEdit6KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #8 then
      exit;

   if Length(DBEdit6.Text) = 3 then
      begin
         DBEdit6.Text := DBEdit6.Text + '.';
         DBEdit6.Selstart := Length(DBEdit6.text);
      end;

   if Length(DBEdit6.Text) = 7 then
      begin
         DBEdit6.Text := DBEdit6.Text + '.';
         DBEdit6.Selstart := Length(DBEdit6.text);
      end;

   if Length(DBEdit6.Text) = 11 then
      begin
         DBEdit6.Text := DBEdit6.Text + '-';
         DBEdit6.Selstart := Length(DBEdit6.text);
      end;
end;

procedure TForm_Cadastro_Clientes.DBLookupComboBox1Click(Sender: TObject);
var
  Es : Integer;
begin
  Es := DBLookupComboBox1.KeyValue;
  ADOQueryCidades.Parameters.ParamByName('ESTADO').Value := Es;
end;

procedure TForm_Cadastro_Clientes.DBLookupComboBox2DropDown(Sender: TObject);
var
  a : Integer;
begin
  a := DBLookupComboBox1.KeyValue;
  ADOQueryCidades.Close;
  ADOQueryCidades.Parameters.ParamByName('ESTADO').Value := a;
  ADOQueryCidades.Open;

end;

procedure TForm_Cadastro_Clientes.FormCreate(Sender: TObject);
var

  c: Tbitmap;

begin

  //c:=Tbitmap.Create;

  //c.LoadFromFile('Visual\novo preo.bmp');

  //newtypenav(dbnavigator1).buttons[nbInsert].Glyph:=c;

end;

procedure TForm_Cadastro_Clientes.FormShow(Sender: TObject);
begin
  SpeedButton4Click(Sender);
  SpeedButton4.Enabled := True;
end;

procedure TForm_Cadastro_Clientes.SpeedButton1Click(Sender: TObject);
var
  Cod_Estado, CIDADE: integer;
  Data_Nasc, Data_atual  : TDateTime;
  AnoNasc, AnoAtual, MesNasc, MesAtual, DiaNasc, DiaAtual  : Word;
  Diferenca : Integer;
begin
  if (DBLookupComboBox1.KeyValue > 0) and (DBLookupComboBox2.KeyValue > 0) then
    begin
      Cod_Estado := DBLookupComboBox1.KeyValue;
      Cidade := DBLookupComboBox2.KeyValue;
      ADOQueryVerificaCidade.Close;
      ADOQueryVerificaCidade.Parameters.ParamByName('ESTADO').Value := Cod_Estado;
      ADOQueryVerificaCidade.Parameters.ParamByName('CIDADE').Value := CIDADE;
      ADOQueryVerificaCidade.Open;
    end;

  if CheckBox1.Checked = True then
    begin
      DBEdit4.Text := 'F';
    end;

  if CheckBox2.Checked = True then
    begin
      DBEdit4.Text := 'M';
    end;

  if (DBEdit1.Text <> '') and (DBEdit2.Text <> '') and
     (DBEdit4.Text <> '') and (DBEdit5.Text <> '') and
     (Length(DBEdit6.Text) = 14) and (DBEdit9.Text <> '') and
     (DBEdit10.Text <> '') then
    begin
      Data_Atual := Date;
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
      if (Diferenca >=  18) then
        begin
          ADOQueryCPF.Close;
          ADOQueryCPF.Parameters.ParamByName('CPF').Value := DBEdit6.Text;
          ADOQueryCPF.Open;
          if ADOQueryCPF.RecordCount = 0 then
            begin
              if ADOQueryVerificaCidade.RecordCount = 1  then
                begin
                  ADOQuery3.Parameters.ParamByName('NOME').Value := DBEdit1.Text;
                  ADOQuery3.Parameters.ParamByName('TELEFONE').Value := DBEdit2.Text;
                  ADOQuery3.Parameters.ParamByName('DNASC').Value := DateToStr(DateTimePicker1.Date);
                  ADOQuery3.Parameters.ParamByName('SEXO').Value := DBEdit4.Text;
                  ADOQuery3.Parameters.ParamByName('RG').Value := DBEdit5.Text;
                  ADOQuery3.Parameters.ParamByName('CPF').Value := DBEdit6.Text;
                  ADOQuery3.Parameters.ParamByName('CIDADE').Value := CIDADE;
                  ADOQuery3.Parameters.ParamByName('ESTADO').Value := Cod_Estado;
                  ADOQuery3.Parameters.ParamByName('ENDERECO').Value := DBEdit9.Text;
                  ADOQuery3.Parameters.ParamByName('BAIRRO').Value := DBEdit10.Text;
                  ADOQuery3.ExecSQL;
                  Application.MessageBox('Cliente cadastrado com sucesso!','Cadastro de cliente', MB_OK + MB_ICONINFORMATION);
                  SpeedButton1.Enabled := False;
                  SpeedButton2.Enabled := True;
                end
              else
               begin
                 Application.MessageBox('Verifique a cidade!','Alerta', MB_OK + MB_ICONWARNING);
               end;
            end
          else
            begin
              Application.MessageBox('O CPF digitado já foi cadastrado', 'Informação', MB_OK + MB_ICONINFORMATION);
            end;
        end
      else
        begin
          Application.MessageBox('Necessário ter pelo menos 18 anos para realizar o cadastro', 'Informação', MB_OK + MB_ICONINFORMATION);
        end;
    end
  else
    begin
      Application.MessageBox('Preencha corretamente todos os campos!','Alerta', MB_OK + MB_ICONWARNING);
    end;

end;

procedure TForm_Cadastro_Clientes.SpeedButton2Click(Sender: TObject);
begin
  SpeedButton4Click(Sender);
  SpeedButton2.Enabled := False;
  SpeedButton1.Enabled := True;
end;

procedure TForm_Cadastro_Clientes.SpeedButton3Click(Sender: TObject);
begin
  if (DBEdit1.Text <> '') or (DBEdit2.Text <> '') or
     (DBEdit4.Text <> '') or (DBEdit5.Text <> '') or
     (DBEdit6.Text <> '') or (DBEdit9.Text <> '') or
     (DBEdit10.Text <> '') then
    begin
      if Application.MessageBox('Deseja sair?','Sair',mb_iconquestion + MB_YESNO + mb_defbutton1) = id_yes then
        begin
          Form_Cadastro_Clientes.Close;
        end;
    end
  else Form_Cadastro_Clientes.Close;
end;

procedure TForm_Cadastro_Clientes.SpeedButton4Click(Sender: TObject);
begin
  DBEdit1.Text := '';
  DBEdit2.Text := '';
  DBEdit4.Text := '';
  DBEdit5.Text := '';
  DBEdit6.Text := '';
  DBEdit9.Text := '';
  DBEdit10.Text := '';
  CheckBox1.Checked := False;
  CheckBox2.Checked := False;
  DBEdit1.SetFocus;
  DateTimePicker1.Date := date;
  DBLookupComboBox1.KeyValue := 0;
  DBLookupComboBox2.KeyValue := 0;
end;

end.
