function [TruePath, TrueShortest, Vmap] = NearestContinous(TargetMap, ValidSource, CurActive,NaiveGraph)

%     %% Debug Var
%     CurDelay = DelayRange(2);
%     TargetMap = TargetMap;
%     ValidSource = Binary(:,:,CurDelay);
%     

    Edgy = fliplr(flipud(filter2(ValidSource,ones(3),'full')))/9;
    SourceEdge = Edgy(2:end-1,2:end-1) < 1 & ValidSource;
    ValidPath = SourceEdge | CurActive;
    
    %% Build Graph
        
    BadNodes = find(ValidPath==0);
%     FilteredConnections =  NaiveConnections; FilteredConnections(:,BadNodes) = 0; FilteredConnections(BadNodes,:) = 0;
%     FilteredGraph = graph( FilteredConnections );
    T = table2array(NaiveGraph.Edges );
    BadEdges = find( ismember(T(:,1), BadNodes) );
    FilteredGraph = rmedge(NaiveGraph,BadEdges);
    
    %% SearchPaths
    TargetIdx = find(TargetMap);
    SourceIdx = find(SourceEdge);
    
    
    
    figure(1); clf;
    A1 = zeros(size(TargetMap));
    A2 = zeros(size(TargetMap));
    A3 = zeros(size(TargetMap));
    A1(TargetIdx) = 1; % R
    A2(SourceIdx) = 1; % G
    A3(ValidPath ) = 1; % B
    imagesc( cat(3,A1,A2,A3));
    drawnow update
    
    Dist = [];
    
    for ii = 1:length(TargetIdx)
        disp([ 'Target ' num2str(ii) ' of ' num2str(length(TargetIdx))]);
        disp([ '(' num2str(length(SourceIdx))  ' sources)']);
        for jj = 1:length(SourceIdx)            
            Ti = TargetIdx(ii);
            Si = SourceIdx(jj);
            [Path{ii,jj}, Dist(ii,jj)] = shortestpath(FilteredGraph,Ti,Si);
        end
    end
    
    %%
    [TrueShortest, TSind] = min(Dist,[],2);
    if prod(size(Dist)) == 0;
        TruePathInd= [];
        Vmap = nan( [size( TargetMap), 1 ]);
        TruePath = {};
    else
        TruePathInd = sub2ind( size(Dist), [1:size(Dist,1)]',  TSind  );
        Vmap = nan( [size( TargetMap), size(Dist,1) ]);    
        for n = 1:size(Dist,1)
            TruePath{n} = Path{TruePathInd(n)};
            if Dist(n) == inf;
                continue
            end
            [i,j] = ind2sub( size(ValidSource),TruePath{n});        
            idx = sub2ind( size(Vmap), i, j , repmat(n, [1, length(i)]) );
            Vmap(idx) = Dist(n);
        end
end
end