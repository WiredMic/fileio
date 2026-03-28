function jsonwrite(fname,val)
% Writes JSON files.
%
% FORMAT val = jsonwrite(fname,val)
%
% INPUT
%   fname - (absolut or relative) path to the JSON file.
%   val   - structure to be saved in the JSON file.

    fid = fopen(fname,'w');

    % Pretty print


    strJSON = strreps(jsonencode(val),{'{' '}' '[' ']' ','},{'{$' '$}' '[$' '$]',',$'}); % encode '\n' with '$'
    cellJSON = strsplit(strJSON,'$');
    nInd = 0;
    for l = 1:numel(cellJSON)
        lineJSON{l} = [repmat(' ',1,sum(nInd)) cellJSON{l}];
        if endsWith(cellJSON{l},{'{' '['}), nInd = [nInd numel(cellJSON{l})]; end
        if startsWith(cellJSON{l},{'}' ']' '},' '],'})
            lineJSON{l}(1) = [];
            nInd(end) = [];
        end
    end

    % Write
    fwrite(fid,strjoin(lineJSON,'\n'));
    fclose(fid);
end


% jsonwrite/jsonread round-trip
%!test
%! s.name = 'test';
%! s.value = 42;
%! f = tempname();
%! jsonwrite(f, s);
%! r = jsonread(f);
%! assert(strcmp(r.name, 'test'));
%! assert(r.value == 42);
%! unlink(f);


% jsonread can find files by bare filename on the search path
%!test
%! t.greeting = 'hello';
%! d = tempname();
%! mkdir(d);
%! f = fullfile(d, 'test_jsonread.json');
%! jsonwrite(f, t);
%! addpath(d);
%! x = jsonread('test_jsonread.json');
%! rmpath(d);
%! unlink(f);
%! rmdir(d);
%! assert(strcmp(x.greeting, 'hello'));
  
