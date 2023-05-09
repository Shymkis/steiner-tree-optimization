format compact
%% Parameters
test = 'irregular 4d';  % Problem to test
num_M = 3;              % Number of movable vertices
num_guesses = 20;       % Number of guesses/restarts
epsilon = 1e-9;         % Termination criterion used by each guess, min difference
max_passes = 100;       % Maximum number of passes for each pass/iteration within each guess
options = optimset('Display', 'off'); % Options for fminunc
%% Algorithm
best_y = Inf;
for g = 1:num_guesses
    g   % Print guess number to track progress
    [F,F_labs,M,M_labs] = generate_vertices(test, num_M);
    num_F = size(F,1);
    V = [F;M];                  % Set of all vertices
    V_labs = [F_labs M_labs];   % All vertex labels

    if g == 1
        steiner_tree(V,V_labs); % Show very first guess
    end

    y_old = Inf;
    for num_passes = 1:max_passes
        for i = (num_F + 1):(num_F + num_M)
            x0 = V(i,:);    % Extract a single movable vertex x0
            V(i,:) = [];    % Remove it from V
            eval = @(x) steiner_tree([V;x],{}); % Eval function based on new V
            [x,y] = fminunc(eval,x0,options);   % Optimize
            before = V(1:i - 1,:);
            after = V(i:end,:);
            V = [before;x;after]; % Reinsert updated vertex x at same index
        end
        if abs(y_old - y) < epsilon % Stop if not much has changed
            break
        end
        y_old = y;
    end
    if y < best_y   % Update y
        best_y = y;
        best_V = V;
    end
end
%% Solution
steiner_tree(best_V,V_labs) % Show final solution