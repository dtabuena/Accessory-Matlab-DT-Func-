function [Out] = LoadStrcAs(FileNameLoc, SubHeading)
    disp(['Loading ' FileNameLoc '...'])
    load( FileNameLoc )
    if ~exist( 'SubHeading' )
        SubHeading = TempStruct.LoadName;
    end       
    Out = TempStruct.( SubHeading );
    disp(['     done.'])
end