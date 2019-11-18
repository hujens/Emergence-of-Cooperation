function [last_game] = migration()
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

global world
global game

populatedslots = find(world.composition);           % identify populated slots
focal_idx = randsample(populatedslots, world.N);    % sample players from population

[row,col] = ind2sub(size(world.composition),focal_idx); % find coordinates from index
mat_players = [row col];

% Convert the matrix of the coordinates of the players for the game in a
% cell array (num_players x 1).
% (This way we can call the function to compute the new payoff easily for
% all players through cellfun).
cell_players = mat2cell(mat_players,[ones(1,size(mat_players,1))],[size(mat_players,2)]);

% Compute new payoffs for players (and update payoffs map)
last_game.payoffs = cellfun(neighborhood_watch,cell_players);

% Update map of payoffs
% TODO


%% Imitation and migration

% Implement migration policy
if game.migration
    
    %migration_fun =@(p_idx) success_driven_migration(world,migration,p_idx);
    game = cellfun(success_driven_migration, cell_players);
    
    % If imitating another startegy set:
    %   - last_game.migrated(player) = true ; false otherwise
end

% Implement imitation policy
if game.imitation
    % TODO
        
    % If imitating another strategy set:
    %   - last_game.imitated(player) = true ; false otherwise
end


    
end
