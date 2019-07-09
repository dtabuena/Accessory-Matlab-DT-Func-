function [Response] = ByteSize(VarName)
    Rep = whos('VarName');
    Bytes = Rep.bytes;

    Units = {' Bytes', ' KB', ' MB', ' GB', ' TB'};
    Base = log10(Bytes) ./ log10(1024);
    Roundbase = floor(Base);
    Unit = char(Units(Roundbase+1));
    Space = round(Bytes ./ (1024.^Roundbase),3);
    Response =[num2str(Space) Unit];
    disp(Response)
end