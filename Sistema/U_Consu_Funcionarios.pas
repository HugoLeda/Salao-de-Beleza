unit U_Consu_Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls, Vcl.ComCtrls,
  Vcl.DBCtrls, DateTimePicker.Interposer, Vcl.Menus;

type
  TForm_Consu_Func = class(TForm)
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
    ADOQuery1NOME: TStringField;
    ADOQuery1SEXO: TStringField;
    ADOQuery1RG: TStringField;
    ADOQuery1CPF: TStringField;
    ADOQuery1SALARIO: TBCDField;
    ADOQuery1DATA_CADASTRO: TStringField;
    ADOQuery1DATA_ULT_MODIFICACAO: TStringField;
    ADOQuery1DATA_NASCIMENTO: TStringField;
    ADOQuery1ESTADO: TStringField;
    ADOQuery1ENDERECO: TStringField;
    ADOQuery1BAIRRO: TStringField;
    ADOQuery1CIDADE: TStringField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    EditNome: TEdit;
    Label1: TLabel;
    EditRG: TEdit;
    Label2: TLabel;
    EditCPF: TEdit;
    Label3: TLabel;
    EditSexo: TEdit;
    Label4: TLabel;
    EditSalario: TEdit;
    Label5: TLabel;
    Label7: TLabel;
    EditDNasc: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    DBLEstados: TDBLookupComboBox;
    DBLCidades: TDBLookupComboBox;
    Label10: TLabel;
    Label11: TLabel;
    EditCodigo: TEdit;
    EditDCadastro: TEdit;
    EditUModificacao: TEdit;
    EditIdade: TEdit;
    EditLogin: TEdit;
    EditAgendamento: TEdit;
    EditVendas: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    DateTimePicker1: TDateTimePicker;
    ADOQuery1CARGO: TStringField;
    EditCargo: TEdit;
    DataSourceES: TDataSource;
    ADOQueryCidades: TADOQuery;
    DataSourceCidades: TDataSource;
    ADOQueryVendas: TADOQuery;
    ADOQueryVendasQTDVENDAS: TIntegerField;
    ADOQueryAGENDAMENTOS: TADOQuery;
    ADOQueryAGENDAMENTOSQTDAGENDAMENTOS: TIntegerField;
    ADOQueryExclusao: TADOQuery;
    ComboBox1: TComboBox;
    ADOQueryUpdate: TADOQuery;
    EditEndereco: TEdit;
    EditBairro: TEdit;
    EditTelefone: TEdit;
    Label6: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    ADOQueryRegistroSelecionado: TADOQuery;
    ADOQueryRegistroSelecionadoCODIGO: TAutoIncField;
    ADOQueryRegistroSelecionadoNOME: TStringField;
    ADOQueryRegistroSelecionadoDATA_NASCIMENTO: TStringField;
    ADOQueryRegistroSelecionadoSEXO: TStringField;
    ADOQueryRegistroSelecionadoRG: TStringField;
    ADOQueryRegistroSelecionadoCPF: TStringField;
    ADOQueryRegistroSelecionadoTELEFONE: TStringField;
    ADOQueryRegistroSelecionadoCODCIDADE: TIntegerField;
    ADOQueryRegistroSelecionadoCODES: TIntegerField;
    ADOQueryRegistroSelecionadoENDERECO: TStringField;
    ADOQueryRegistroSelecionadoBAIRRO: TStringField;
    ADOQueryRegistroSelecionadoSALARIO: TBCDField;
    ADOQueryRegistroSelecionadoCARGO: TStringField;
    ADOQueryRegistroSelecionadoDATA_CADASTRO: TStringField;
    ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO: TStringField;
    ADOQueryRegistroSelecionadoLOGINUSU: TStringField;
    ADOQueryVeriAgendamento: TADOQuery;
    ButtonSelect: TSpeedButton;
    edvalortotal: TEdit;
    procedure ButtonCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure DBLEstadosClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure ButtonFecharClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonEditarClick(Sender: TObject);
    procedure EditCPFKeyPress(Sender: TObject; var Key: Char);
    procedure EditRGKeyPress(Sender: TObject; var Key: Char);
    procedure EditTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSelectClick(Sender: TObject);
    procedure edvalortotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
    idade : Integer;
    Data_Nasc, Data_atual  : TDateTime;
    AnoNasc, AnoAtual, MesNasc, MesAtual, DiaNasc, DiaAtual  : Word;
  end;

