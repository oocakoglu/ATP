unit untBekleEkrani;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxLabel, jpeg, ExtCtrls;

type
  TfrmBekleEkrani = class(TForm)
    img1: TImage;
    lblMesaj: TcxLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure OpenBekleForm(Baslik :String ='');
procedure CloseBekleForm;

var
  frmBekleEkrani1: TfrmBekleEkrani;

implementation

var
  Counter : integer;
  OldCursor : TCursor;

{$R *.dfm}

procedure OpenBekleForm(Baslik :String ='');
begin
    if frmBekleEkrani1 = nil then
    begin
      frmBekleEkrani1 := TfrmBekleEkrani.Create(Application);

      if Baslik <> '' then
        frmBekleEkrani1.lblMesaj.Caption := Baslik;

      frmBekleEkrani1.Show;

      OldCursor     := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      Application.ProcessMessages;
      Counter := 1;
    end
    else
      inc(Counter);
end;

procedure CloseBekleForm;
begin
    Dec(Counter);
    if Counter < 1 then
    begin
      frmBekleEkrani1.Free;
      frmBekleEkrani1 := nil;
      Screen.Cursor := OldCursor;
    end;
end;

procedure TfrmBekleEkrani.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

initialization
  Counter := 0;

end.
