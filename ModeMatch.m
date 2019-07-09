function  [ModeMatch, BestModeCorrs] = FindModeMatch( CorrMat );

%             CorrMat =  Results(kVal).Replicate(repNum).ModeCorr
                        
            [Bs,Is] = sort( CorrMat ,2,'descend');
            [~, Ix] = sort(Bs(:,1),1,'descend'); 
            Bss = Bs(Ix,:);
            Iss = Is(Ix,:);
            Match = [];
            for rows = 1:size(Iss,1)
                for cols = 1:size(Iss,2);
                    check = ismember(Iss(rows,cols), Match); 
                    if ~check
                        Match(rows) = Iss(rows,cols);
                        break
                    end  
                end
            end

           ModeMatch(Ix) = Match;      
            
           for row = 1:length(ModeMatch(Ix))            
                BestModeCorrs(row) = CorrMat(row, ModeMatch(row) );
           end 

end            
