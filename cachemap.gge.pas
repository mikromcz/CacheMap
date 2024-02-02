//Export Script

{$INCLUDE cachemap.ggp.pas}

function ExportExtension: string;
begin
  Result := '';
end;

function ExportDescription: string;
begin
  Result := PluginCaption();
end;

function ExportHeader: string;
begin
  Result := '';
end;

function ExportPoint: string;
begin
  Result := '';
  PluginWork;
end;

function ExportAfter(value: string): string;
begin
  Result := '';
  PluginStop;
end; 
