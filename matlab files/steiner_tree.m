function [s,T] = steiner_tree(V,V_labs)
    should_plot = false;
    if length(V_labs) == size(V,1) % Don't plot if being used in fminunc
        should_plot = true;
    end
    A = pdist(V);   % Adjacency matrix is simply the pairwise distances
    if should_plot  % Generate graph using adjacency matrix
        G = graph(A,V_labs);
    else
        G = graph(A);
    end
    T = G.minspantree;  % Built-in MATLAB function for MST using Prim's algorithm
    if should_plot
        if size(V,2) > 2
            plot(T,'XData',V(:,1),'YData',V(:,2),'ZData',V(:,3),'EdgeLabel',T.Edges.Weight)
        else
            plot(T,'XData',V(:,1),'YData',V(:,2),'EdgeLabel',T.Edges.Weight)
        end
        axis 'equal'
    end
    s = sum(T.Edges.Weight); % Sum the lengths
end