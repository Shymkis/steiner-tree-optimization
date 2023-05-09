function [D] = pdist(P)
    n = length(P);              % Num points
    D = zeros(n);               % Initialize distance matrix
    pairs = nchoosek(1:n,2);    % generate all index pairs
    for p = pairs'
        i = p(1); j = p(2);
        D(i,j) = norm(P(i,:) - P(j,:)); % Calculate Euclidean norm of their difference
    end
    D = D + D'; % Ensure matrix is full and symmetric
end