function pth = readLink(pth)
    if iscell(pth)
        pth = cellfun(@wrapperwhich,pth,'UniformOutput',false);
    else
        pth = wrapperwhich(pth);
    end
end

% TODO - make MATLAB's which handle absolute path
function pth = wrapperwhich(pth)
    if isOctave || ~isAbsolutePath(pth), pth = which(pth); end
end

% readLink resolves bare filename on search path
%!test
%! d = tempname();
%! mkdir(d);
%! f = fullfile(d, 'test_readlink.xml');
%! fclose(fopen(f, 'w'));
%! addpath(d);
%! result = readLink('test_readlink.xml');
%! rmpath(d);
%! unlink(f);
%! rmdir(d);
%! assert(strcmp(result, f));

% readLink handles cell array of paths
%!test
%! d = tempname();
%! mkdir(d);
%! f = fullfile(d, 'test_readlink.xml');
%! fclose(fopen(f, 'w'));
%! addpath(d);
%! result = readLink({'test_readlink.xml'});
%! rmpath(d);
%! unlink(f);
%! rmdir(d);
%! assert(strcmp(result{1}, f));
