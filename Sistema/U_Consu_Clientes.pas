unit U_Consu_Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.ComCtrls, DateTimePicker.Interposer;

type
  TForm_Consu_Clientes = class(TForm)
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
    ADOQuery1CODIGO: TAutoIncField;
    ADOQuery1NOME: TStringField;
    ADOQuery1TELEFONE: TStringField;
    ADOQuery1SEXO: TStringField;
    ADOQuery1RG: TStringField;
    ADOQuery1CPF: TStringField;
    ADOQuery1CODCIDADE: TIntegerField;
    ADOQuery1NOMECIDADE: TStringField;
    ADOQuery1CODES: TIntegerField;
    ADOQuery1NOMEESTADO: TStringField;
    ADOQuery1ENDERECO: TStringField;
    ADOQuery1BAIRRO: TStringField;
    ADOQuery1DISPONIVEL: TBooleanField;
    DataSource1: TDataSource;
    ADOQuery1DNASC: TStringField;
    ADOQuery1DATA_CADASTRO: TStringField;
    ADOQuery1ULT_MODIFICACAO: TStringField;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEditCodigo: TDBEdit;
    Label2: TLabel;
    DBEditNome: TDBEdit;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    DBEditDNasc: TDBEdit;
    Label5: TLabel;
    DBEditTelefone: TDBEdit;
    Label6: TLabel;
    DBEditRG: TDBEdit;
    Label7: TLabel;
    DBEditCPF: TDBEdit;
    DBLEstado: TDBLookupComboBox;
    Label8: TLabel;
    DBLCidade: TDBLookupComboBox;
    Label9: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label10: TLabel;
    DBEditDCadastro: TDBEdit;
    Label11: TLabel;
    DBEditUModificacao: TDBEdit;
    Label12: TLabel;
    EditQTD: TEdit;
    EditSexo: TEdit;
    ADOQueryExclusao: TADOQuery;
    ADOQueryCidades: TADOQuery;
    ADOQueryEstados: TADOQuery;
    DataSourceCidades: TDataSource;
    DataSourceEstados: TDataSource;
    ADOQueryEstadosCODIGO: TIntegerField;
    ADOQueryEstadosSIGLA: TStringField;
    ADOQueryEstadosESTADO: TStringField;
    ADOQueryVerificaCidade: TADOQuery;
    ADOQueryCPF: TADOQuery;
    ADOQueryUpdate: TADOQuery;
    ADOQueryQtdCompras: TADOQuery;
    ADOQueryVeriAgendamento: TADOQuery;
    ButtonSelecionar: TSpeedButton;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ButtonFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure ButtonEditarClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBEditCPFKeyPress(Sender: TObject; var Key: Char);
    procedure DBEditRGKeyPress(Sender: TObject; var Key: Char);
    procedure DBEditTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure DBLEstadoClick(Sender: TObject);
    procedure DBLCidadeClick(Sender: TObject);
    procedure ButtonSelecionarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
    Estado : Integer;
    Cidade : Integer;
  end;

var
  Form_Consu_Clientes: TForm_Consu_Clientes;

implementation

{$R *.dfm}

uses U_Cadastro_Clientes, U_Login, U_Venda;

procedure TForm_Consu_Clientes.ButtonCancelarClick(Sender: TObject);
begin
  FormShow(Sender);
end;

