unit U_Backup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm_Backup = class(TForm)
    ADOQueryDados: TADOQuery;
    ADOConnection1: TADOConnection;
    ADOQueryGerarBackup: TADOQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    ButtonConfirmar: TSpeedButton;
    Label1: TLabel;
    ButtonFazerBackup: TSpeedButton;
    ButtonRestore: TSpeedButton;
    ADOQueryRestore: TADOQuery;
    ADOQueryDadosDIA: TStringField;
    ADOQueryDadosID: TAutoIncField;
    ADOQueryDadosDATA: TDateTimeField;
    ADOQueryDadosFREQUENCIA: TIntegerField;
    ADOQueryUpdate: TADOQuery;
    ADOConnection2: TADOConnection;
    procedure FormShow(Sender: TObject);
    procedure ButtonConfirmarClick(Sender: TObject);
    procedure ButtonFazerBackupClick(Sender: TObject);
    procedure ButtonRestoreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Backup: TForm_Backup;

implementation

{$R *.dfm}

procedure TForm_Backup.ButtonConfirmarClick(Sender: TObject);
begin
  ADOQueryUpdate.Close;
  ADOQueryUpdate.Parameters.ParamByName('FREQ').Value := RadioGroup1.ItemIndex;
  ADOQueryUpdate.ExecSQL;
  Application.MessageBox('Frequência do Backup alterada com sucesso!','Sãlão da Laura - Backup', MB_OK + MB_ICONINFORMATION);
end;

procedure TForm_Backup.ButtonFazerBackupClick(Sender: TObject);
var
  caminho: string;
begin
  caminho := ExtractFilePath(Application.ExeName);
  caminho := caminho + 'BACKUP\BACKUP.bak';
  ADOQueryGerarBackup.Close;
  ADOQueryGerarBackup.Parameters.ParamByName('CAMINHO').Value := caminho;
  ADOQueryGerarBackup.ExecSQL;
  Application.MessageBox('Backup realizado com sucesso!','Salão da Laura', MB_OK + MB_ICONINFORMATION);
end;

procedure TForm_Backup.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;
  ADOQueryDados.Close;
  ADOQueryDados.Open;
  ADOQueryDados.First;
  Label1.Caption := Label1.Caption + ' ' + ADOQueryDadosDIA.AsString;
  RadioGroup1.ItemIndex := ADOQueryDadosFREQUENCIA.AsInteger;
end;

procedure TForm_Backup.ButtonRestoreClick(Sender: TObject);
var
  local : string;
begin
  ADOConnection1.Connected := False;
  local := ExtractFilePath(Application.ExeName);
  local := local + 'BACKUP\BACKUP.bak';
  if FileExists(local) then
    begin
      ADOQueryRestore.Close;
      ADOQueryRestore.Parameters.ParamByName('CAMINHO').Value := local;
      ADOQueryRestore.ExecSQL;
      Application.MessageBox('Dados restaurados com sucesso!', 'Salão da Laura', MB_OK + MB_ICONINFORMATION);
    end
  else Application.MessageBox('Nenhum arquivo de Backup encontrado!', 'Erro', MB_OK + MB_ICONERROR);
  ADOConnection1.Connected := True;
end;

end.
