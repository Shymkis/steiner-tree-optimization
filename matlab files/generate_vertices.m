function [F,F_labs,M,M_labs] = generate_vertices(test, num_M)
    switch test
        case 'triangle'
            F = [0 0; 1 0; .5 sqrt(3)/2];
        case 'square'
            F = [0 0; 1 0; 1 1; 0 1];
        case 'pentagon'
            F = [0 0; 1 0; 1.309 .951; .5 1.539; -.309 .951];
        case 'tetrahedron'
            F = [0 0 0; 1 0 0; .5 sqrt(3)/2 0; .5 sqrt(3)/6 sqrt(6)/3];
        case 'cube'
            F = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 1 1; 1 1 1; 1 0 1; 0 0 1];
        case 'irregular 2d'
            F = [1 9.1; -.3 -6.8; -11 0; -9.6 4.2; 6 10];
        case 'irregular 3d'
            F = [1 -2 3; .4 .3 5; -3.7 sqrt(2) -5; 0 .1 -6; 1 8 1];
        case 'irregular 4d'
            F = [1 2 3 -4; -1 -3 5.5 7; 12 -sqrt(5) 2 1; -.9 -12.1 -7 8; 5 5 -3 0];
        otherwise
            warning('Invalid test')
            return
    end
    [num_F,dims] = size(F);     % Number of fixed vertices and dimensions
    F_labs = num2cell('A':char('A' + num_F-1)); % Generate fixed vertex labels
    M_labs = strcat('M',string(1:num_M));       % Generate movable vertex labels
    [l,u] = bounds(F);          % Ensure M is within the bounds of F
    r = rand(num_M,dims);
    M = (u - l).*r + l;         % Set of initially random movable vertices
end