procedure TForm_Consu_Clientes.ButtonEditarClick(Sender: TObject);
begin
  if DBEditCodigo.Text <> '' then
    begin
      if DBEditNome.Text <> ' Cliente padrão' then
        begin
          ButtonSalvar.Enabled := True;;
          ButtonCancelar.Enabled := True;
          ButtonEditar.Enabled := False;
          ButtonExcluir.Enabled := False;
          ButtonNovo.Enabled := True;

          DBEditNome.ReadOnly := False;
          DBEditRG.ReadOnly := False;
          DBEditCPF.ReadOnly := False;
          DBLEstado.ReadOnly := False;
          DBLCidade.ReadOnly := False;
          EditSexo.Visible := False;
          ComboBox1.Visible := True;
          if EditSexo.Text = 'F' then
            begin
              ComboBox1.ItemIndex := 0;
            end
          else ComboBox1.ItemIndex := 1;
          DateTimePicker1.Visible := True;
          DBEditDNasc.Visible := False;
          DBGrid1.Enabled := False;
          SearchBox1.Enabled := False;
          Estado := DBLEstado.KeyValue;
          Cidade := DBLCidade.KeyValue;
        end
      else Application.MessageBox('Esse cliente não pode ser alterado!', 'Informação', MB_OK + MB_ICONINFORMATION);
    end
  else Application.MessageBox('Selecione um registro para editar!', 'Alerta', MB_OK + MB_ICONWARNING);
end;

procedure TForm_Consu_Clientes.ButtonExcluirClick(Sender: TObject);
var
  Dia : string;
