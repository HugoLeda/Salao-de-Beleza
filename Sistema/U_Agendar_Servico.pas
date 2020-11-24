unit U_Agendar_Servico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  Vcl.ComCtrls, Vcl.WinXCtrls, Data.Win.ADODB, DateTimePicker.Interposer;

type
  TForm_Agendar_Servico = class(TForm)
    TimePicker1: TTimePicker;
    GBAgendar: TGroupBox;
    GBGrid: TGroupBox;
    PanelBotoes: TPanel;
    GBPesquisa: TGroupBox;
    ButtonAgendar: TSpeedButton;
    ButtonExcluir: TSpeedButton;
    ButtonSair: TSpeedButton;
    DBGrid1: TDBGrid;
    ButtonSalvar: TSpeedButton;
    ButtonCancelar: TSpeedButton;
    ButtonLimpar: TSpeedButton;
    SearchBox1: TSearchBox;
    LabelPesquisar: TLabel;
    DateTimePicker1: TDateTimePicker;
    DBLCliente: TDBLookupComboBox;
    DBLFunc: TDBLookupComboBox;
    DBLCadeira: TDBLookupComboBox;
    DBLServico: TDBLookupComboBox;
    ADOConnection1: TADOConnection;
    ADOQueryFunc: TADOQuery;
    ADOQueryServico: TADOQuery;
    ADOQueryCadeira: TADOQuery;
    ADOQueryCliente: TADOQuery;
    ADOQueryClienteCODIGO: TAutoIncField;
    ADOQueryClienteNOME: TStringField;
    ADOQueryClienteCPF: TStringField;
    DSCli: TDataSource;
    DSFunc: TDataSource;
    DSServico: TDataSource;
    DSCadeira: TDataSource;
    DSAgendamento: TDataSource;
    ADOQueryAgendamentos: TADOQuery;
    ADOQueryFuncCODIGO: TAutoIncField;
    ADOQueryFuncNOME: TStringField;
    ADOQueryFuncCARGO: TStringField;
    ADOQueryServicoNOME: TStringField;
    ADOQueryServicoPRECO: TBCDField;
    ADOQueryServicoDURACAO: TIntegerField;
    ADOQueryServicoCODIGO: TAutoIncField;
    ADOQueryCadeiraCODIGO: TAutoIncField;
    ADOQueryCadeiraTIPO: TStringField;
    ADOQueryCadeiraDESCRICAO: TStringField;
    Splitter1: TSplitter;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ScrollBox1: TScrollBox;
    ADOQueryAgendamentosCODAGENDAMENTO: TAutoIncField;
    ADOQueryAgendamentosDIA: TWideStringField;
    ADOQueryAgendamentosHORA: TWideStringField;
    ADOQueryAgendamentosHORARIO: TStringField;
    ADOQueryAgendamentosNOME: TStringField;
    ADOQueryAgendamentosPRECO: TBCDField;
    ADOQueryAgendamentosDURACAO: TIntegerField;
    ADOQueryAgendamentosCODFUNC: TAutoIncField;
    ADOQueryAgendamentosFUNC: TStringField;
    ADOQueryAgendamentosCODCLI: TAutoIncField;
    ADOQueryAgendamentosCLI: TStringField;
    ADOQueryAgendamentosCODCADEIRA: TAutoIncField;
    ADOQueryAgendamentosCADEIRA: TStringField;
    ScrollBox2: TScrollBox;
    ADOQueryAgendamentosDATA: TStringField;
    ADOQueryVerificaCli: TADOQuery;
    ADOQueryInserir: TADOQuery;
    ADOQueryVeriFunc: TADOQuery;
    ADOQueryVeriCadeira: TADOQuery;
    ADOQueryExcluir: TADOQuery;
    ADOQueryExcluirAntigos: TADOQuery;
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonAgendarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure DSAgendamentoDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    Cod : integer;
    CampoFiltro : String;
  end;

var
  Form_Agendar_Servico: TForm_Agendar_Servico;

implementation

{$R *.dfm}

uses U_Principal;

procedure TForm_Agendar_Servico.ButtonAgendarClick(Sender: TObject);
begin
  GBPesquisa.Visible := False;
  GBAgendar.Visible := True;
  Splitter1.Visible := True;
  ButtonAgendar.Visible := False;
  ButtonExcluir.Visible := False;
  ButtonCancelar.Visible := True;
  ButtonSalvar.Visible := True;
  ButtonLimpar.Visible := True;
  DBLCliente.SetFocus;
end;

