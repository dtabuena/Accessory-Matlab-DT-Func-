function [AddressName] = SaveStrcAs(DataToSave, VarName, FileSaveName, SaveLoc)
% SaveVarAs( TheDataVariable,
%             Variable Name as String,
%             Name of the .mat to save as string,
%             Save Location as string)
%
% Returns the file loction name; compatible with load()

%%
% 
% if isscalar(DataToSave); 
% 
%     disp('Saving...')
%     TempStruct.(VarName) = DataToSave;
%     AddressName = [SaveLoc '\' FileSaveName '.mat'];
%     save(AddressName, '-struct', 'DataToSave')
%     clc; disp('Saving... done.')
%     disp(AddressName)
% 
% else
%     
    disp('Saving...')
    TempStruct.(VarName) = DataToSave;
    TempStruct.LoadName = VarName;
    AddressName = [SaveLoc '\' FileSaveName '.mat'];
    save(AddressName, 'TempStruct', '-v7.3')
    disp('   done.')
    disp(AddressName)
    
% end
    

end