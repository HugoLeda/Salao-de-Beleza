unit U_Consu_Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls;

type
  TForm_Consu_Usuarios = class(TForm)
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
    ADOQueryRegistroSelecionado: TADOQuery;
    ADOQuery1NOME: TStringField;
    ADOQuery1CARGO: TStringField;
    ADOQuery1SUPERUSU: TBooleanField;
    ADOQuery1LOGINUSU: TStringField;
    DataSource1: TDataSource;
    ADOQueryRegistroSelecionadoNOME: TStringField;
    ADOQueryRegistroSelecionadoCARGO: TStringField;
    ADOQueryRegistroSelecionadoDATA_CADASTRO: TWideStringField;
    ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO: TWideStringField;
    ADOQueryRegistroSelecionadoSUPERUSU: TBooleanField;
    ADOQueryRegistroSelecionadoLOGINUSU: TStringField;
    EditNome: TEdit;
    EditCargo: TEdit;
    EditDCadastro: TEdit;
    EditUModificacao: TEdit;
    EditLogin: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    ADOQuery1CODIGO: TAutoIncField;
    ADOQueryUpdate: TADOQuery;
    ADOQueryExclusao: TADOQuery;
    ADOQuery1DATA_CADASTRO: TStringField;
    ADOQuery1ULT_MODIFICACAO: TStringField;
    ADOQueryRegistroSelecionadoDATA_CADASTRO2: TStringField;
    ADOQueryRegistroSelecionadoULT_MODIFI: TStringField;
    procedure ButtonFecharClick(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonEditarClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
    CodLinha : Integer;
  end;

var
  Form_Consu_Usuarios: TForm_Consu_Usuarios;

implementation

{$R *.dfm}

uses U_Cadastro_Usuario, U_Login;

procedure TForm_Consu_Usuarios.ButtonCancelarClick(Sender: TObject);
begin
  FormShow(Sender);
end;

procedure TForm_Consu_Usuarios.ButtonEditarClick(Sender: TObject);
begin
  if EditNome.Text <> '' then
    begin
      EditNome.ShowHint := True;
      EditCargo.ShowHint := True;
      EditDCadastro.ShowHint := True;
      EditUModificacao.ShowHint := True;
      EditLogin.ShowHint := True;
      CheckBox1.Enabled := True;
      ButtonEditar.Enabled := False;
      ButtonSalvar.Enabled := True;
      ButtonCancelar.Enabled := True;
      ButtonExcluir.Enabled := False;
      SearchBox1.Enabled := False;
      DBGrid1.Enabled := False;
    end
  else Application.MessageBox('Selecione um registro para editar!','', MB_OK + MB_ICONINFORMATION);
end;

procedure TForm_Consu_Usuarios.ButtonExcluirClick(Sender: TObject);
begin
  if EditNome.Text <> '' then
    begin
      if Application.MessageBox('Deseja excluir o registro?', 'Excluir',
                              MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          ADOQueryExclusao.Close;
          ADOQueryExclusao.Parameters.ParamByName('CODIGO').Value := CodLinha;
          ADOQueryExclusao.ExecSQL;
          Application.MessageBox('Usuário excluído com sucesso!','Exclusão', MB_OK + MB_ICONINFORMATION);
        end;
    end
  else Application.MessageBox('Selecione um registro para editar!','Alerta', MB_OK + MB_ICONINFORMATION + MB_ICONWARNING);
end;

procedure TForm_Consu_Usuarios.ButtonFecharClick(Sender: TObject);
begin
  Form_Consu_Usuarios.Close;
end;

procedure TForm_Consu_Usuarios.ButtonNovoClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja coninuar?', 'Alterações não foram salvas',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Usuarios.Hide;
          Form_Cadastro_Usu.ShowModal;
          Form_Consu_Usuarios.Show;
        end;
    end
  else
    begin
      Form_Consu_Usuarios.Hide;
      Form_Cadastro_Usu.ShowModal;
      Form_Consu_Usuarios.Show;
    end;
end;

procedure TForm_Consu_Usuarios.ButtonSalvarClick(Sender: TObject);
var
  super : Integer;
begin
  if CheckBox1.Checked = True then
    begin
      super := 1;
    end
  else super := 0;

  ADOQueryUpdate.Close;
  ADOQueryUpdate.Parameters.ParamByName('SUPER').Value := super;
  ADOQueryUpdate.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryUpdate.ExecSQL;
  Application.MessageBox('Registro alterado com sucesso!','', MB_OK + MB_ICONINFORMATION);
  FormShow(Sender);

end;

procedure TForm_Consu_Usuarios.DBGrid1CellClick(Column: TColumn);
begin

  CodLinha := DBGrid1.Columns[0].Field.AsInteger; // vai mostrar a coluna que voce quer
  ADOQueryRegistroSelecionado.Close;
  ADOQueryRegistroSelecionado.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryRegistroSelecionado.Open;

  EditNome.Text := ADOQueryRegistroSelecionadoNOME.AsString;
  EditCargo.Text := ADOQueryRegistroSelecionadoCARGO.AsString;
  EditUModificacao.Text := ADOQueryRegistroSelecionadoULT_MODIFI.AsString;
  EditDCadastro.Text := ADOQueryRegistroSelecionadoDATA_CADASTRO2.AsString;
  EditLogin.Text := ADOQueryRegistroSelecionadoLOGINUSU.AsString;
  CheckBox1.Checked := ADOQueryRegistroSelecionadoSUPERUSU.AsBoolean;

end;

procedure TForm_Consu_Usuarios.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TForm_Consu_Usuarios.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  CodLinha : string;
begin

  CodLinha := IntToStr(DBGrid1.Columns[0].Field.AsInteger); // vai mostrar a coluna que voce quer
  ADOQueryRegistroSelecionado.Close;
  ADOQueryRegistroSelecionado.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryRegistroSelecionado.Open;

  EditNome.Text := ADOQueryRegistroSelecionadoNOME.AsString;
  EditCargo.Text := ADOQueryRegistroSelecionadoCARGO.AsString;
  EditUModificacao.Text := ADOQueryRegistroSelecionadoULT_MODIFI.AsString;
  EditDCadastro.Text := ADOQueryRegistroSelecionadoDATA_CADASTRO2.AsString;
  EditLogin.Text := ADOQueryRegistroSelecionadoLOGINUSU.AsString;
  CheckBox1.Checked := ADOQueryRegistroSelecionadoSUPERUSU.AsBoolean;

end;

procedure TForm_Consu_Usuarios.DBGrid1TitleClick(Column: TColumn);
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

procedure TForm_Consu_Usuarios.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.Open;
  ADOQuery1.Filtered := False;
  DBGrid1.Enabled := True;
  SearchBox1.Enabled := True;
  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  LabelPesquisar.Caption := DBGrid1.Columns[1].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[1].FieldName;

  ButtonSalvar.Enabled := False;
  ButtonCancelar.Enabled := False;
  ButtonEditar.Enabled := True;
  ButtonExcluir.Enabled := True;
  ButtonNovo.Enabled := True;
  EditNome.Text := '';
  EditCargo.Text := '';
  EditUModificacao.Text := '';
  EditDCadastro.Text := '';
  EditLogin.Text := '';
  CheckBox1.Checked := False;
  CheckBox1.Enabled := False;

  if Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
    end;
end;

procedure TForm_Consu_Usuarios.SearchBox1Change(Sender: TObject);
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

procedure TForm_Consu_Usuarios.SearchBox1InvokeSearch(Sender: TObject);
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