procedure TForm_Agendar_Servico.ButtonSairClick(Sender: TObject);
begin
  Form_Agendar_Servico.Close;
end;

procedure TForm_Agendar_Servico.ButtonSalvarClick(Sender: TObject);
var
  i : integer;
  Hora: String;
begin
  for I := 1 to 5 do
    begin
      Hora := Hora + Copy(TimeToStr(TimePicker1.Time),i,1);
    end;
  Hora := Hora + ':00';
  if DBLCliente.KeyValue = 0 then
    begin
      Application.MessageBox('Selecione um cliente!','Alerta', MB_OK + MB_ICONWARNING);
      Exit;
    end;
  if DBLFunc.KeyValue = 0 then
    begin
      Application.MessageBox('Selecione um funcionário!','Alerta', MB_OK + MB_ICONWARNING);
      Exit;
    end;
  if DBLCadeira.KeyValue = 0 then
    begin
      Application.MessageBox('Selecione uma cadeira!','Alerta', MB_OK + MB_ICONWARNING);
      Exit;
    end;
  if DBLServico.KeyValue = 0 then
    begin
      Application.MessageBox('Selecione um serviço!','Alerta', MB_OK + MB_ICONWARNING);
      Exit;
    end;
  if DateTimePicker1.Date = Date then
    if TimePicker1.Time <= Time then
      begin
        Application.MessageBox('Horário inválido!','Alerta', MB_OK + MB_ICONWARNING);
        Exit;
      end;
  if DateTimePicker1.Date < Date then
    begin
      Application.MessageBox('Data inválida!','Alerta', MB_OK + MB_ICONWARNING);
      Exit;
    end;

  ADOQueryVerificaCli.Close;
  ADOQueryVerificaCli.Parameters.ParamByName('CLI').Value := DBLCliente.KeyValue;
  ADOQueryVerificaCli.Parameters.ParamByName('DIA').Value := DateToStr(DateTimePicker1.Date);
  ADOQueryVerificaCli.Parameters.ParamByName('HORA').Value := Hora;
  ADOQueryVerificaCli.Open;
  if ADOQueryVerificaCli.RecordCount > 0 then
    begin
      Application.MessageBox('O cliente já está com esse horário marcado!','Informação', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

  ADOQueryVeriFunc.Close;
  ADOQueryVeriFunc.Parameters.ParamByName('FUNC').Value := DBLFunc.KeyValue;
  ADOQueryVeriFunc.Parameters.ParamByName('DIA').Value := DateToStr(DateTimePicker1.Date);
  ADOQueryVeriFunc.Parameters.ParamByName('HORA').Value := Hora;
  ADOQueryVeriFunc.Open;
  if ADOQueryVerificaCli.RecordCount > 0 then
    begin
      Application.MessageBox('O funcionário não está disponível nesse horário!','Informação', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

  ADOQueryVeriCadeira.Close;
  ADOQueryVeriCadeira.Parameters.ParamByName('CADEIRA').Value := DBLCadeira.KeyValue;
  ADOQueryVeriCadeira.Parameters.ParamByName('DIA').Value := DateToStr(DateTimePicker1.Date);
  ADOQueryVeriCadeira.Parameters.ParamByName('HORA').Value := Hora;
  ADOQueryVeriCadeira.Open;
   if ADOQueryVerificaCli.RecordCount > 0 then
    begin
      Application.MessageBox('A cadeira selecionaa não está disponível nesse horário!','Informação', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

  ADOQueryInserir.Close;
  ADOQueryInserir.Parameters.ParamByName('SERVICO').Value := DBLServico.KeyValue;
  ADOQueryInserir.Parameters.ParamByName('CADEIRA').Value := DBLCadeira.KeyValue;
  ADOQueryInserir.Parameters.ParamByName('HORA').Value := Hora;
  ADOQueryInserir.Parameters.ParamByName('DIA').Value := DateToStr(DateTimePicker1.Date);
  ADOQueryInserir.Parameters.ParamByName('CLIENTE').Value := DBLCliente.KeyValue;
  ADOQueryInserir.Parameters.ParamByName('FUNCIONARIO').Value := DBLFunc.KeyValue;
  ADOQueryInserir.ExecSQL;
  Application.MessageBox('Agendamento realizado com sucesso!','Agendamento', MB_OK + MB_ICONINFORMATION);
  FormShow(Sender);
end;

procedure TForm_Agendar_Servico.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid1 do
    begin
      if Odd(DSAgendamento.DataSet.RecNo)then
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

procedure TForm_Agendar_Servico.DBGrid1TitleClick(Column: TColumn);
begin
  if SearchBox1.Visible = True then
    begin
      LabelPesquisar.Caption := Column.Title.Caption + ': ';
      CampoFiltro := Column.FieldName;

      if (ADOQueryAgendamentos.FieldByName(CampoFiltro)is TAutoIncField) or
         (ADOQueryAgendamentos.FieldByName(CampoFiltro)is TIntegerField) or
         (ADOQueryAgendamentos.FieldByName(CampoFiltro)is TBCDField)then
        begin
          SearchBox1.NumbersOnly := True;
        end
      else SearchBox1.NumbersOnly := False;

      SearchBox1.Text := '';
      SearchBox1.SetFocus;
      ADOQueryAgendamentos.Filtered := False;
    end;
end;

procedure TForm_Agendar_Servico.DSAgendamentoDataChange(Sender: TObject;
  Field: TField);
begin
  Cod := ADOQueryAgendamentosCODAGENDAMENTO.AsInteger;
end;

procedure TForm_Agendar_Servico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Form_Principal.FormShow(Sender);
end;

procedure TForm_Agendar_Servico.FormShow(Sender: TObject);
var
  Dia : string;
begin
  Dia := DateToStr(Date);
  ADOQueryAgendamentos.Close;
  ADOQueryAgendamentos.Parameters.ParamByName('DIA').Value := Dia;
  ADOQueryAgendamentos.Open;
  ADOQueryExcluirAntigos.Close;
  ADOQueryExcluirAntigos.Parameters.ParamByName('DIA').Value := Dia;
  ADOQueryExcluirAntigos.ExecSQL;
  GBPesquisa.Visible := True;
  GBAgendar.Visible := False;
  Splitter1.Visible := False;
  ButtonLimpar.Visible := False;
  ButtonSalvar.Visible := False;
  ButtonCancelar.Visible := False;
  ButtonExcluir.Visible := True;
  ButtonAgendar.Visible := True;
  ADOQueryAgendamentos.Close;
  ADOQueryAgendamentos.Open;
  SearchBox1.Enabled := True;
  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  LabelPesquisar.Caption := DBGrid1.Columns[1].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[1].FieldName;
  ButtonLimparClick(Sender);
end;

procedure TForm_Agendar_Servico.SearchBox1Change(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQueryAgendamentos.Filtered := False;
    end
  else if (ADOQueryAgendamentos.FieldByName(CampoFiltro) is TStringField) then
    begin
      SearchBox1InvokeSearch(Sender);
    end;
end;

procedure TForm_Agendar_Servico.SearchBox1InvokeSearch(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQueryAgendamentos.Filtered := False;
      exit
    end;

   if (ADOQueryAgendamentos.FieldByName(CampoFiltro) is TStringField) and (Length(SearchBox1.Text) <> 0) then
     begin
       ADOQueryAgendamentos.Filter := CampoFiltro + ' like ' + QuotedStr('*' + SearchBox1.Text + '*');
     end
   else
     begin
       ADOQueryAgendamentos.Filter := CampoFiltro + ' = ' + SearchBox1.Text;
     end;
   ADOQueryAgendamentos.Filtered := True;
end;

procedure TForm_Agendar_Servico.ButtonCancelarClick(Sender: TObject);
begin
  GBPesquisa.Visible := True;
  GBAgendar.Visible := False;
  Splitter1.Visible := False;
  ButtonLimpar.Visible := False;
  ButtonSalvar.Visible := False;
  ButtonCancelar.Visible := False;
  ButtonExcluir.Visible := True;
  ButtonAgendar.Visible := True;
end;

procedure TForm_Agendar_Servico.ButtonExcluirClick(Sender: TObject);
begin
  ADOQueryExcluir.Close;
  ADOQueryExcluir.Parameters.ParamByName('COD').Value := Cod;
  ADOQueryExcluir.ExecSQL;
  FormShow(Sender);
end;

procedure TForm_Agendar_Servico.ButtonLimparClick(Sender: TObject);
begin
  SearchBox1.Text := '';
  ADOQueryFunc.Close;
  ADOQueryFunc.Open;
  ADOQueryServico.Close;
  ADOQueryServico.Open;
  ADOQueryCadeira.Close;
  ADOQueryCadeira.Open;
  ADOQueryCliente.Close;
  ADOQueryCliente.Open;
  DBLCliente.KeyValue := 0;
  DBLFunc.KeyValue := 0;
  DBLCadeira.KeyValue := 0;
  DBLServico.KeyValue := 0;
  DateTimePicker1.Date := Date;
  TimePicker1.Time := Time;
end;

end.
