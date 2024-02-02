//Installation script for GIP packages
  
function InstallWork: string;
begin
  // Do install tasks here.

  {changelog}
  if FileExists(GEOGET_SCRIPTDIR + '\CacheMap\CacheMap.changelog.txt') then ShowLongMessage('Changelog', FileToString(GEOGET_SCRIPTDIR + '\CacheMap\CacheMap.changelog.txt'));

  Result :='';  // probehlo bez chyby
end;
