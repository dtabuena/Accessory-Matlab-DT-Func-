function [Ur, Sr, Vr ] = RankReduceSVD( U, S, V, R)

        Ur = U(:,1:R);
        Sr = S(1:R,1:R);
        Vr = V(:,1:R);
end