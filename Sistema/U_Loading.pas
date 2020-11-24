unit U_Loading;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Samples.Gauges,
  Vcl.WinXCtrls;

type
  TForm_Loading = class(TForm)
    ActivityIndicator1: TActivityIndicator;
    Gauge1: TGauge;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Loading: TForm_Loading;

implementation

{$R *.dfm}

procedure TForm_Loading.FormShow(Sender: TObject);
begin
  ActivityIndicator1.Animate := True;
end;

procedure TForm_Loading.Timer1Timer(Sender: TObject);
begin

  Gauge1.Progress := Gauge1.Progress + 15;

  if Gauge1.Progress = 100 then
    begin
      Form_Loading.Close;
    end;

end;

end.