var
  Form_Consu_Func: TForm_Consu_Func;

implementation

{$R *.dfm}

uses U_Cadastro_Funcionarios, U_Login, U_Venda;

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

procedure TForm_Consu_Func.ButtonCancelarClick(Sender: TObject);
begin
  FormShow(Sender);
end;

procedure TForm_Consu_Func.ButtonEditarClick(Sender: TObject);
begin
  if EditCodigo.Text <> '' then
    begin
      EditNome.ReadOnly := False;
      EditRG.ReadOnly := False;
      EditCPF.ReadOnly := False;
      EditSexo.Visible := False;
      ComboBox1.Visible := True;
      EditCargo.ReadOnly := False;
      EditSalario.ReadOnly := False;
      DBLEstados.ReadOnly := False;
      DBLCidades.ReadOnly := False;
      EditTelefone.ReadOnly := False;
      EditBairro.ReadOnly := False;
      EditEndereco.ReadOnly := False;
      EditDNasc.Visible := False;
      DateTimePicker1.Visible := True;
      DBGrid1.Enabled := False;
      SearchBox1.Enabled := False;
      EditNome.SetFocus;
      ButtonExcluir.Enabled := False;
      ButtonSalvar.Enabled := True;
      ButtonCancelar.Enabled := True;
      ButtonEditar.Enabled := False;
      edvalortotal.Text := ADOQueryRegistroSelecionadoSALARIO.AsString;
      EditSalario.Visible := False;
      edvalortotal.Visible := True;
    end
  else
    begin
      Application.MessageBox('Selecione um registro!', 'Informação', MB_ICONINFORMATION + MB_OK);
    end;
end;

procedure TForm_Consu_Func.ButtonExcluirClick(Sender: TObject);
Var
  Dia : string;
