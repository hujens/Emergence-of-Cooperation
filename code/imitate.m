function [] = imitate(player_cord)
%   updates the strategy (in world.composition) of the player at idx
%   to the strategy of the highest payoff in its direct neighborhood,
%   if applicable
%
%   Inputs:
%       - world: the current state of the game (class)
%       - idx: the linear index of one individual focal player
%
%   Output:
%       - world: same as above just that we have updated world.composition
%            (could also just return that)

global world
global game

%% Imitate

combs = [-1 -1;
         0 -1;
         1 -1;
         -1 0;
         0 0;
         1 0;
         -1 1;
         0 1;
         1 1;]; % hard coded combinations for neighbors because I couldn't
               % figure out how to do it
%might need to do a check for neative subscripts or do boundary conditions
neighbors_sub = repmat(player_cord,9,1) + combs;
row = neighbors_sub(:,1);
col = neighbors_sub(:,2);
neighbors = sub2ind(size(world.composition),row,col);       %linear indices of the direct neighbors of the focal player
sel = zeros(world.L,world.L);       %blank grid
sel(neighbors) = world.payoff(neighbors);   % creates a matrix as big as the entire grid
%   but only the neighborhood of the focal player being non-zero

[trash, max_idx] = max(sel,[],'all','linear'); % max_idc is the linear index 
%   of maximum value in sel and therefore the index of the maximum payoff
%   in the neighborhood (trash would be the corresponding payoff, can be ignored)

world.composition(idx) = world.composition(max_idx);


end