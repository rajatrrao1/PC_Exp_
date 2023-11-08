
if ~isempty(instrfind('Type', 'serial', 'Name', 'Serial-COM1', 'Status', 'open'))
    fclose(instrfind('Type', 'serial', 'Name', 'Serial-COM1', 'Status', 'open'));
    disp('Serial port "Serial-COM1" closed.');
else
    disp('Serial port "Serial-COM1" is not open or does not exist.');
end