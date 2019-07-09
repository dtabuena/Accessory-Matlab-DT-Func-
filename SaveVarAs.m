function [AddressName] = SaveVarAs(DataToSave, VarName, FileSaveName, SaveLoc)
% SaveVarAs( TheDataVariable,
%             Variable Name as String,
%             Name of the .mat to save as string,
%             Save Location as string)
%
% Returns the file loction name; compatible with load()

%%
disp('Saving...')
TempStruct.(VarName) = DataToSave;
AddressName = [SaveLoc '\' FileSaveName '.mat'];
save(AddressName, '-struct', 'TempStruct', '-v7.3')
clc; disp('Saving... done.')
disp(AddressName)


%%
% disp('Saving...')
% % TempStruct.(VarName) = DataToSave;
% AddressName = [SaveLoc '\' FileSaveName '.mat'];
% save(AddressName, '-struct', 'DataToSave', '-v7.3')
% clc; disp('Saving... done.')
% disp(AddressName)


end