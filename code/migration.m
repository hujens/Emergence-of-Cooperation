function [last_game] = migration(world,migration)
% Implementation of the migration game.
%
% Three parts:
%   1) play the game and update payoffs
%   2) imitate if imitation is set to True
%   3) migrate if migration is set to True
%
% Inputs:
%   - world: structure with all the info about the evolution of teh system
%   - migration: structure with all the options of interest for the
%           specific type of game
%
% Outputs:
%   - last_game: structure that summarizes teh last game played

populatedslots = find(world.composition);   % identify populated slots
focal_idx = randsample(populatedslots, world.N); % sample players from population

[row,col] = ind2sub(size(world.composition),focal_idx); % find coordinates from index
mat_players = [row col];

% Convert the matrix of the coordinates of the players for the game in a
% cell array (num_players x 1).
% (This way we can call the function to compute the new payoff easily for
% all players through cellfun).
cell_players = mat2cell(mat_players,[ones(1,size(mat_players,1))],[size(mat_players,2)]);

% Compute new payoffs for players (and update payoffs map)
game_fun =@(p_idx) neighborhood_watch(world, migration,p_idx);
last_game.payoffs = cellfun(game_fun,cell_players);

% Update map of payoffs
% TODO


%% Imitation and migration

% NOTE: the order matters, the player can first choose to imitate more
% succesful neighbors, then it can observe if in his mobility range he can
% move to a more profitable area.

% Implement imitation policy
if migration.imitation
    % TODO
    
    
    % If imitating another strategy set:
    %   - last_game.imitated(player) = True ; False otherwise
end

% Implement migration policy
if migration.migration
    % TODO
    
    % If imitating another startegy set:
    %   - last_game.migrated(player) = True ; False otherwise
end

% QUESTION: can a player both imitate and migrate?
    
end