begin
  Dia := DateToStr(Date);
  ADOQueryVeriAgendamento.Close;
  ADOQueryVeriAgendamento.Parameters.ParamByName('DIA').Value := Dia;
  ADOQueryVeriAgendamento.Parameters.ParamByName('FUNC').Value := EditCodigo.Text;
  ADOQueryVeriAgendamento.Open;

  if ADOQueryVeriAgendamento.RecordCount > 0 then
    begin
      Application.MessageBox('Não é possível excluir esse funcionário, pois ele possui um agendamento marcado', 'Erro', MB_OK + MB_ICONERROR);
      Exit;
    end;

  if EditCodigo.Text <> '' then
    begin
      if ButtonEditar.Enabled = True then
        begin
          if Application.MessageBox('Deseja excluir e descartar as alterações?', 'Excluir',
                              MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
            begin
              ADOQueryExclusao.Close;
              ADOQueryExclusao.Parameters.ParamByName('CODIGO').Value := EditCodigo.Text;
              ADOQueryExclusao.Parameters.ParamByName('FUNCIONARIO').Value := EditCodigo.Text;
              ADOQueryExclusao.ExecSQL;
              Application.MessageBox('Registro excluído com sucesso', 'Exclusão', MB_OK + MB_ICONINFORMATION);
              ADOQuery1.Close;
              ADOQuery1.Open;
              SearchBox1.Text := '';
              SearchBox1.SetFocus;
              FormShow(Sender);
            end;
        end
      else
        begin
          if Application.MessageBox('Deseja excluir o registro?', 'Excluir',
                                   MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
            begin
              ADOQueryExclusao.Close;
              ADOQueryExclusao.Parameters.ParamByName('CODIGO').Value := EditCodigo.Text;
              ADOQueryExclusao.ExecSQL;
              Application.MessageBox('Registro excluído com sucesso', 'Exclusão', MB_OK + MB_ICONINFORMATION);
              ADOQuery1.Close;
              ADOQuery1.Open;
              SearchBox1.Text := '';
              SearchBox1.SetFocus;
            end;
        end;
    end
  else
    begin
      Application.MessageBox('Selecione um registro!', 'Alerta', MB_ICONWARNING + MB_OK);
    end;
end;

procedure TForm_Consu_Func.ButtonFecharClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja sair e descartar as alterações?', 'Sair',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Func.Close;
        end;
    end
  else Form_Consu_Func.Close;

end;

procedure TForm_Consu_Func.ButtonNovoClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja coninuar?', 'Alterações não foram salvas',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Func.Hide;
          Form_Cadastro_Funcionario.ShowModal;
          ButtonSalvar.Enabled := False;
          ButtonCancelar.Enabled := False;
          Form_Consu_Func.Show;
          SearchBox1.SetFocus;
        end;
    end
  else
    begin
      Form_Consu_Func.Hide;
      Form_Cadastro_Funcionario.ShowModal;
      ButtonSalvar.Enabled := False;
      ButtonCancelar.Enabled := False;
      Form_Consu_Func.Show;
      SearchBox1.SetFocus;
    end;
end;

procedure TForm_Consu_Func.ButtonSalvarClick(Sender: TObject);
var
  sexo : string;
begin
  Data_Atual := Date;
  Data_Nasc := DateTimePicker1.DateTime;
  decodedate(Data_Nasc,AnoNasc,MesNasc,DiaNasc);
  decodedate(Data_Atual,AnoAtual,MesAtual,DiaAtual);
  idade := AnoAtual - AnoNasc;
  if MesNasc > MesAtual then
    begin
      idade := idade - 1;
    end
  else if MesNasc = MesAtual then
    begin
      if DiaNasc > DiaAtual then
        begin
          idade := idade - 1;
        end;
    end;

  if ComboBox1.ItemIndex = 0 then
    begin
      sexo := 'F';
    end
  else if ComboBox1.ItemIndex = 1 then
    begin
      sexo := 'M';
    end
  else
    begin
      sexo := '-';
    end;

  EditSalario.Text := edvalortotal.Text;
  DeleteChar('.', EditSexo.Text);
  //ShowMessage(inttostr(idade));
  if (EditNome.Text <> '')      and (EditRG.Text <> '')       and
     (EditCPF.Text <> '')       and (EditSalario.Text <> '')  and (EditBairro.Text <> '') and
     (EditCargo.Text <> '')     and (EditEndereco.Text <> '') and
     (DBLEstados.Text <> '')    and (DBLCidades.Text <> '')   then
    begin
      if idade >= 16 then
        begin
          ADOQueryUpdate.Close;
          ADOQueryUpdate.Parameters.ParamByName('NOME').Value := EditNome.Text;
          ADOQueryUpdate.Parameters.ParamByName('TELEFONE').Value := EditTelefone.Text;
          ADOQueryUpdate.Parameters.ParamByName('D_NASC').Value := DatetoStr(DateTimePicker1.DateTime);
          ADOQueryUpdate.Parameters.ParamByName('SEXO').Value := sexo;
          ADOQueryUpdate.Parameters.ParamByName('RG').Value := EditRG.Text;
          ADOQueryUpdate.Parameters.ParamByName('CPF').Value := EditCPF.Text;;
          ADOQueryUpdate.Parameters.ParamByName('CIDADE').Value := DBLCidades.KeyValue;
          ADOQueryUpdate.Parameters.ParamByName('ESTADO').Value := DBLEstados.KeyValue;
          ADOQueryUpdate.Parameters.ParamByName('ENDERECO').Value := EditEndereco.Text;
          ADOQueryUpdate.Parameters.ParamByName('BAIRRO').Value := EditBairro.Text;
          ADOQueryUpdate.Parameters.ParamByName('SALARIO').Value := EditSalario.Text;
          ADOQueryUpdate.Parameters.ParamByName('CARGO').Value := EditCargo.Text;;
          ADOQueryUpdate.Parameters.ParamByName('CODIGO').Value := EditCodigo.Text;
          ADOQueryUpdate.ExecSQL;
          ADOQuery1.Close;
          ADOQuery1.Open;
          Application.MessageBox('Alteração concluída com sucesso!', 'Alteração', MB_OK + MB_ICONINFORMATION);
          ButtonSalvar.Enabled := False;
          ButtonCancelar.Enabled := False;
          ButtonEditar.Enabled := True;
          ButtonExcluir.Enabled := True;
          FormShow(Sender);
        end
      else
        begin
          Application.MessageBox('Necessário ter pelo menos 16 anos!', 'Verifique a data de nascimento', MB_ICONWARNING + MB_OK);
        end;
    end
  else
    begin
      Application.MessageBox('Preencha todos os campos!', 'Alerta', MB_ICONWARNING + MB_OK );
    end;
end;

procedure TForm_Consu_Func.ButtonSelectClick(Sender: TObject);
begin
  Form_Venda.DBLFuncionario.KeyValue := DBGrid1.Columns[0].Field.AsInteger;
  Form_Consu_Func.Close;
end;

procedure TForm_Consu_Func.DBGrid1CellClick(Column: TColumn);
var
  CodLinha : Integer;
begin
  CodLinha := DBGrid1.Columns[0].Field.AsInteger; // vai mostrar a coluna que voce quer
  ADOQueryRegistroSelecionado.Close;
  ADOQueryRegistroSelecionado.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryRegistroSelecionado.Open;

  EditCodigo.Text := ADOQueryRegistroSelecionadoCODIGO.AsString;
  EditNome.Text := ADOQueryRegistroSelecionadoNOME.AsString;
  EditRG.Text := ADOQueryRegistroSelecionadoRG.AsString;
  EditCPF.Text := ADOQuery1CPF.AsString;
  EditSexo.Text := ADOQueryRegistroSelecionadoSEXO.AsString;
  if EditSexo.Text = 'F' then
    begin
      ComboBox1.ItemIndex := 0;
    end
  else
    begin
      ComboBox1.ItemIndex := 1;
    end;
  EditDNasc.Text := ADOQueryRegistroSelecionadoDATA_NASCIMENTO.AsString;
  DateTimePicker1.Date := ADOQueryRegistroSelecionadoDATA_NASCIMENTO.AsDateTime;
  EditDCadastro.Text := ADOQueryRegistroSelecionadoDATA_CADASTRO.AsString;
  EditUModificacao.Text := ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO.AsString;
  EditCargo.Text := ADOQueryRegistroSelecionadoCARGO.AsString;
  EditSalario.Text := 'R$ ' + ADOQueryRegistroSelecionadoSALARIO.AsString;
  EditLogin.Text := ADOQueryRegistroSelecionadoLOGINUSU.AsString;
  EditTelefone.Text := ADOQueryRegistroSelecionadoTELEFONE.AsString;
  EditEndereco.Text := ADOQueryRegistroSelecionadoENDERECO.AsString;
  EditBairro.Text := ADOQueryRegistroSelecionadoBAIRRO.AsString;
  DBLEstados.KeyValue := ADOQueryRegistroSelecionadoCODES.AsInteger;

  ADOQueryCidades.Close;
  ADOQueryCidades.Parameters.ParamByName('ESTADO').Value := DBLEstados.KeyValue;
  ADOQueryCidades.Open;
  DBLCidades.KeyValue := ADOQueryRegistroSelecionadoCODCIDADE.AsInteger;

  Data_Atual := Date;
  Data_Nasc := ADOQueryRegistroSelecionadoDATA_NASCIMENTO.AsDateTime;
  decodedate(Data_Nasc,AnoNasc,MesNasc,DiaNasc);
  decodedate(Data_Atual,AnoAtual,MesAtual,DiaAtual);
  idade := AnoAtual - AnoNasc;
  if MesNasc > MesAtual then
    begin
      idade := idade - 1;
    end
  else if MesNasc = MesAtual then
    begin
      if DiaNasc > DiaAtual then
        begin
          idade := idade - 1;
        end;
    end;

  EditIdade.Text := IntToStr(idade);

  ADOQueryVendas.Close;
  ADOQueryVendas.Parameters.ParamByName('FUNCIONARIO').Value := StrToInt(EditCodigo.Text);
  ADOQueryVendas.Open;
  EditVendas.Text := ADOQueryVendasQTDVENDAS.AsString;

  ADOQueryAGENDAMENTOS.Close;
  ADOQueryAGENDAMENTOS.Parameters.ParamByName('FUNCIONARIO').Value := StrToInt(EditCodigo.Text);
  ADOQueryAGENDAMENTOS.Open;
  EditAgendamento.Text := ADOQueryAGENDAMENTOSQTDAGENDAMENTOS.AsString;
end;

procedure TForm_Consu_Func.DBGrid1DblClick(Sender: TObject);
begin
  ButtonSelectClick(Sender);
end;

procedure TForm_Consu_Func.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TForm_Consu_Func.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  CodLinha : Integer;
begin
  CodLinha := DBGrid1.Columns[0].Field.AsInteger; // vai mostrar a coluna que voce quer
  ADOQueryRegistroSelecionado.Close;
  ADOQueryRegistroSelecionado.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryRegistroSelecionado.Open;
  EditCodigo.Text := ADOQueryRegistroSelecionadoCODIGO.AsString;
  EditNome.Text := ADOQueryRegistroSelecionadoNOME.AsString;
  EditRG.Text := ADOQueryRegistroSelecionadoRG.AsString;
  EditCPF.Text := ADOQuery1CPF.AsString;
  EditSexo.Text := ADOQueryRegistroSelecionadoSEXO.AsString;
  EditSexo.Text := ADOQueryRegistroSelecionadoSEXO.AsString;
  if EditSexo.Text = 'F' then
    begin
      ComboBox1.ItemIndex := 0;
    end
  else
    begin
      ComboBox1.ItemIndex := 1;
    end;
  EditDNasc.Text := ADOQueryRegistroSelecionadoDATA_NASCIMENTO.AsString;
  DateTimePicker1.DateTime := ADOQueryRegistroSelecionadoDATA_NASCIMENTO.AsDateTime;
  EditDCadastro.Text := ADOQueryRegistroSelecionadoDATA_CADASTRO.AsString;
  EditUModificacao.Text := ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO.AsString;
  EditCargo.Text := ADOQueryRegistroSelecionadoCARGO.AsString;
  EditSalario.Text := 'R$ ' + ADOQueryRegistroSelecionadoSALARIO.AsString;
  EditLogin.Text := ADOQueryRegistroSelecionadoLOGINUSU.AsString;
  EditTelefone.Text := ADOQueryRegistroSelecionadoTELEFONE.AsString;
  EditEndereco.Text := ADOQueryRegistroSelecionadoENDERECO.AsString;
  EditBairro.Text := ADOQueryRegistroSelecionadoBAIRRO.AsString;
  DBLEstados.KeyValue := ADOQueryRegistroSelecionadoCODES.AsInteger;

  ADOQueryCidades.Close;
  ADOQueryCidades.Parameters.ParamByName('ESTADO').Value := DBLEstados.KeyValue;
  ADOQueryCidades.Open;
  DBLCidades.KeyValue := ADOQueryRegistroSelecionadoCODCIDADE.AsInteger;

  Data_Atual := Date;
  Data_Nasc := ADOQueryRegistroSelecionadoDATA_NASCIMENTO.AsDateTime;
  decodedate(Data_Nasc,AnoNasc,MesNasc,DiaNasc);
  decodedate(Data_Atual,AnoAtual,MesAtual,DiaAtual);
  idade := AnoAtual - AnoNasc;
  if MesNasc > MesAtual then
    begin
      idade := idade - 1;
    end
  else if MesNasc = MesAtual then
    begin
      if DiaNasc > DiaAtual then
        begin
          idade := idade - 1;
        end;
    end;

  EditIdade.Text := IntToStr(idade);

  ADOQueryVendas.Close;
  ADOQueryVendas.Parameters.ParamByName('FUNCIONARIO').Value := StrToInt(EditCodigo.Text);
  ADOQueryVendas.Open;
  EditVendas.Text := ADOQueryVendasQTDVENDAS.AsString;

  ADOQueryAGENDAMENTOS.Close;
  ADOQueryAGENDAMENTOS.Parameters.ParamByName('FUNCIONARIO').Value := StrToInt(EditCodigo.Text);
  ADOQueryAGENDAMENTOS.Open;
  EditAgendamento.Text := ADOQueryAGENDAMENTOSQTDAGENDAMENTOS.AsString;
end;

procedure TForm_Consu_Func.DBGrid1TitleClick(Column: TColumn);
begin
  LabelPesquisar.Caption := Column.Title.Caption + ': ';
  CampoFiltro := Column.FieldName;
  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  ADOQuery1.Filtered := False;
end;

procedure TForm_Consu_Func.DBLEstadosClick(Sender: TObject);
begin
  ADOQueryCidades.Close;
  ADOQueryCidades.Parameters.ParamByName('ESTADO').Value := DBLEstados.KeyValue;
  ADOQueryCidades.Open;
end;

procedure TForm_Consu_Func.EditCPFKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #8 then
      exit;

   if Length(EditCPF.Text) = 3 then
      begin
         EditCPF.Text := EditCPF.Text + '.';
         EditCPF.Selstart := Length(EditCPF.text);
      end;

   if Length(EditCPF.Text) = 7 then
      begin
         EditCPF.Text := EditCPF.Text + '.';
         EditCPF.Selstart := Length(EditCPF.text);
      end;

   if Length(EditCPF.Text) = 11 then
      begin
         EditCPF.Text := EditCPF.Text + '-';
         EditCPF.Selstart := Length(EditCPF.text);
      end;
end;

procedure TForm_Consu_Func.EditRGKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #8 then
      exit;

   if Length(EditRG.Text) = 2 then
      begin
         EditRG.Text := EditRG.Text + '.';
         EditRG.Selstart := Length(EditRG.text);
      end;

   if Length(EditRG.Text) = 6 then
      begin
         EditRG.Text := EditRG.Text + '.';
         EditRG.Selstart := Length(EditRG.text);
      end;

   if Length(EditRG.Text) = 10 then
      begin
         EditRG.Text := EditRG.Text + '-';
         EditRG.Selstart := Length(EditRG.text);
      end;
end;

procedure TForm_Consu_Func.EditTelefoneKeyPress(Sender: TObject; var Key: Char);
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

   if Length(EditTelefone.Text) = 10 then
      begin
         EditTelefone.Text := EditTelefone.Text + '-';
         EditTelefone.Selstart := Length(EditTelefone.text);
      end;
end;

procedure TForm_Consu_Func.edvalortotalKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TForm_Consu_Func.FormShow(Sender: TObject);
begin

  // Configuração grid e pesquisa
  Form_Cadastro_Funcionario.ADOQueryES.Close;
  Form_Cadastro_Funcionario.ADOQueryES.Open;
  ADOQuery1.Close;
  ADOQuery1.Open;
  ADOQuery1.Filtered := False;
  DBGrid1.Enabled := True;
  SearchBox1.Enabled := True;
  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  LabelPesquisar.Caption := DBGrid1.Columns[1].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[1].FieldName;

  Self.Width := 900;
  Self.Height := 620;

  //
  ButtonSalvar.Enabled := False;
  ButtonCancelar.Enabled := False;
  ButtonEditar.Enabled := True;
  ButtonExcluir.Enabled := True;
  ButtonNovo.Enabled := True;

  ButtonCancelar.Visible := True;
  ButtonSalvar.Visible := True;
  ButtonEditar.Visible := True;
  ButtonExcluir.Visible := True;
  ButtonNovo.Visible := True;
  ButtonSelect.Visible := False;
  GroupBox1.Visible := True;

  EditCodigo.Text := '';
  EditNome.Text := '';
  EditUModificacao.Text := '';
  EditDCadastro.Text := '';
  EditLogin.Text := '';
  EditIdade.Text := '';
  EditAgendamento.Text := '';
  EditVendas.Text := '';
  EditRG.Text := '';
  EditCPF.Text := '';
  EditSexo.Text := '';
  EditDNasc.Text := '';
  edvalortotal.Visible := False;
  EditSalario.Visible := True;
  EditSalario.Text := '';
  EditCargo.Text := '';
  EditEndereco.Text := '';
  EditBairro.Text := '';
  EditTelefone.Text := '';
  DBLEstados.KeyValue := 0;
  DBLCidades.KeyValue := 0;
  PageControl1.ActivePageIndex := 0;
  ComboBox1.Visible := False;
  EditSexo.Visible := True;
  EditNome.ReadOnly := True;
  EditRG.ReadOnly := True;
  EditCPF.ReadOnly := True;
  ComboBox1.Visible := False;
  EditCargo.ReadOnly := True;
  EditSalario.ReadOnly := True;
  DBLEstados.ReadOnly := True;
  DBLCidades.ReadOnly := True;
  EditTelefone.ReadOnly := True;
  EditBairro.ReadOnly := True;
  EditEndereco.ReadOnly := True;
  EditDNasc.Visible := True;
  DateTimePicker1.Visible := False;

  if Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
    end;

  if Form_Venda.SelecionarFunc = True then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
      GroupBox1.Visible := False;
      Self.Height := 600;
      ButtonSelect.Visible := True;
    end;
end;

procedure TForm_Consu_Func.SearchBox1Change(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQuery1.Filtered := False;
      ADOQueryRegistroSelecionado.Close;
    end
  else
    begin
      SearchBox1InvokeSearch(Sender);
    end;
end;

procedure TForm_Consu_Func.SearchBox1InvokeSearch(Sender: TObject);
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
