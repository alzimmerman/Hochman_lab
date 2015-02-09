%Function combines files from first file to last file given the prefix of
%yymdd
function files=combinefiles(prefix,first,last)

files={};

for i=first:last
    name=sprintf('%03.0f.abf', i);
    filename=strcat(prefix,name);
    files=strvcat(files,filename);
end