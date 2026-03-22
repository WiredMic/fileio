function val = jsonread(fname)
% Reads JSON files.
%
% FORMAT val = jsonread(fname)
%
% INPUT
%   fname - path to the JSON file. It can be absolut, relative or only the filename (if in the search path).
%
% OUTPUT
%   val - structure, content of the JSON file.

    fname = readLink(fname);
    fid = fopen(fname,'r');
    val = jsondecode(char(fread(fid,Inf)'));
    fclose(fid);
end

% jsonread reads arbitrary JSON
%!test 
%! f = tempname();
%! fid = fopen(f, 'w');
%! fwrite(fid, '{"name":"test","value":42}');
%! fclose(fid);
%! r = jsonread(f);
%! assert(strcmp(r.name, 'test'));
%! assert(r.value == 42);
%! unlink(f);