begin
  Dia := DateToStr(Date);
  ADOQueryVeriAgendamento.Close;
  ADOQueryVeriAgendamento.Parameters.ParamByName('DIA').Value := Dia;
  ADOQueryVeriAgendamento.Parameters.ParamByName('CLI').Value := DBEditCodigo.Text;
  ADOQueryVeriAgendamento.Open;

  if ADOQueryVeriAgendamento.RecordCount > 0 then
    begin
      Application.MessageBox('Não é possível excluir esse cliente, pois ele possui um agendamento marcado', 'Erro', MB_OK + MB_ICONERROR);
      Exit;
    end;

  if DBEditNome.Text <> ' Cliente padrão' then
    begin
      if ButtonEditar.Enabled = True then
        begin
          if Application.MessageBox('Deseja excluir e descartar as alterações?', 'Excluir',
                              MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
            begin
              ADOQueryExclusao.Close;
              ADOQueryExclusao.Parameters.ParamByName('CPF').Value := DBEditCPF.Text;
              ADOQueryExclusao.ExecSQL;
              Application.MessageBox('Registro excluído com sucesso', 'Exclusão', MB_OK + MB_ICONINFORMATION);
              FormShow(Sender);
            end;
        end
      else
        begin
          if Application.MessageBox('Deseja excluir o registro?', 'Excluir',
                                   MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
            begin
              ADOQueryExclusao.Close;
              ADOQueryExclusao.Parameters.ParamByName('CPF').Value := DBEditCPF.Text;
              ADOQueryExclusao.ExecSQL;
              Application.MessageBox('Registro excluído com sucesso', 'Exclusão', MB_OK + MB_ICONINFORMATION);
            end;
        end;
    end
  else
    begin
      Application.MessageBox('Cliente padrão não pode ser excluido!', 'Informação', MB_ICONINFORMATION + MB_OK);
    end;
end;

procedure TForm_Consu_Clientes.ButtonFecharClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja sair e descartar as alterações?', 'Sair',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Clientes.Close;
        end;
    end
  else
    Form_Consu_Clientes.Close;
end;

procedure TForm_Consu_Clientes.ButtonNovoClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja coninuar?', 'Alterações não foram salvas',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Clientes.Hide;
          Form_Cadastro_Clientes.ShowModal;
          Form_Consu_Clientes.Show;
        end;
    end
  else
    begin
      Form_Consu_Clientes.Hide;
      Form_Cadastro_Clientes.ShowModal;
      Form_Consu_Clientes.Show;
    end;
end;

procedure TForm_Consu_Clientes.ButtonSalvarClick(Sender: TObject);
var
  AnoNasc, AnoAtual, MesNasc, MesAtual, DiaNasc, DiaAtual  : Word;
  Diferenca : Integer;
  Sexo : string;
begin
  DataSource1.Edit;
  Trim(DBEditNome.Text);
  if ComboBox1.ItemIndex = 1 then
    begin
      sexo := 'F';
    end
  else sexo := 'M';
  if (DBEditNome.Text <> '')   and (DBEditTelefone.Text <> '') and
     (DBEditRG.Text <> '')     and (Length(DBEditCPF.Text) = 14) and
     (DBLEstado.KeyValue <> 0) and (DBLCidade.KeyValue <> 0)then
    begin
      decodedate(DateTimePicker1.Date,AnoNasc,MesNasc,DiaNasc);
      decodedate(Date,AnoAtual,MesAtual,DiaAtual);
      Diferenca := AnoAtual - AnoNasc;
      if (Diferenca >=  18) then
        begin
          ADOQueryCPF.Close;
          ADOQueryCPF.Parameters.ParamByName('CPF').Value := DBEditCPF.Text;
          ADOQueryCPF.Parameters.ParamByName('CODIGO').Value := DBEditCodigo.Text;
          ADOQueryCPF.Open;
          if ADOQueryCPF.RecordCount = 0 then
            begin
              ADOQueryVerificaCidade.Close;
              ADOQueryVerificaCidade.Parameters.ParamByName('ESTADO').Value := Estado;
              ADOQueryVerificaCidade.Parameters.ParamByName('CIDADE').Value := Cidade;
              ADOQueryVerificaCidade.Open;
              if ADOQueryVerificaCidade.RecordCount = 1 then
                begin
                  ADOQuery1.Post;
                  ADOQueryUpdate.Close;
                  ADOQueryUpdate.Parameters.ParamByName('SEXO').Value := Sexo;
                  ADOQueryUpdate.Parameters.ParamByName('DNASC').Value := DateToStr(DateTimePicker1.Date);
                  ADOQueryUpdate.Parameters.ParamByName('ESTADO').Value := Estado;
                  ADOQueryUpdate.Parameters.ParamByName('CIDADE').Value := Cidade;
                  ADOQueryUpdate.Parameters.ParamByName('CODIGO').Value := DBEditCodigo.Text;
                  ADOQueryUpdate.ExecSQL;
                  Application.MessageBox('Atualização concluída com sucesso!','Atualização de registro', MB_OK);
                  FormShow(Sender);
                end
              else Application.MessageBox('Verifique a cidade!','Informação', MB_OK + MB_ICONINFORMATION);
            end
          else Application.MessageBox('CPF indisponível!','Informação', MB_OK + MB_ICONINFORMATION);
        end
      else Application.MessageBox('Necessário ter pelo menos 18 anos!', 'Informação', MB_OK + MB_ICONINFORMATION);
    end
  else Application.MessageBox('Preencha corretamente todos os campos!','Informação', MB_OK + MB_ICONINFORMATION);

end;

procedure TForm_Consu_Clientes.ButtonSelecionarClick(Sender: TObject);
begin
  Form_Venda.DBLCLiente.KeyValue := ADOQuery1CODIGO.AsInteger;
  Form_Consu_Clientes.Close;
end;

procedure TForm_Consu_Clientes.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  if DBEditCodigo.Text <> '' then
    begin
      ADOQueryEstados.Open;
      DBLEstado.KeyValue := ADOQuery1CODES.AsInteger;
      ADOQueryCidades.Close;
      ADOQueryCidades.Parameters.ParamByName('CDES').Value := DBLEstado.KeyValue;
      ADOQueryCidades.Open;
      DBLCidade.KeyValue := ADOQuery1CODCIDADE.AsInteger;
      DateTimePicker1.Date := StrToDate(DBEditDNasc.Text);
    end
  else
   begin
     DBLEstado.KeyValue := 0;
     DBLCidade.KeyValue := 0;
   end;

  ADOQueryQtdCompras.Close;
  ADOQueryQtdCompras.Parameters.ParamByName('CLIENTE').Value := ADOQuery1CODIGO.AsInteger;
  ADOQueryQtdCompras.Open;

  EditQTD.Text := IntToStr(ADOQueryQtdCompras.RecordCount);
  EditSexo.Text := ADOQuery1SEXO.AsString;
  if EditSexo.Text = 'F' then
    begin
      EditSexo.Text := 'Feminino';
    end
  else if EditSexo.Text = 'M' then
      EditSexo.Text := 'Masculino';
end;

procedure TForm_Consu_Clientes.DBEditCPFKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #8 then
      exit;

   if Length(DBEditCPF.Text) = 3 then
      begin
         DBEditCPF.Text := DBEditCPF.Text + '.';
         DBEditCPF.Selstart := Length(DBEditCPF.text);
      end;

   if Length(DBEditCPF.Text) = 7 then
      begin
         DBEditCPF.Text := DBEditCPF.Text + '.';
         DBEditCPF.Selstart := Length(DBEditCPF.text);
      end;

   if Length(DBEditCPF.Text) = 11 then
      begin
         DBEditCPF.Text := DBEditCPF.Text + '-';
         DBEditCPF.Selstart := Length(DBEditCPF.text);
      end;
end;

procedure TForm_Consu_Clientes.DBEditRGKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #8 then
      exit;

   if Length(DBEditRG.Text) = 2 then
      begin
         DBEditRG.Text := DBEditRG.Text + '.';
         DBEditRG.Selstart := Length(DBEditRG.text);
      end;

   if Length(DBEditRG.Text) = 6 then
      begin
         DBEditRG.Text := DBEditRG.Text + '.';
         DBEditRG.Selstart := Length(DBEditRG.text);
      end;

   if Length(DBEditRG.Text) = 10 then
      begin
         DBEditRG.Text := DBEditRG.Text + '-';
         DBEditRG.Selstart := Length(DBEditRG.text);
      end;
end;

procedure TForm_Consu_Clientes.DBEditTelefoneKeyPress(Sender: TObject;
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

   if Length(DBEditTelefone.Text) = 10 then
      begin
         DBEditTelefone.Text := DBEditTelefone.Text + '-';
         DBEditTelefone.Selstart := Length(DBEditTelefone.text);
      end;
end;

procedure TForm_Consu_Clientes.DBGrid1DblClick(Sender: TObject);
begin
  ButtonSelecionarClick(Sender);
end;

procedure TForm_Consu_Clientes.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TForm_Consu_Clientes.DBGrid1TitleClick(Column: TColumn);
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

procedure TForm_Consu_Clientes.DBLCidadeClick(Sender: TObject);
begin
  Cidade := DBLCidade.KeyValue;
end;

procedure TForm_Consu_Clientes.DBLEstadoClick(Sender: TObject);
begin
  Estado := DBLEstado.KeyValue;
  ADOQueryCidades.Close;
  ADOQueryCidades.Parameters.ParamByName('CDES').Value := Estado;
  ADOQueryCidades.Open;
end;

procedure TForm_Consu_Clientes.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.Open;
  ADOQueryEstados.Close;
  ADOQueryEstados.Open;
  ADOQuery1.Filtered := False;
  DBGrid1.Enabled := True;
  SearchBox1.Enabled := True;
  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  LabelPesquisar.Caption := DBGrid1.Columns[1].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[1].FieldName;

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
  ButtonSelecionar.Visible := False;
  GroupBox1.Visible := True;

  ScrollBox1.VertScrollBar.Position := 0;

  DBEditCodigo.ReadOnly := True;
  DBEditNome.ReadOnly := True;
  DBEditUModificacao.ReadOnly := True;
  DBEditDCadastro.ReadOnly := True;
  EditQTD.ReadOnly := True;
  DBEditRG.ReadOnly := True;
  DBEditCPF.ReadOnly := True;
  EditSexo.ReadOnly := True;
  DBEditDNasc.ReadOnly := True;
  DBLEstado.ReadOnly := True;
  DBLCidade.ReadOnly := True;
  ComboBox1.Visible := False;
  EditSexo.Visible := True;
  DateTimePicker1.Visible := False;
  DBEditDNasc.Visible := True;

  {if Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
    end;}

  if Form_Venda.SelecionarCli = True then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
      ButtonSelecionar.Visible := True;
      GroupBox1.Visible := False;
    end;
end;

procedure TForm_Consu_Clientes.SearchBox1Change(Sender: TObject);
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

procedure TForm_Consu_Clientes.SearchBox1InvokeSearch(Sender: TObject);
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

end.
