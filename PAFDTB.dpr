program PAFDTB;

{$R *.dres}

uses
  Forms,
  Vcl.Themes,
  Vcl.Styles,
  Setup5 in 'F:\Mina dokument\Niklas\Embarcadero\Studio\Projects\PAFgrafik\Setup5.pas' {SetupForm},
  AkutKalender2 in 'AkutKalender2.pas' {MainForm},
  PassWord in 'PassWord.pas' {PasswordDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSetupForm, SetupForm);
  Application.CreateForm(TPasswordDlg, PasswordDlg);
  Application.Run;

end.
