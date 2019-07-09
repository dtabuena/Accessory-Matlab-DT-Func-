function [OrgStruct] = Excel2Struct( XLnameLoc )
    % XLnameLoc = Full File Path and Name as a string eg: 'H:\VglutDataList.xlsx'
    [~,~,Names] = xlsread( XLnameLoc );
    Lables = cellstr(Names(1,:));
    OrgStruct = cell2struct(Names(2:end,:),Lables,2);
end